#$ -S /bin/bash
#$ -N matlab_job

#$ -l h_vmem=2.5G

source /etc/profile
module add matlab

export MCR_CACHE_ROOT="$TMPDIR/mcrCache"
mkdir -p $MCR_CACHE_ROOT

./twotimes 3.1 > twotimes_output.txt
