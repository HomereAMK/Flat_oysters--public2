#!/bin/bash
#PBS -d /home/projects/dp_00007/people/hmon/Flat_oysters
#PBS -W group_list=dp_00007 -A dp_00007
#PBS -N HET
#PBS -e HET.err
#PBS -o HET.out
#PBS -l nodes=1:ppn=36:fatnode
#PBS -l walltime=600:00:00
#PBS -l mem=1300gb
#PBS -m n
#PBS -r n

# Load module angsd
module load tools ngs computerome_utils/2.0
module load htslib/1.9
module load bedtools/2.30.0
module load pigz/2.3.4
module load parallel/20210722
module load angsd/0.931


N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Bam_list_21feb22 | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
BAMLIST=/home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Bam_list_21feb22

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -bam $BAMLIST -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*1/4)) -setMaxDepth $((N_IND*10)) -doCounts 1 -doGlf 2 -GL 2 -doMajorMinor 4 -doMaf 1 -doPost 2 -doGeno 2 -dumpCounts 2 -postCutoff 0.95 -doHaploCall 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdPopGen/heterozygosity/GEO_FlatOysters--AllSamples_0.25_SITES

# Generates a `.bed` file based on the `.mafs` file:

zcat /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdPopGen/heterozygosity/GEO_FlatOysters--AllSamples_0.25_SITES.mafs.gz | cut -f1,2 | tail -n +2 | awk '{print $1"\t"$2-1"\t"$2}' | bedtools merge -i - > /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdPopGen/heterozygosity/GEO_FlatOysters--AllSamples_0.25_SITES.bed

# Creates a position file based on this new `.bed`:

awk '{print $1"\t"($2+1)"\t"$3}' /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdPopGen/heterozygosity/GEO_FlatOysters--AllSamples_0.25_SITES.bed > /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdPopGen/heterozygosity/GEO_FlatOysters--AllSamples_0.25_SITES_bed.pos

# Indexs the `.pos` file created above:

angsd sites index /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdPopGen/heterozygosity/GEO_FlatOysters--AllSamples_0.25_SITES_bed.pos

# Runs _ANGSD_ under -doSaf::

parallel --plus angsd -i {} -ref $REF -anc $REF -sites /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdPopGen/heterozygosity/GEO_FlatOysters--AllSamples_0.25_SITES_bed.pos -GL 1 -doSaf 1 -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -out /home/projects/dp_00007/data/hmon/angsd_Het{/...} :::: /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Bam_list_21feb22

# Calculates fractions:

parallel --tmpdir /home/projects/dp_00007/data/hmon/angsd_Het/ --plus "realSFS -fold 1 -P 40 {} > /home/projects/dp_00007/data/hmon/angsd_Het/{/..}.het" ::: /home/projects/dp_00007/data/hmon/angsd_Het/*.saf.idx

# Calculates heterozygosity:

fgrep '.' *.het | tr ":" " " | awk '{print $1"\t"$3/($2+$3)*100}' | sed -r 's/.het//g' | awk '{split($0,a,"_"); print $1"\t"a[1]"\t"$2"\t"$3'} | awk '{split($2,a,"-"); print $1"\t"a[2]"\t"$3'} > /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdPopGen/heterozygosity/GEO_FlatOysters--AllSamples_0.25--HET.txt
