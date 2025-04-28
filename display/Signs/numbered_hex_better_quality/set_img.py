import serial
import os

def transmit_img_num(port, baudrate, img_num):
    try:
        ser = serial.Serial(port, baudrate)
        print(f"Connected to {port} at {baudrate} baud")

        num = int(img_num)
        if (num < 47): 
            ser.write(bytes([num]))
            print(f"Image number set to {bytes([num])}")
        else:
            print(f"Image number too high.")

        print(f"Transmission complete.")

    except serial.SerialException as e:
        print(f"Error opening serial port: {e}")
    finally:
        if ser and ser.is_open:
            ser.close()
            print("Serial port closed.")

if __name__ == "__main__":
    while(1):
        port = "COM9"
        baudrate = 115200
        img_num = input("Enter the image number: ")
        
        transmit_img_num(port, baudrate, img_num)