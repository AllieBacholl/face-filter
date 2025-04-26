import serial

def receive_hex_file(port, baudrate, hex_file_path):
    try:
        ser = serial.Serial(port, baudrate)
        print(f"Connected to {port} at {baudrate} baud")

        # Open serial port and output file
        with open(hex_file_path, 'w') as f:
            print(f"Listening on {port} at {baudrate} baud. Saving to {hex_file_path}...")
            count = 0
            while count < 307200:
                in_bin = ser.read()
                in_int = int.from_bytes(in_bin,byteorder='little')
                print(f"{in_int:02x}")
                f.write(f"{in_int:02x} ")
                count = count + 1
        
        print("Transmission complete.")
    except KeyboardInterrupt:
        print("Stopped by user.")
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
    hex_file_path = input("Enter the path to the hex file output: ")

    receive_hex_file(port, baudrate, hex_file_path)