# Fetch the record having VendorID as '2' AND tpep_pickup_datetime as '2017-10-01 00:15:30'
# AND tpep_dropoff_datetime as '2017-10-01 00:25:11' AND passenger_count as '1' AND trip_distance
# as '2.17'


import sys

for line in sys.stdin:
    line = line.strip(' ')
    pline = line
    line = line.split(',')

    if line[0] == 'VendorID' or len(line) <= 1:
        continue

    VendorID = '2'
    tpep_pickup_datetime = '2017-10-01 00:15:30'
    tpep_dropoff_datetime = '2017-10-01 00:25:11'
    passenger_count = '1'
    trip_distance = '2.17'
    if line[0] == VendorID and line[1] == tpep_pickup_datetime and line[2] == tpep_dropoff_datetime and line[3] == passenger_count and line[4]== trip_distance:
        print(pline)
        #print(line)
