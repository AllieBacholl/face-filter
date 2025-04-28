def convert_mem_file(input_file, output_file):
    memory = {}
    with open(input_file, 'r') as f:
        current_addr = 0
        for line in f:
            line = line.strip()
            if not line:
                continue
            if line.startswith('@'):
                current_addr = int(line[1:], 16)
            else:
                for byte_str in line.split():
                    memory[current_addr] = byte_str
                    current_addr += 1

    # Create word-aligned output
    start = min(memory.keys())
    end = max(memory.keys())
    aligned_start = start - (start % 4)

    with open(output_file, 'w') as f_out:
        for addr in range(aligned_start, end + 1, 4):
            # Get 4 bytes (little-endian in file, reverse to big-endian)
            word_bytes = [memory.get(addr + i, '00') for i in range(4)]
            word = ''.join(reversed(word_bytes)).upper()
            f_out.write(word + '\n')

    print(f"Converted memory saved to {output_file}")

# Usage
convert_mem_file("compiled.mem", "compiled_c.hex")
