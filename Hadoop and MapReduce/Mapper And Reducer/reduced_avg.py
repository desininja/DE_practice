import sys
gender_dict = {}
gender_count, gender_sum = 0, 0
for line in sys.stdin:
    line = line.strip()
    gender, count, age = line.split('\t')
    count, age = int(count), int(age)
    if gender in gender_dict:
        gender_dict[gender][1]+=age
        gender_dict[gender][0]+=count
    else:
        gender_dict[gender] = []
        gender_dict[gender].append(count)
        gender_dict[gender].append(age)
#Reducer
for gender in gender_dict.keys():
    flag = float(gender_dict[gender][1])/float(gender_dict[gender][0])
    print(gender+"\t"+str(flag))