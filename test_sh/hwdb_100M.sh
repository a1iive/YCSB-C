#/bin/bash

workload="workloads/test_workloada.spec"
dbpath="/home/hhs/hwdb/YCSB-C/hwdb"
moreworkloads="workloads/test_workloadc.spec:workloads/test_workloada.spec:workloads/test_workloadb.spec:workloads/test_workloadd.spec:workloads/test_workloade.spec:workloads/test_workloadf.spec:workloads/test_workloadc_uniform.spec"

#./ycsbc -db hwdb -dbpath $dbpath -threads 1 -P $workload -load true -run true -dbstatistics true

#./ycsbc -db hwdb -dbpath $dbpath -threads 1 -P $workload -load true -morerun $moreworkloads -dbstatistics true
if [ -n "$dbpath" ];then
    rm -f $dbpath/*
fi

cmd="./ycsbc -db hwdb -dbpath $dbpath -threads 1 -P $workload -load true -morerun $moreworkloads -dbstatistics true >>out.out 2>&1 "

if [ -n "$1" ];then    #后台运行
cmd="nohup ./ycsbc -db hwdb -dbpath $dbpath -threads 8 -P $workload -load true -morerun $moreworkloads -dbstatistics true >$1 2>&1  &"
echo $cmd >$1
fi


echo $cmd
eval $cmd
