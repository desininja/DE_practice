import sys

for line in sys.stdin:
    line = line.strip(' ')
    line = line.split(',')
    if line[0]=='ID':
        continue
    year = line[1]
    arrDel = line[15]
    depDel = line[16]
    if arrDel == 'NA' or depDel =='NA':
        continue
    arrDel = int(arrDel)
    depDel = int(depDel)

    if arrDel+depDel > 0:
        totalDel = arrDel+depDel

        print("{}\t1\t{}".format(year,totalDel))
