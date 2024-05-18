f = open('../AES128.srcs/sim_1/new/sbox.mem')

for rowNumber, row in enumerate(f):
    subBytes = row.split()
    for colNumber, byte in enumerate(subBytes):
        print(f"8'h{hex(rowNumber)[2:]}{hex(colNumber)[2:]}: subByte = 8'h{byte};")