import sys
type_dict ={}

for line in sys.stdin:
    line = line.strip()
    type, count = line.split('\t')

    count = int(count)

    if type in type_dict:
        type_dict[type]+=count
    else:
        type_dict[type] = count

for key in type_dict.keys():
    print("{}\t{}".format(key,type_dict[key]))