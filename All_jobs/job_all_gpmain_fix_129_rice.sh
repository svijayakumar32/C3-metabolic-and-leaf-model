#$ -S /bin/bash
#$ -N gpmain_rice_optimization_job

#$ -l h_vmem=5G

source /etc/profile
module add matlab/2022a

export MCR_CACHE_ROOT="$TMPDIR/mcrCache"
mkdir -p $MCR_CACHE_ROOT

./gpmain_fix_rice_140
./gpmain_fix_rice_160
./gpmain_fix_rice_180
./gpmain_fix_rice_200
./gpmain_fix_rice_220
./gpmain_fix_rice_240
./gpmain_fix_rice_260
./gpmain_fix_rice_300
./gpmain_fix_rice_320
./gpmain_fix_rice_340
./gpmain_fix_rice_360
./gpmain_fix_rice_380
./gpmain_fix_rice_400
./gpmain_fix_rice_420