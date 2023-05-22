#$ -S /bin/bash
#$ -N gpmain_potato_job_400_new

#$ -l h_vmem=5G

source /etc/profile
module add matlab/2022a

export MCR_CACHE_ROOT="$TMPDIR/mcrCache"
mkdir -p $MCR_CACHE_ROOT

./gpmain_potato_400_new