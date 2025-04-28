// #define KERNEL1_PTR 0x00000000
// #define KERNEL2_PTR KERNEL1_PTR + 9*8
// #define KERNEL3_PTR KERNEL2_PTR + 9*8*16
// #define KERNEL4_PTR KERNEL3_PTR + 9*16*32

// #define INOUT1_PTR 0x00001800
// #define INOUT2_PTR INOUT1_PTR + 32*32*32

// #define INPUT1_DIM 1
// #define INPUT1_WIDTH 32
// #define INPUT2_DIM 8
// #define INPUT2_WIDTH 32
// #define INPUT3_DIM 16
// #define INPUT3_WIDTH 32
// #define INPUT4_DIM 32
// #define INPUT4_WIDTH 32

// #define int8_t signed char




// int main()
// {
//     volatile int8_t ernel1 = (volatile int8_t (KERNEL1_PTR);
//     volatile int8_t ernel2 = (volatile uint8_t *)(KERNEL2_PTR);
//     volatile uint8_t *kernel3 = (volatile uint8_t *)(KERNEL3_PTR);
//     volatile uint8_t *inout1 = (volatile uint8_t *)(INOUT1_PTR);
//     volatile uint8_t *inout2 = (volatile uint8_t *)(INOUT2_PTR);
//     int i;
//     int j;
//     int k;
//     int d;
//     int h;
//     int w;
//     for (i = 0; i < 9*8; i++) {
//         kernel1[i] = i%9;
//     }
//     for (i = 0; i < 32*32; i++) {
//         inout1[i] = i%16;
//     }
//     for (i = 0; i < INPUT2_WIDTH; i++) {
//         for (j = 0; j < INPUT2_WIDTH; j++) {
//             for (k = 0; k < INPUT2_DIM; k++) {
//                 inout2[k*INPUT2_WIDTH*INPUT2_WIDTH + j + i*INPUT2_WIDTH] = 0;
//                 for (d = 0; d < INPUT1_DIM; d++) {
//                     for (h = 0; h < 3; h++) {
//                         for (w = 0; w < 3; w++) {
//                             inout2[k*INPUT2_WIDTH*INPUT2_WIDTH + j + i*INPUT2_WIDTH] += kernel1[k*INPUT1_DIM*3*3 + d*3*3 + h*3 + w] * inout1[d*INPUT1_WIDTH*INPUT1_WIDTH + h*INPUT1_WIDTH + w + j + i*INPUT1_WIDTH];
//                         }
//                     }
//                 }
//             }
//         }
//     }
// }
// 00100d13
// 00100d93
// exit program code

#define int8_t signed char
#define uint8_t unsigned char
#define int32_t signed int
#define int64_t signed long long

#define INPUT1_DIM     1
#define INPUT1_WIDTH   32
#define INPUT2_DIM     8
#define INPUT2_WIDTH   32
#define INPUT3_DIM     16
#define KERNEL1_PTR    0x00000000
#define KERNEL2_PTR    0x00000048
#define KERNEL3_PTR    0x000004c8
#define MULT1_PTR      0x000016c8
#define SHIFT1_PTR     0x000016e8
#define MULT2_PTR      0x000016f0
#define SHIFT2_PTR     0x00001710
#define MULT3_PTR      0x00001718
#define SHIFT3_PTR     0x00001738
// TODO: fully connected layers quantization
#define FULLY_CONNECTED_PTR 0x00002000
#define FULLY_CONNECTED2_PTR 0x00012000
#define INOUT1_PTR     0x00012bc0
#define INOUT2_PTR     0x0001abc0
#define PAD          1  // padding size for 3x3 kernel

#define IN_FEATURES  (32*4*4)   // 512
#define OUT_FEATURES 64

void fc1_quant(
    int8_t input_q[IN_FEATURES],     // quantized input already
    int8_t weight_q[OUT_FEATURES * IN_FEATURES], // quantized weight already
    int32_t      input_zp,
    int32_t weight_zp[OUT_FEATURES],
    int32_t multiplier[OUT_FEATURES], // integer multiplier per output channel
    uint8_t shift[OUT_FEATURES],       // right shift amount per output channel
    int32_t      output_zp,
    int8_t       output_q[OUT_FEATURES]
) {
    for (int i = 0; i < OUT_FEATURES; ++i) {
        const int8_t *wrow_q = &weight_q[i * IN_FEATURES];
        int32_t acc = 0;

        for (int j = 0; j < IN_FEATURES; ++j) {
            acc += (int32_t)(input_q[j] - input_zp) * (int32_t)(wrow_q[j] - weight_zp[i]);
        }

        // requantize: acc * multiplier >> shift
        int64_t prod = (int64_t)acc * (int64_t)multiplier[i];
        prod += (int64_t)(1ll << (shift[i] - 1)); // rounding offset
        int32_t scaled = (int32_t)(prod >> shift[i]);

        int32_t y_q = scaled + output_zp;

        // clamp into int8_t
        if (y_q > 127) y_q = 127;
        else if (y_q < -128) y_q = -128;
        output_q[i] = (int8_t)y_q;
    }
}



int8_t requantize(int32_t acc, int32_t multiplier, uint8_t shift, int32_t zero_point) {
    int32_t prod = ((int64_t)acc * multiplier + (1 << (shift - 1))) >> shift;
    int32_t y = prod + zero_point;
    if (y < zero_point) y = zero_point;
    if (y > 127) y = 127;
    return (int8_t)y;
}

 
int main()
{
    volatile int8_t *inout1  = (volatile int8_t *)(INOUT1_PTR);
    volatile int8_t *inout2  = (volatile int8_t *)(INOUT2_PTR);

    volatile int8_t *kernel1  = (volatile int8_t *)(KERNEL1_PTR);
    volatile int32_t *Mult1  = (volatile int32_t *)(MULT1_PTR);
    volatile int8_t *Shift1  = (volatile int8_t *)(SHIFT1_PTR);

    int i, j, k, d, h, w;

    for (i = 0; i < INPUT1_WIDTH*INPUT1_WIDTH; i++) {
        inout1[i] = i % 16;
    }

    // Perform convolution with zero PADding
    int acc = 0;
    for (k = 0; k < INPUT2_DIM; k++) {
        for (i = 0; i < INPUT2_WIDTH; i++) {
            for (j = 0; j < INPUT2_WIDTH; j++) {
                acc = 0;
                // iterate kernel window
                for (h = 0; h < 3; h++) {
                    for (w = 0; w < 3; w++) {
                        // apply zero padding
                        if (i + h - PAD < 0 || i + h - PAD >= INPUT1_WIDTH || j + w - PAD < 0 || j + w - PAD >= INPUT1_WIDTH)
                            continue;
                        acc += kernel1[k * 3 * 3 + h * 3 + w] * inout1[(i + h - PAD) * INPUT1_WIDTH + (j + w - PAD)];
                    }
                }
                inout2[k * INPUT2_WIDTH * INPUT2_WIDTH + i * INPUT2_WIDTH + j] = requantize(acc, Mult1[k], Shift1[k], 0);
            }
        }
    }
    return 0;
}