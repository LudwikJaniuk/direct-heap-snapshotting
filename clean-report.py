import sys

assert(len(sys.argv) == 3)

def clean_line(line):
    firstApo = line.find("'")
    sndApo = len(line[:firstApo+1]) + line[firstApo+1:].find("'")
    firstComma = line.find(',')

    assert(firstApo < sndApo)
    assert(sndApo < firstComma)
    assert(firstApo > 0)
    assert(sndApo > 0)
    assert(firstComma > 0)

    return line[firstApo+1:sndApo]+line[firstComma:]

assert(clean_line("Symbol: 'java/lang/StackStreamFactory$AbstractStackWalker' count 65535, 1, 1, init, 2, 0xfc005838, 0x7feed404f190, \n") == "java/lang/StackStreamFactory$AbstractStackWalker, 1, 1, init, 2, 0xfc005838, 0x7feed404f190, \n")

linesToWrite = []
for line in open(sys.argv[1], 'r'):
    if line[0:7] == "Symbol:":
        linesToWrite.append(clean_line(line))

out_file = open(sys.argv[2], 'w')
out_file.write("".join(linesToWrite))

