PCA-based analyses
================

  - [Genome-wide PCA](#genome-wide-pca)
   - [Missing Data on the Variant Calling](#Missing-Data-on-the-Variant-Calling)
   - [Subsampled](#subsampled)
   - [LD estimation between SNPs](#LD-estimation-between-SNPs)
   - [LD pruning](#LD-pruning)
   - [Pruned SNPs list](#Pruned-SNPs-list)

## Genome-wide-pca
:oyster:    use iqsub for all the following scripts in a separate screen   :oyster:

```
#Get the label list from the bam list
awk '{split($0,a,"/"); print a[9]}' /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Bam_list_13dec21 | awk '{split($0,b,"_"); print b[1]"_"b[2]}' > /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Bam_list_13dec21.labels
```
```
#Get the annotation file 
cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Bam_list_13dec21.labels | awk '{split($0,a,"_"); print $1"\t"a[1]}' > /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Bam_list_13dec21.annot
```
## Missing Data on the Variant Calling 11 560 052 SNPs
##### Gets Real Coverage (_Genotype Likelihoods_):
```
zcat /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdOutput/Dataset_I/Leona20dec21.counts.gz | tail -n +2 | gawk ' {for (i=1;i<=NF;i++){a[i]+=$i;++count[i]}} END{ for(i=1;i<=NF;i++){print a[i]/count[i]}}' | paste /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Bam_list_13dec21.labels - > /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdOutput/Dataset_I/Leona20dec21.GL-RealCoverage.txt
```
##### Gets Missing Data (_Genotype Likelihoods_) 11 560 052 SNPs:
```
N_IND=`wc -l /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Bam_list_13dec21.labels`
zcat /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdOutput/Dataset_I/Leona20dec21.beagle.gz | tail -n +2 | perl /home/projects/dp_00007/apps/Scripts/call_geno.pl --skip 3 | cut -f 4- | awk '{ for(i=1;i<=NF; i++){ if($i==-1)x[i]++} } END{ for(i=1;i<=NF; i++) print i"\t"x[i] }' | paste /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Bam_list_13dec21.labels - | awk '{print $1"\t"$3"\t"$3*100/$N_IND}' > /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdOutput/Dataset_I/Leona20dec21.GL-MissingData.txt
``` 
## Subsampled 11 560 052 SNPs -> 231 200 SNPs
``` 
BASEDIR=/home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdOutput/Dataset_I
 
## Prepare a geno file by subsampling one SNP in every 50 SNPs in the beagle file
zcat $BASEDIR/Leona20dec21.beagle.gz | awk 'NR % 50 == 0' | cut -f 4- | gzip  > $BASEDIR/Leona20dec21.subsamp.50.beagle.gz
## Prepare a pos file by subsampling one SNP in every 50 SNPs in the mafs filre
zcat $BASEDIR/Leona20dec21.mafs.gz | cut -f 1,2 |  awk 'NR % 50 == 0' | sed 's/:/_/g'| gzip > $BASEDIR/Leona20dec21.subsamp.50.pos.gz
``` 


## LD estimation between SNPs 
```
module load tools
module load ngs
module load htslib/1.11
module load angsd/0.935
```
```
## Load modules FOR R AND NGSLD
module load gsl/2.6
module load perl/5.20.1
module load samtools/1.11
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
module load ngstools/20190624
```
```
OUTPUTDIR=02_ngsLDOutput/Dataset_I
/services/tools/ngstools/20190624/ngsLD/ngsLD \
--geno $BASEDIR/Leona20dec21.subsamp.50.beagle.gz \
--pos $BASEDIR/Leona20dec21.subsamp.50.pos.gz \
--probs \
--n_ind 676 \
--n_sites 231201 \
--max_kb_dist 2000 \
--n_threads 16 \
--out $OUTPUTDIR/Leona20dec21.subsamp.50.ld
```
## LD pruning
```
LDFILES=02_ngsLDOutput/Dataset_I/Leona20dec21.subsamp.50.ld
OUTPUTFOLDER=02_ngsLDOutput/Dataset_I/
```
```
perl /services/tools/ngstools/20190624/ngsLD/scripts/prune_graph.pl \
       --in_file $LDFILES \
       --max_kb_dist 2000 \
       --min_weight 0.5 \
       --out $OUTPUTFOLDER/Leona20dec21.subsamp.50.id
```

## Pruned SNPs list

