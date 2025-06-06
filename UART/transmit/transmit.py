import serial
import os

def transmit_hex_file(port, baudrate, hex_file_path):
    try:
        ser = serial.Serial(port, baudrate)
        print(f"Connected to {port} at {baudrate} baud")

        with open(hex_file_path, 'r') as f:
            for line in f:
                # Remove any leading/trailing whitespace and newline characters
                line = line.strip()

                # Ignore empty lines or comment lines (lines starting with '#')
                if not line or line.startswith('#'):
                    continue

                # Convert the hex string to bytes
                try:
                    data = bytes.fromhex(line)
                except ValueError as e:
                     print(f"Error converting hex string: {line} - {e}")
                     continue
                
                # Transmit the bytes over UART
                ser.write(data)

        print(f"Transmission complete for {hex_file_path}")

    except serial.SerialException as e:
        print(f"Error opening serial port: {e}")
    except FileNotFoundError:
        print(f"Error: Hex file not found at {hex_file_path}")
    finally:
        if ser and ser.is_open:
            ser.close()
            print("Serial port closed.")

if __name__ == "__main__":
    port = input("Enter the serial port (e.g., COM3 or /dev/ttyUSB0): ")
    baudrate = int(input("Enter the baud rate (e.g., 115200): "))
    hex_file_paths = sorted(os.listdir(os.getcwd()))
    print(hex_file_paths)
    for file in hex_file_paths:
        if file.endswith(".txt"):
            transmit_hex_file(port, baudrate, file)