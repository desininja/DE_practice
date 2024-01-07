#Filter all the records having RatecodeID as 4.

import sys
count=0
for line in sys.stdin:
    line = line.strip()
    line = line.split(",")
    if line[0] =='VendorID' or len(line)<=1:
        continue
    RatecodeID = '4'

    if line[5]==RatecodeID:
        count+=1
print(count)