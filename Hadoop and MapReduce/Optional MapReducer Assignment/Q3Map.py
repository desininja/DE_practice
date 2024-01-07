#Group By all the records based on payment type and find the count for each group.
#1= Credit card
#2= Cash
#3= No charge
#4= Dispute
#5= Unknown
#6= Voided trip
import sys

for line in sys.stdin:
    line = line.strip()
    line = line.split(',')

    if line[0]=='VendorID' or len(line)<=1:
        continue

    if line[9] == '1':
        print("{}\t1".format('Credit card',1))
    if line[9] == '2':
        print("{}\t1".format('Cash',1))
    if line[9] == '3':
        print("{}\t1".format('No charge',1))
    if line[9] == '4':
        print("{}\t1".format('Dispute',1))
    if line[9] == '5':
        print("{}\t1".format('Unknown',1))
    if line[9] == '6':
        print("{}\t1".format('Voided trip',1))