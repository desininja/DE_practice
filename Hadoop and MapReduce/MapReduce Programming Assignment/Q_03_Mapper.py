import sys

for line in sys.stdin:
    line = line.strip()
    line =  line.split(",")
    if len(line)>=2:
        payment_type = line[9]
        count =1
        print('%s\t%s'%(payment_type,count))