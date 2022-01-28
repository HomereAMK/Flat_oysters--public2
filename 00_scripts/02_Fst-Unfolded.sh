#!/bin/bash
#PBS -d /home/projects/dp_00007/people/hmon/Flat_oysters
#PBS -W group_list=dp_00007 -A dp_00007
#PBS -N wrapBigNodeAngsd10dec
#PBS -e 99_logfiles/Fst/Unfolded.err
#PBS -o 99_logfiles/Fst/Unfolded.err
#PBS -l nodes=1:ppn=40
#PBS -l walltime=200:00:00
#PBS -l mem=130gb
#PBS -m n
#PBS -r n


# Load module angsd
module load tools computerome_utils/2.0
module load htslib/1.9
module load bedtools/2.30.0
module load pigz/2.3.4
module load parallel/20210722
module load angsd/0.935

#George Pacheco script adapted to Flat oysters dataset
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_CORS-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_CORS-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_CORS

N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_MOLU-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_MOLU-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_MOLU

N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_PONT-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_PONT-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_PONT

# MORL
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_MORL-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_MORL-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_MORL

# USAM
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_USAM-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_USAM-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_USAM

# BARR
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_BARR-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_BARR-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_BARR


# TRAL
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_TRAL-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_TRAL-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_TRAL


# CLEW
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_CLEW-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_CLEW-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_CLEW


# NELL
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_NELL-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_NELL-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_NELL


# RYAN
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_RYAN-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_RYAN-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_RYAN

# NELL
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_NELL-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_NELL-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_NELL

# GREV
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_GREV-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_GREV-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_GREV

# WADD
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_WADD-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_WADD-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_WADD

# LOGS
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_LOGS-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_LOGS-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_LOGS

# HALS
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_HALS-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_HALS-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_HALS

# THIS
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_THIS-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_THIS-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_THIS

# INNE
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_INNE-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_INNE-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_INNE

# HAUG
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_HAUG-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_HAUG-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_HAUG

# HAFR
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_HAFR-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_HAFR-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_HAFR

# OSTR
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_OSTR-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_OSTR-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_OSTR

# VAGS
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_VAGS-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_VAGS-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_VAGS

# LANG
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_LANG-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_LANG-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_LANG

# BUNN
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_BUNN-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_BUNN-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_BUNN

# DOLV
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_DOLV-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_DOLV-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_DOLV

# KALV
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_KALV-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_KALV-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_KALV

# HFJO
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_HFJO-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_HFJO-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_HFJO

# RAMS
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_RAMS-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_RAMS-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_RAMS

# ORNE
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_ORNE-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_ORNE-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_ORNE

# HYPP
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_HYPP-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_HYPP-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_HYPP
