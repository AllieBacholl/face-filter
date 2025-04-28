#!/usr/bin/env python3
"""
Parse a memory dump of the form:
    <hex-address> <hex-word>
where address and word are plain hex (e.g. 0000b794 2602deba),
and lay the bytes out in a 3D array [col][row][chan].

Usage:
    python3 parse_mem3d.py <mem_file> <cols> <rows> <chans> [--base BASE_ADDR]

Options:
    --base BASE_ADDR   Starting byte address (hex or decimal). Defaults to 0.
"""
import sys
import argparse

def parse_mem_file(filename):
    mem = {}
    with open(filename, 'r') as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith('#') or line.startswith('//'):
                continue
            parts = line.split()
            if len(parts) < 2:
                continue
            addr_str, word_str = parts[0], parts[1]
            try:
                addr = int(addr_str, 16)
                word = int(word_str, 16)
            except ValueError:
                continue
            # extract 4 bytes (big-endian)
            for b in range(4):
                byte_val = (word >> (8*b)) & 0xFF
                mem[addr + b] = byte_val
    return mem

def build_3d_array(mem, cols, rows, chans, base_addr):
    data = [[[0 for _ in range(chans)] for _ in range(rows)] for _ in range(cols)]
    for c in range(cols):
        for r in range(rows):
            for ch in range(chans):
                offset = ch * (cols * rows) + r * cols + c
                data[c][r][ch] = mem.get(base_addr + offset, 0)
    return data

def main():
    parser = argparse.ArgumentParser(description="Parse memfile into 3D array")
    parser.add_argument('mem_file', help='Memory dump file')
    parser.add_argument('cols', type=int, help='Number of columns')
    parser.add_argument('rows', type=int, help='Number of rows')
    parser.add_argument('chans', type=int, help='Number of channels')
    parser.add_argument('--base', default='0x0', help='Base address (hex or dec), default 0')
    args = parser.parse_args()

    try:
        base_addr = int(args.base, 0)
    except ValueError:
        print(f"Invalid base address: {args.base}", file=sys.stderr)
        sys.exit(1)

    mem = parse_mem_file(args.mem_file)
    array3d = build_3d_array(mem, args.cols, args.rows, args.chans, base_addr)

    for ch in range(args.chans):
        print(f"Channel {ch}:")
        for r in range(args.rows):
            print(f"  Row {r}:")
            for c in range(args.cols):
                print(f"    Column {c}: {array3d[c][r][ch]:02x}", end=' ')
            print()

if __name__ == "__main__":
    main()




