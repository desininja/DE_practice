import sys

for line in sys.stdin:
    line = line.strip()
    year, count, delay = line.split('\t')
    print("{}\t{}".format(year, round(float(delay)/float(count),2)))