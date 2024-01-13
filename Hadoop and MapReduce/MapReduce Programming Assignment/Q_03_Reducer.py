import sys

result={}
for line in sys.stdin:
    line = line.strip()
    payment_type,count = line.split('\t')

    if payment_type == 'payment_type':
        continue

    if payment_type in result.keys():
        result[payment_type]+=int(count)
    else:
        result[payment_type]=int(count)

#Reducer:
for payment_type in result.keys():
    print(payment_type + "\t" +str(result[payment_type]))