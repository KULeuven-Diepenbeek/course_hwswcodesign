from sys import argv

fname = argv[1]

with open(fname, "r") as fh:

    for line in fh:
        line = line.rstrip()
        line_int = int(line,2)
        print(chr(line_int), end='')
print("END")