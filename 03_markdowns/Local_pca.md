## Subset the beagle file: subset_beagle_by_lg.sh
```
# This script is used to subset a genome-wide beagle file into smaller files by linkage groups or chromosomes. 
scp /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdOutput/Dataset_I/Leona20dec21.beagle.gz /home/projects/dp_00007/people/hmon/Flat_oysters/LocalPCA/Dataset_I/
BEAGLE=/home/projects/dp_00007/people/hmon/Flat_oysters/LocalPCA/Dataset_I/Leona20dec21.beagle.gz
LGLIST=/home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/lg_list.txt
N_CORE_MAX=30 # Maximum number of threads to use simulatenously

PREFIX=`echo $BEAGLE | sed 's/\..*//' | sed -e 's#.*/\(\)#\1#'`
BEAGLEDIR=`echo $BEAGLE | sed 's:/[^/]*$::' | awk '$1=$1"/"'`

COUNT=0
for LG in `cat $LGLIST`; do
	if [ ! -s $BEAGLEDIR$PREFIX"_"$LG".beagle.gz" ]; then
		echo "Subsetting "$LG
		zcat $BEAGLE | head -n 1 > $BEAGLEDIR$PREFIX"_"$LG".beagle"
		zcat $BEAGLE | grep $LG"_" >> $BEAGLEDIR$PREFIX"_"$LG".beagle" &
		COUNT=$(( COUNT + 1 ))
		if [ $COUNT == $N_CORE_MAX ]; then
		  wait
		  COUNT=0
		fi
	else
		echo $LG" was already subsetted"
	fi
done

wait 

COUNT=0
for LG in `cat $LGLIST`; do
	if [ ! -s $BEAGLEDIR$PREFIX"_"$LG".beagle.gz" ]; then
		echo "Gzipping "$LG
		gzip $BEAGLEDIR$PREFIX"_"$LG".beagle" &
		COUNT=$(( COUNT + 1 ))
		if [ $COUNT == $N_CORE_MAX ]; then
		  wait
		  COUNT=0
		fi
	fi
done
```

## Split beagle files into smaller windows, each containing a header and the desired number of SNPs
```
# Load module angsd
module load tools computerome_utils/2.0
module load htslib/1.13
module load bedtools/2.30.0
module load pigz/2.3.4
module load parallel/20210722
module load angsd/0.935
#pcangsd
module load anaconda3/2021.11
#
module load gsl/2.6
module load perl/5.20.1
module load imagemagick/7.0.10-13
module load gdal/2.2.3
module load geos/3.8.0
module load jags/4.2.0
module load hdf5
module load netcdf
module load boost/1.74.0
module load openssl/1.0.0
module load lapack
module load udunits/2.2.26
module load proj/7.0.0
module load gcc/10.2.0
module load intel/perflibs/64/2020_update2
module load R/4.0.0
```
```
BEAGLE=/home/projects/dp_00007/people/hmon/Flat_oysters/LocalPCA/Dataset_I/Leona20dec21.beagle.gz
LGLIST=/home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/lg_list.txt
SNP=1000 ## Number of SNPs to include in each window
PC=2 ## Number of PCs to keep for each window
N_CORE_MAX=10 # Maximum number of threads to use simulatenously
PREFIX=`echo $BEAGLE | sed 's/\..*//' | sed -e 's#.*/\(\)#\1#'`
BEAGLEDIR=`echo $BEAGLE | sed 's:/[^/]*$::' | awk '$1=$1"/"'`
```
```
COUNT=0
for LG in `cat $LGLIST`; do
	echo "Splitting "$LG
	zcat $BEAGLEDIR$PREFIX"_"$LG".beagle.gz" | tail -n +2 | split -d --lines $SNP - --filter='bash -c "{ zcat ${FILE%.*} | head -n1; cat; } > $FILE"' $BEAGLEDIR$PREFIX"_"$LG".beagle.x" &
	COUNT=$(( COUNT + 1 ))
  if [ $COUNT == $N_CORE_MAX ]; then
	  wait
	  COUNT=0
	fi
done
```
## Gzip these beagle files
```
COUNT=0
for LG in `cat $LGLIST`; do
	echo "Zipping "$LG
	gzip $BEAGLEDIR$PREFIX"_"$LG".beagle.x"* &
	COUNT=$(( COUNT + 1 ))
  if [ $COUNT == $N_CORE_MAX ]; then
	  wait
	  COUNT=0
	fi
done
```

## Move the beagle files to local_pca directory
```
COUNT=0
for LG in `cat $LGLIST`; do
	echo "Moving "$LG
	mv $BEAGLEDIR$PREFIX"_"$LG".beagle.x"* 	$BEAGLEDIR"local_pca/" &
	COUNT=$(( COUNT + 1 ))
  if [ $COUNT == $N_CORE_MAX ]; then
	  wait
	  COUNT=0
	fi
done
```
## LocalPCA
```
# It will loop through all windowed beagle files in each LG
# For each beagle file, it runs pcangsd first, and then runs an R script (/workdir/genomic-data-analysis/scripts/local_pca_2.R) to process the covariance matrix.  
#For scaffold1  #rerun that no loop
BEAGLE=/home/projects/dp_00007/people/hmon/Flat_oysters/LocalPCA/Dataset_I/Leona20dec21.beagle.gz
BEAGLEDIR=`echo $BEAGLE | sed 's:/[^/]*$::' | awk '$1=$1"/"'`
PREFIX=`echo $BEAGLE | sed 's/\..*//' | sed -e 's#.*/\(\)#\1#'`
LG=1 #change for other scaffold
SNP=1000 ## Number of SNPs to include in each window
PC=2 ## Number of PCs to keep for each window
PCANGSD=/home/projects/dp_00007/apps/pcangsd/pcangsd.py
LOCAL_PCA_2=/home/projects/dp_00007/people/hmon/Flat_oysters/LocalPCA/local_pca_2.R
## Set maximum number of threads to 1
export OMP_NUM_THREADS=1
## Loop through each windowed beagle file in the same linkage group (or chromosome)
#for INPUT in `ls "$BEAGLEDIR""$PREFIX"_scaffold"$LG".beagle.x"*".gz`; do
for INPUT in `ls "$BEAGLEDIR""$PREFIX"_scaffold"$LG".beagle.x*`; do
	## Run pcangsd
	python $PCANGSD -beagle $INPUT -o $INPUT -threads 1
	## Process pcangsd output
	Rscript --vanilla $LOCAL_PCA_2 $INPUT".cov" $PC $SNP $INPUT $LG /home/projects/dp_00007/people/hmon/Flat_oysters/LocalPCA/Dataset_I
done
```

# Inversion PCA
```
cd /home/projects/dp_00007/people/hmon/Flat_oysters
#inversion scaffold8
grep 'scaffold8' /home/projects/dp_00007/people/hmon/Flat_oysters/global_snp_list_Leona20dec21.txt > /home/projects/dp_00007/people/hmon/Flat_oysters/global_snp_list_Leona20dec21.scaffold8.txt
awk '$2 >= 40000000 && $2 <= 60000000' /home/projects/dp_00007/people/hmon/Flat_oysters/global_snp_list_Leona20dec21.scaffold8.txt >> 05_inversions/scaffold8_inv/scaffold8_inversion_snps.txt

#inversion scaffold4
grep 'scaffold4' /home/projects/dp_00007/people/hmon/Flat_oysters/global_snp_list_Leona20dec21.txt > /home/projects/dp_00007/people/hmon/Flat_oysters/global_snp_list_Leona20dec21.scaffold4.txt
awk '$2 >= 0 && $2 <= 13000000' /home/projects/dp_00007/people/hmon/Flat_oysters/global_snp_list_Leona20dec21.scaffold4.txt >> 05_inversions/scaffold4_inv/scaffold4_inversion_snps.txt

#inversion scaffold5
grep 'scaffold5' /home/projects/dp_00007/people/hmon/Flat_oysters/global_snp_list_Leona20dec21.txt > /home/projects/dp_00007/people/hmon/Flat_oysters/global_snp_list_Leona20dec21.scaffold5.txt
awk '$2 >= 0 && $2 <= 25000000' /home/projects/dp_00007/people/hmon/Flat_oysters/global_snp_list_Leona20dec21.scaffold5.txt >> 05_inversions/scaffold5_inv/scaffold5_inversion_snps.txt

# Load module angsd
module load tools ngs computerome_utils/2.0
module load htslib/1.9
module load bedtools/2.30.0
module load pigz/2.3.4
module load parallel/20210722
module load angsd/0.931

#var
for query in scaffold8 scaffold4 scaffold5
do
	REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
	BAMLIST=/home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Bam_list_21feb22
	OUTPUTDIR=/home/projects/dp_00007/people/hmon/Flat_oysters/05_inversions/${query}_inv
	N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Bam_list_21feb22 | wc -l`
	#script
	cd /home/projects/dp_00007/people/hmon/Flat_oysters
	angsd \
	-b $BAMLIST -ref $REF -out  $OUTPUTDIR/${query}_inv \
	-remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -setMaxDepth 1000 -MinMaf 0.015 -SNP_pval 1e-6 -postCutoff 0.95  \
	-GL 2 -doMajorMinor 4 -doMaf 1 -doCounts 1 -doGlf 2 -doPost 2 -doGeno 2 -dumpCounts 2 -doHaploCall 1 -doIBS 1 -doDepth 1 \
	-doCov 1 -makeMatrix 1 -P 12 -sites /home/projects/dp_00007/people/hmon/Flat_oysters/05_inversions/${query}_inv/${query}_inversion_snps.txt
done
```



# Come up with a list of all beagle files
```
ls /home/projects/dp_00007/people/hmon/Flat_oysters/LocalPCA/Dataset_I/*beagle*.gz > /home/projects/dp_00007/people/hmon/Flat_oysters/05_inversions/DatasetI_beagle_list.txt
```
## dist1
```
for BEAGLE in `cat /home/projects/dp_00007/people/hmon/Flat_oysters/LocalPCA/DatasetI_trialbeagle_list_dist1_outlier.txt`; do
 if [ ! -f /home/projects/dp_00007/people/hmon/Flat_oysters/LocalPCA/Leona20dec21.beagle.dist1_outlier ] ; then
    zcat $BEAGLE > /home/projects/dp_00007/people/hmon/Flat_oysters/LocalPCA/Leona20dec21.beagle.dist1_outlier
  else zcat $BEAGLE | tail -n +2 >>/home/projects/dp_00007/people/hmon/Flat_oysters/LocalPCA/Leona20dec21.beagle.dist1_outlier
  fi
done
gzip /home/projects/dp_00007/people/hmon/Flat_oysters/LocalPCA/Leona20dec21.beagle.dist1_outlier
```

## dist2

