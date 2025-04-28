import torch
import torch.nn as nn
import torch.nn.init as init
import torch.quantization

class TinyTrafficSignCNN(nn.Module):
    def __init__(self, num_classes=43):
        super(TinyTrafficSignCNN, self).__init__()

        # Feature extractor
        self.conv1 = nn.Conv2d(1, 8, kernel_size=3, padding=1, bias=False)
        self.relu1 = nn.ReLU()
        self.pool1 = nn.MaxPool2d(2)

        self.conv2 = nn.Conv2d(8, 16, kernel_size=3, padding=1, bias=False)
        self.relu2 = nn.ReLU()
        self.pool2 = nn.MaxPool2d(2)

        self.conv3 = nn.Conv2d(16, 32, kernel_size=3, padding=1, bias=False)
        self.relu3 = nn.ReLU()
        self.pool3 = nn.MaxPool2d(2)

        # Classifier
        self.flatten = nn.Flatten()
        self.fc1 = nn.Linear(32 * 4 * 4, 64, bias=False)
        self.relu_fc = nn.ReLU()
        self.fc2 = nn.Linear(64, num_classes, bias=False)

        # This enables quantization
        self.quant = torch.quantization.QuantStub()
        self.dequant = torch.quantization.DeQuantStub()

    def forward(self, x):
        x = self.quant(x)

        x = self.conv1(x)
        x = self.relu1(x)
        x = self.pool1(x)

        x = self.conv2(x)
        x = self.relu2(x)
        x = self.pool2(x)

        x = self.conv3(x)
        x = self.relu3(x)
        x = self.pool3(x)

        x = self.flatten(x)
        x = self.fc1(x)
        x = self.relu_fc(x)
        x = self.fc2(x)

        x = self.dequant(x)
        return x

    def fuse_model(self):
        # Fuse Conv + ReLU layers (in-place)
        torch.quantization.fuse_modules(self, [['conv1', 'relu1'],
                                               ['conv2', 'relu2'],
                                               ['conv3', 'relu3'],
                                               ['fc1', 'relu_fc']], inplace=True)


# 1) Load your checkpoint (quantized or not)
ckpt = torch.load("/usr/games/quantized_traffic_sign_model.pth", map_location="cpu")
state_dict = ckpt.get("state_dict", ckpt)

# 2) Open the output file
with open("model_params.txt", "w") as f:

    # 3) First dump everything in state_dict *except* the packed FC params
    for name, val in state_dict.items():
        # skip non‐tensors
        if not isinstance(val, torch.Tensor):
            continue

        # skip the packed params for fc1/fc2—they’ll go at the end
        if "fc1._packed_params" in name or "fc2._packed_params" in name:
            continue

        # If it’s quantized, pull out the raw ints
        if hasattr(val, "is_quantized") and val.is_quantized:
            q = val
            raw = q.int_repr().cpu().numpy().ravel()
            qscheme = q.qscheme()

            # header with scale/zero‐point info
            if qscheme in (torch.per_tensor_affine, torch.per_tensor_symmetric):
                f.write(f"# {name} QUANT per_tensor shape={list(q.size())} "
                        f"scale={q.q_scale():.6g} zero_point={q.q_zero_point()}\n")
            elif qscheme in (torch.per_channel_affine, torch.per_channel_symmetric):
                scales = q.q_per_channel_scales().cpu().numpy().tolist()
                zps    = q.q_per_channel_zero_points().cpu().numpy().tolist()
                axis   = q.q_per_channel_axis()
                f.write(f"# {name} QUANT per_channel shape={list(q.size())} "
                        f"axis={axis} scales={scales} zero_points={zps}\n")
            else:
                f.write(f"# {name} QUANT unknown_qscheme={qscheme} shape={list(q.size())}\n")

            # dump raw ints
            f.write(" ".join(map(str, raw.tolist())) + "\n\n")

        else:
            # regular float tensor
            data = val.detach().cpu().numpy()
            shape = list(data.shape)
            f.write(f"# {name} shape={shape}\n")
            if data.ndim == 2:
                # 2-D: print row by row
                for row in data:
                    f.write(" ".join(map(str, row.tolist())) + "\n")
                f.write("\n")
            else:
                # 1-D, 3-D, etc: flatten
                flat = data.ravel().tolist()
                f.write(" ".join(map(str, flat)) + "\n\n")

    # 4) Now re-instantiate your quantized model to pull out fc1/fc2 as true 2-D matrices
    model = TinyTrafficSignCNN(num_classes=43)   # or whatever you used
    # replicate your quant setup
    model.qconfig = torch.quantization.get_default_qconfig("fbgemm")
    model.fuse_model()
    torch.quantization.prepare(model, inplace=True)
    torch.quantization.convert(model, inplace=True)
    model.load_state_dict(state_dict)

    # 5) Extract, dequantize, and dump fc1
    w_q = model.fc1.weight()          # qint8 Tensor [64×(32*4*4)=512]
    w_f = w_q.int_repr().cpu().numpy()
    f.write(f"# fc1.weight float quantized shape={list(w_f.shape)}\n")
    for row in w_f:
        f.write(" ".join(map(str, row.tolist())) + "\n")
    f.write("\n")

    # 6) And fc2
    w_q2 = model.fc2.weight()        # qint8 Tensor [num_classes×64]
    w_f2 = w_q2.int_repr().cpu().numpy()
    f.write(f"# fc2.weight float quantized shape={list(w_f2.shape)}\n")
    for row in w_f2:
        f.write(" ".join(map(str, row.tolist())) + "\n")
    f.write("\n")
