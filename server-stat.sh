#!/bin/bash

#CPU Usage
echo "CPU Usage"
grep 'cpu' /proc/stat | awk 'NR>1 {
    usr += $2; 
    nice += $3; 
    sys += $4; 
    id += $5; 
    iow += $6; 
    irq += $7; 
    sirq += $8; 
    s += $9
} 
END {
    IdleTime = id + iow; 
    ActiveTime = usr + nice + sys + irq + sirq + s; 
    TotalTime = ActiveTime + IdleTime; 
    if (TotalTime > 0) {
        print "Total CPU Usage: "(ActiveTime * 100) / TotalTime"%"}
}'
echo " "


#Memory Usage
echo "Memory Usage"
free -h | awk 'NR==2 {print "Total Memory : " $2 ,
	"\nUsed Memory  : " $3 ,"(" ($3*100)/$2"%)" ,
	"\nFree Memory  : " $4 ,"(" ($4*100/$2"%)")}'
echo " "


#Disk Usage
echo "Disk Usage"
df -h | awk '$NF=="/" {print "Total Disk : " $2 ,
        "\nUsed Disk  : " $3 ,"(" ($3*100)/$2"%)" ,
        "\nFree Disk  : " $4 ,"(" ($4*100/$2"%)")}'
echo " "


#Top 5 Processes by CPU Usage
echo "Top 5 Processes by CPU Usage"
ps aux --sort=-pcpu | head -n 6
echo " "


#Top 5 Processes by Memory Usage
echo "Top 5 Processes by Memory Usage"
ps aux --sort=-pmem | head -n 6
