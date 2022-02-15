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
SNP=10000 ## Number of SNPs to include in each window
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
#For scaffold4
BEAGLE=/home/projects/dp_00007/people/hmon/Flat_oysters/LocalPCA/Dataset_I/Leona20dec21.beagle.gz
BEAGLEDIR=`echo $BEAGLE | sed 's:/[^/]*$::' | awk '$1=$1"/"'`
PREFIX=`echo $BEAGLE | sed 's/\..*//' | sed -e 's#.*/\(\)#\1#'`
LG=4 #change for other scaffold
SNP=10000 ## Number of SNPs to include in each window
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