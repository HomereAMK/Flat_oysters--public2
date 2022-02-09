## Subset the beagle file: subset_beagle_by_lg.sh
# This script is used to subset a genome-wide beagle file into smaller files by linkage groups or chromosomes. 
scp /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdOutput/Dataset_I/Leona20dec21.beagle.gz /home/projects/dp_00007/people/hmon/Flat_oysters/LocalPCA/Dataset_I/
BEAGLE=/home/projects/dp_00007/people/hmon/Flat_oysters/LocalPCA/Dataset_I/Leona20dec21.beagle.gz
LGLIST=/home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/lg_list.txt
N_CORE_MAX=10 # Maximum number of threads to use simulatenously

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




BEAGLE=$1 # This should be the path to a beagle.gz file that you have used for subset_beagle_by_lg.sh. An example is /workdir/cod/greenland-cod/angsd/bam_list_realigned_mindp161_maxdp768_minind97_minq20.beagle.gz
LGLIST=01_infofiles/lg_list.txt



## Split beagle files into smaller windows, each containing a header and the desired number of SNPs
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

wait