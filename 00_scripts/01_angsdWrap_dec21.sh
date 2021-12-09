#!/bin/bash
#PBS -d /home/projects/dp_00007/people/hmon/Flat_oysters
#PBS -W group_list=dp_00007 -A dp_00007
#PBS -N wrapBigNodeAngsd2
#PBS -e 99_logfiles/angsd_wrap/wrapBigNodeAngsd2.err
#PBS -o 99_logfiles/angsd_wrap/wrapBigNodeAngsd2.out
#PBS -l nodes=2:ppn=30:fatnode
#PBS -l walltime=48:00:00
#PBS -l mem=1300gb
#PBS -m n
#PBS -r n

# Load module angsd
module load tools computerome_utils/2.0
module load htslib/1.13
module load bedtools/2.30.0
module load pigz/2.3.4
module load parallel/20210722
module load angsd/0.935

#var
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
BAMLIST=/home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Bam_list_noRep_curated
OUTPUTDIR=02_angsdOutput/Dataset_I

#script
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 \
-b $BAMLIST -ref $REF -out $OUTPUTDIR/BigN_wrap_cur2 \
-remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -setMaxDepth 1000 -MinMaf 0.015 -SNP_pval 1e-6 \
-GL 2 -doMajorMinor 4 -doMaf 1 -doCounts 1 -doGlf 2 -doPost 2 -doGeno 2 -dumpCounts 2 -postCutoff 0.95 -doHaploCall 1
