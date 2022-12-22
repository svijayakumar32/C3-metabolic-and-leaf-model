#$ -S /bin/bash
#$ -N gpmain_optimization_job

#$ -l h_vmem=2.5G

source /etc/profile
module add matlab

export MCR_CACHE_ROOT="$TMPDIR/mcrCache"
mkdir -p $MCR_CACHE_ROOT

./gpmain