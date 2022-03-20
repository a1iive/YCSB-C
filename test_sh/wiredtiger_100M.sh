#/bin/bash

workload="workloads/test_workloada.spec"
dbpath="/mnt/nvme0n1/hhs/wiredtiger"
moreworkloads="workloads/test_workloada.spec:workloads/test_workloadb.spec:workloads/test_workloadc.spec:workloads/test_workloadd.spec:workloads/test_workloade.spec:workloads/test_workloadf.spec"
#moreworkloads="workloads/test_workloade10.spec:workloads/test_workloade50.spec:workloads/test_workloade.spec:workloads/test_workloade1000.spec:workloads/test_workloade0.spec"
#moreworkloads="workloads/test_workloadc1.spec:workloads/test_workloadc2.spec:workloads/test_workloadc3.spec:workloads/test_workloadc4.spec:workloads/test_workloadc.spec:workloads/test_workloadc_uniform.spec"
#moreworkloads="workloads/test_workloadc4.spec:workloads/test_workloadc.spec"
#moreworkloads="workloads/test_workloadg.spec:workloads/test_workloadf1.spec:workloads/test_workloadf1_uniform.spec"
#moreworkloads="workloads/test_workloade.spec"
if [ -n "$dbpath" ];then
    rm -f $dbpath/*
fi


if [ -n "$1" ];then    #后台运行
#cmd="nohup ./ycsbc -db wiredtiger -dbpath $dbpath -threads 1 -P $workload -load true -dbstatistics true >>$1 2>&1  &"
cmd="nohup ./ycsbc -db wiredtiger -dbpath $dbpath -threads 1 -P $workload -load true -morerun $moreworkloads -dbstatistics true >$1 2>&1  &"
echo $cmd >$1
fi


echo $cmd
eval $cmd
