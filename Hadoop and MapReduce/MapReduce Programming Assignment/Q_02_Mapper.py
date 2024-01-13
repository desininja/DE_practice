import sys

for line in sys.stdin:
    line = line.strip()
    line = line.split(",")
    #print(line)
    if len(line)>=2:
        if line[5]== '4':
            print(line)