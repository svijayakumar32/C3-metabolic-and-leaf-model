#$ -S /bin/bash
#$ -N gpmain_fix_optimization_job

#$ -l h_vmem=5G

source /etc/profile
module add matlab/2022a

export MCR_CACHE_ROOT="$TMPDIR/mcrCache"
mkdir -p $MCR_CACHE_ROOT

./gpmain_fix_potato_260
./gpmain_fix_potato_240
./gpmain_fix_potato_220
./gpmain_fix_potato_200
./gpmain_fix_potato_300
./gpmain_fix_potato_320
./gpmain_fix_potato_340
./gpmain_fix_potato_360
./gpmain_fix_potato_380
./gpmain_fix_potato_400
./gpmain_fix_potato_420