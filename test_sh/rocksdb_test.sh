#/bin/bash

workload="workloads/workloada.spec"
dbpath="/mnt/nvme0n1/hhs/rocksdb"
#moreworkloads="workloads/workloada.spec:workloads/workloadb.spec:workloads/workloadc.spec:workloads/workloadd.spec:workloads/workloade.spec:workloads/workloadf.spec"
moreworkloads="workloads/workloadc.spec"
#./ycsbc -db rocksdb -dbpath $dbpath -threads 1 -P $workload -load true -run true -dbstatistics true

#./ycsbc -db rocksdb -dbpath $dbpath -threads 1 -P $workload -load true -morerun $moreworkloads -dbstatistics true

if [ -n "$dbpath" ];then
    rm -f $dbpath/*
fi

cmd="./ycsbc -db rocksdb -dbpath $dbpath -threads 8 -P $workload -load true -morerun $moreworkloads -dbstatistics true "
# cmd="./ycsbc -db rocksdb -dbpath $dbpath -threads 1 -P $workload -load true -morerun $moreworkloads "

echo $cmd
eval $cmd
