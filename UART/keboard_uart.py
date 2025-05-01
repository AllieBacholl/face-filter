import serial
import keyboard
import time

# === CONFIGURE THIS ===
SERIAL_PORT = 'COM3'      # or '/dev/ttyUSB0' on Linux/Mac
BAUDRATE    = 115200
# ======================

# Mapping from key to your 4-bit code
direction_map = {
    'w': 0b1000,  # up
    's': 0b0100,  # down
    'a': 0b0010,  # left
    'd': 0b0001,  # right
}

def send_direction(ser, code):
    """Send a single byte containing the 4-bit direction code."""
    ser.write(bytes([code]))
    # optional debug print:
    print(f"[{time.time():.2f}] Sent direction: {code:04b}")

def main():
    # open serial port
    ser = serial.Serial(SERIAL_PORT, BAUDRATE, timeout=0.01)
    print(f"Opened {SERIAL_PORT} @ {BAUDRATE}bps. Press ESC to quit.")

    # keep track of which key "owns" the current direction,
    # so we only zero it when that same key is released
    active_key = None

    def on_press(e):
        nonlocal active_key
        k = e.name.lower()
        if k in direction_map and active_key is None:
            active_key = k
            send_direction(ser, direction_map[k])

    def on_release(e):
        nonlocal active_key
        k = e.name.lower()
        if k == active_key:
            active_key = None
            send_direction(ser, 0x0)

    # hook events
    keyboard.on_press(on_press)
    keyboard.on_release(on_release)

    # wait until user hits ESC
    keyboard.wait('esc')
    ser.close()
    print("Exited.")

if __name__ == "__main__":
    main()
