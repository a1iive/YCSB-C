#/bin/bash

workload="workloads/test_workloadc.spec"
dbpath="/mnt/nvme0n1/hhs/wiredtiger"
moreworkloads="workloads/test_workloada.spec:workloads/test_workloadb.spec:workloads/test_workloadc.spec:workloads/test_workloadd.spec:workloads/test_workloade.spec:workloads/test_workloadf.spec"
#moreworkloads="workloads/test_workloadc.spec:workloads/test_workloada.spec:workloads/test_workloadb.spec:workloads/test_workloadd.spec:workloads/test_workloade.spec:workloads/test_workloadf.spec:workloads/test_workloadc_uniform.spec"
#moreworkloads="workloads/test_workloadc.spec:workloads/test_workloadf_uniform.spec:workloads/test_workloadc_uniform.spec:workloads/test_workloadf.spec"
#moreworkloads="workloads/test_workloadc.spec:workloads/test_workloadc_uniform.spec"
#moreworkloads="workloads/test_workloade10.spec:workloads/test_workloade.spec:workloads/test_workloade1000.spec"
#moreworkloads="workloads/test_workloadc.spec:workloads"

#./ycsbc -db rocksdb -dbpath $dbpath -threads 1 -P $workload -load true -run true -dbstatistics true

#./ycsbc -db rocksdb -dbpath $dbpath -threads 1 -P $workload -load true -morerun $moreworkloads -dbstatistics true

if [ -n "$dbpath" ];then
    rm -f $dbpath/*
fi


if [ -n "$1" ];then    #后台运行
#cmd="nohup ./ycsbc -db wiredtiger -dbpath $dbpath -threads 1 -P $workload -load true -dbstatistics true >>$1 2>&1  &"
cmd="/home/hhs/YCSB-C/ycsbc -db wiredtiger -dbpath $dbpath -threads 1 -P $workload -load true -morerun $moreworkloads -dbstatistics true >$1 2>&1 &"
echo $cmd >$1
fi


echo $cmd
eval $cmd