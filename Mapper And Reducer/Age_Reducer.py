import sys

gender_age={}

for line in sys.stdin:
    line = line.strip()
    gender, age = line.split('\t')

    if gender in gender_age:
        gender_age[gender].append(int(age))

    else:
        gender_age[gender]=[]
        gender_age[gender].append(int(age))


#Reducer:
for gender in gender_age.keys():
    max_age = max(gender_age[gender])
    print(gender + "\t" +str(max_age))