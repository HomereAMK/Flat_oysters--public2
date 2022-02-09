BEAGLE=$1 # This should be the path to a beagle.gz file that you have used for subset_beagle_by_lg.sh. An example is /workdir/cod/greenland-cod/angsd/bam_list_realigned_mindp161_maxdp768_minind97_minq20.beagle.gz
LGLIST=$2 # This should be the path to a list of LGs or chromosomes that you want to subset by. An example is /workdir/cod/greenland-cod/sample_lists/lg_list.txt



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