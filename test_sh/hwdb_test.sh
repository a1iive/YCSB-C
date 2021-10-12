#/bin/bash

workload="workloads/workloada.spec"
dbpath="/home/hhs/hwdb/YCSB-C/hwdb"
moreworkloads="workloads/workloadc.spec:workloads/workloada.spec:workloads/workloadb.spec:workloads/workloadd.spec:workloads/workloade.spec:workloads/workloadf.spec"
# moreworkloads="workloads/workloadc.spec"
#./ycsbc -db hwdb -dbpath $dbpath -threads 1 -P $workload -load true -run true -dbstatistics true

#./ycsbc -db hwdb -dbpath $dbpath -threads 1 -P $workload -load true -morerun $moreworkloads -dbstatistics true


cmd="./ycsbc -db hwdb -dbpath $dbpath -threads 8 -P $workload -load true -dbstatistics true "
#cmd="./ycsbc -db hwdb -dbpath $dbpath -threads 8 -P $workload -load true -morerun $moreworkloads -dbstatistics true "

echo $cmd
eval $cmd
