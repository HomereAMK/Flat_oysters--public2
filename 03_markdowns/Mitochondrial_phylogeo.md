## Get depth bam file

````
module load samtools/1.14

#Depth 
for file in $(ls 02_data/realigned/*Mt.bam|sed -e 's/.bam//'|sort -u); do
    samtools depth -aa "$file".bam | cut -f 3 | gzip > "$file"_depth.gz
done

#mv 02_data/realigned/*_depth.gz depths

#Make depth_list
BAMSDEPTH=/home/projects/dp_00007/people/hmon/MitOyster/02_data/realigned/*_depth.gz
ls $BAMSDEPTH > 01_infofiles/list_depth_Mt_12dec21
````
Now run the R script(https://github.com/HomereAMK/MitOyster/blob/main/00_scripts/07_covstats.R)

## Get allele count


````
#Get the bam list
BAMSDEPTH=/home/projects/dp_00007/people/hmon/MitOyster/02_data/realigned/*Mt.bam
ls $BAMSDEPTH > 01_infofiles/list_Mt_12dec21_curated

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
````
angsd \
-bam 01_infofiles/list_Mt_12dec21_curated \
-doCounts 1 \
-minQ 20 \
-dumpCounts 2 \
-out 03_results/bam_list_realigned_mtgenome_sorted_filtered_minq20.depth 

