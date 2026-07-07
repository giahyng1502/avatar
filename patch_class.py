import sys

def patch(filename, old_str, new_str):
    with open(filename, 'rb') as f:
        data = bytearray(f.read())
    
    old_bytes = old_str.encode('utf-8')
    new_bytes = new_str.encode('utf-8')
    
    # Construct the CONSTANT_Utf8_info structure
    # 01 (tag) + length (u2) + bytes
    old_pattern = b'\x01' + len(old_bytes).to_bytes(2, 'big') + old_bytes
    new_pattern = b'\x01' + len(new_bytes).to_bytes(2, 'big') + new_bytes
    
    count = data.count(old_pattern)
    print(f"Found {count} occurrences of '{old_str}' in {filename}")
    
    if count > 0:
        data = data.replace(old_pattern, new_pattern)
        with open(filename, 'wb') as f:
            f.write(data)
        print("Patched successfully!")

patch('Avatar258_client_source/main/GameMidlet.class', '127.0.0.1', '54.255.161.217')
