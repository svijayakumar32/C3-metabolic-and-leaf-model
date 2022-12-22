#$ -S /bin/bash
#$ -N gpmain_200_rice_job

#$ -l h_vmem=5G

source /etc/profile
module add matlab/2022a

export MCR_CACHE_ROOT="$TMPDIR/mcrCache"
mkdir -p $MCR_CACHE_ROOT

./gpmain_fix_rice_200