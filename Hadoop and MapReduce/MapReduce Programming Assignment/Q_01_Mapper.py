import sys

for line in sys.stdin:
    line = line.strip()
    line = line.split(",")
    #print(line)
    if line[0]== '2' and line[1]=='2017-10-01 00:15:30' and line[2]=='2017-10-01 00:25:11' and line[3]=='1' and line[4]=='2.17':
        print(line)
        