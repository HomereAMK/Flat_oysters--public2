#!/bin/bash
#PBS -d /home/projects/dp_00007/people/hmon/Flat_oysters
#PBS -W group_list=dp_00007 -A dp_00007
#PBS -N wrapBigNodeAngsd
#PBS -e 99_logfiles/angsd/BigNodeAngsd.err
#PBS -o 99_logfiles/angsd/BigNodeAngsd.out
#PBS -l nodes=1:ppn=40:fatnode
#PBS -l walltime=600:00:00
#PBS -l mem=1300gb
#PBS -m n
#PBS -r n

# Load module angsd
module load tools computerome_utils/2.0
module load htslib/1.9
module load bedtools/2.30.0
module load pigz/2.3.4
module load parallel/20210722
module load angsd/0.935

#var
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
BAMLIST=/home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Bam_list_noRep_curated
OUTPUTDIR=02_angsdOutput/Dataset_I

#script
angsd \
-b $BAMLIST -ref $REF -out  $OUTPUTDIR/BigN_cur \
-remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -setMaxDepth 1000 -MinMaf 0.015 -SNP_pval 1e-6 -postCutoff 0.95 \
-GL 2 -doMajorMinor 4 -doMaf 1 -doCounts 1 -doGlf 2 -doPost 2 -doGeno 2 -dumpCounts 2 -doHaploCall 1 -doIBS 1 -doQsDist 1 -doDepth 1 \
-doCov 1 -makeMatrix 1 -P 36