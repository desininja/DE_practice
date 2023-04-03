import sys
# input comes from STDIN (standard input)
for line in sys.stdin:
    line = line.strip()
    line = line.split(",")
    if len(line) >=2:
        gender = line[1]
        age = line[2]
        print ('%s\t1\t%s' % (gender, age))