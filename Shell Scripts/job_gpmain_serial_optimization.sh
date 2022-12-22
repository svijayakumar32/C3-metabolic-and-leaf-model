#$ -S /bin/bash

#$ -q serial
#$ -N gpmain_serial_optimization_job
#$ -t 1-12:1

#$ -l h_vmem=2.5G

source /etc/profile
module add matlab/2022a

echo Job task $SGE_TASK_ID 

export MCR_CACHE_ROOT="$TMPDIR/mcrCache"
mkdir -p $MCR_CACHE_ROOT

./gpmain_new < input$SGE_TASK_ID.txt
