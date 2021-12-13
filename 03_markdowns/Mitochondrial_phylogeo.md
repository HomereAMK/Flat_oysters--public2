




````

# Load module angsd
module load tools computerome_utils/2.0
module load htslib/1.14
module load bedtools/2.30.0
module load pigz/2.3.4
module load parallel/20210722
module load angsd/0.935

#allele counts
angsd \
-bam 01_infofiles/list_Mt_12dec21_curated \
-doCounts 1 \
-minQ 20 \
-dumpCounts 4 \
-out 03_results/bam_list_realigned_mtgenome_sorted_filtered_minq20.allele

````

## Get depth count
angsd \
-bam 01_infofiles/list_Mt_12dec21_curated \
-doCounts 1 \
-minQ 20 \
-dumpCounts 2 \
-out 03_results/bam_list_realigned_mtgenome_sorted_filtered_minq20.depth 

```
