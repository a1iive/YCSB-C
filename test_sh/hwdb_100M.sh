#/bin/bash

workload="workloads/test_workloadc.spec"
dbpath="/mnt/nvme0n1/hhs/hwdb"
#dbpath="/home/hhs/YCSB-C/hwdb"
#moreworkloads="workloads/test_workloada.spec:workloads/test_workloadb.spec:workloads/test_workloadc.spec:workloads/test_workloadd.spec:workloads/test_workloade.spec:workloads/test_workloadf.spec"
#moreworkloads="workloads/test_workloadc.spec:workloads/test_workloadf_uniform.spec:workloads/test_workloadc_uniform.spec:workloads/test_workloadf.spec"
#moreworkloads="workloads/test_workloada.spec:workloads/test_workloadb.spec:workloads/test_workloadc.spec:workloads/test_workloadc_uniform.spec"
moreworkloads="workloads/test_workloade10.spec:workloads/test_workloade50.spec:workloads/test_workloade.spec:workloads/test_workloade1000.spec:workloads/test_workloade0.spec"
#moreworkloads="workloads/test_workloadf.spec:workloads/test_workloadf_uniform.spec"
if [ -n "$dbpath" ];then
    rm -f $dbpath/*
fi

cmd="./ycsbc -db hwdb -dbpath $dbpath -threads 1 -P $workload -load true -morerun $moreworkloads -dbstatistics true >>out.out 2>&1 "

if [ -n "$1" ];then    #后台运行
cmd="nohup ./ycsbc -db hwdb -dbpath $dbpath -threads 16 -P $workload -run true  >$1 2>&1  &"
#cmd="nohup ./ycsbc -db hwdb -dbpath $dbpath -threads 4 -P $workload -load true -dbstatistics true >>$1 2>&1  &"
echo $cmd >$1
fi


echo $cmd
eval $cmd
