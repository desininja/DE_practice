import sys
sum =0
for line in sys.stdin:
    line = line.strip()
    word, count = line.split('\t')
    count = int(count)

    sum+=count

print(sum)

