import serial
import numpy as np
from PIL import Image
import time

def hex_to_image(hex_file_path, width, height, save_path):
    # Step 1: Read the hex file and convert to bytes
    byte_array = bytearray()
    with open(hex_file_path, 'r') as f:
        for line in f:
            line = line.strip()
            if line:  # Skip empty lines
                bytes_line = bytes.fromhex(line)
                byte_array.extend(bytes_line)

    # Step 2: Make sure we have enough data
    expected_size = width * height
    if len(byte_array) < expected_size:
        raise ValueError(f"Not enough data: got {len(byte_array)}, expected {expected_size}")
    elif len(byte_array) > expected_size:
        byte_array = byte_array[:expected_size]  # Trim extra data

    # Step 3: Convert to NumPy array and reshape
    img_array = np.frombuffer(byte_array, dtype=np.uint8).reshape((height, width))

    # Step 4: Convert to PIL image and save as JPEG
    img = Image.fromarray(img_array, mode='L')  # 'L' = 8-bit pixels, black and white
    img.save(save_path, 'JPEG')
    print(f"Image saved to {save_path}")


if __name__ == "__main__":
    hex_to_image("test.txt", 640, 480, "test.jpg")
