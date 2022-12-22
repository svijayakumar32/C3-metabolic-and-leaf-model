#$ -S /bin/bash
#$ -N gpmain_rice_280_optimization_job

#$ -l h_vmem=5G

source /etc/profile
module add matlab/2022a

export MCR_CACHE_ROOT="$TMPDIR/mcrCache"
mkdir -p $MCR_CACHE_ROOT

./gpmain_280_rice
