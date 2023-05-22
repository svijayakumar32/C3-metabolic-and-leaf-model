#$ -S /bin/bash
#$ -N gpmain_potato_job_all

#$ -l h_vmem=5G

source /etc/profile
module add matlab/2022a

export MCR_CACHE_ROOT="$TMPDIR/mcrCache"
mkdir -p $MCR_CACHE_ROOT

./gpmain_potato_all 140 
./gpmain_potato_all 160 
./gpmain_potato_all 180
./gpmain_potato_all 200
./gpmain_potato_all 220
./gpmain_potato_all 240
./gpmain_potato_all 260
./gpmain_potato_all 280
./gpmain_potato_all 300
./gpmain_potato_all 320
./gpmain_potato_all 340
./gpmain_potato_all 360
./gpmain_potato_all 380
./gpmain_potato_all 400
./gpmain_potato_all 420