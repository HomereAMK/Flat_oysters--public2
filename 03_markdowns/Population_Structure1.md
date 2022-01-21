PCA-based analyses
================

  - [Genome-wide PCA](#genome-wide-pca)
   - [Missing Data on the Variant Calling](#Missing-Data-on-the-Variant-Calling)
   - [Subsampled](#subsampled)
   - [LD estimation between SNPs](#LD-estimation-between-SNPs)
   - [LD pruning](#LD-pruning)
   - [Pruned SNPs list](#Pruned-SNPs-list)
   - [Reduce the % of Missing Data](#Reduce the % of Missing Data)

## Genome-wide-pca
:oyster:    use iqsub for all the following scripts in a separate screen   :oyster:

```
#Create a Trial Dataset for testing scripts purposes
zcat /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdOutput/Dataset_I/Leona20dec21.beagle.gz | head -n 1001 | gzip > /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdOutput/Dataset_I/Leona20dec21.MyTrialData.beagle.gz


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
N_SITES=`zcat /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdOutput/Dataset_I/Leona20dec21.beagle.gz | tail -n +2 | wc -l`

zcat /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdOutput/Dataset_I/Leona20dec21.beagle.gz | tail -n +2 | perl /home/projects/dp_00007/apps/Scripts/call_geno.pl --skip 3 | cut -f 4- | awk '{ for(i=1;i<=NF; i++){ if($i==-1)x[i]++} } END{ for(i=1;i<=NF; i++) print i"\t"x[i] }' | paste /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Bam_list_13dec21.labels - | awk -v N_INDawk="$N_IND" '{print $1"\t"$3"\t"$3*100/N_INDawk}' > /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdOutput/Dataset_I/Leona20dec21.GL-MissingData.txt
``` 
## Subsampled 11 560 052 SNPs -> 231 200 SNPs
``` 
BASEDIR=/home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdOutput/Dataset_I
OUTPUTFOLDER=/home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I
## Prepare a geno file by subsampling one SNP in every 50 SNPs in the beagle file
zcat $BASEDIR/Leona20dec21.beagle.gz | awk 'NR % 50 == 0' | cut -f 4- | gzip  > $OUTPUTFOLDER/Leona20dec21.subsamp.50.beagle.gz
## Prepare a pos file by subsampling one SNP in every 50 SNPs in the mafs filre
zcat $BASEDIR/Leona20dec21.mafs.gz | cut -f 1,2 |  awk 'NR % 50 == 0' | sed 's/:/_/g'| gzip > $OUTPUTFOLDER/Leona20dec21.subsamp.50.pos.gz
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
OUTPUTDIR=/home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I
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
LDFILES=/home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21.subsamp.50.ld
OUTPUTFOLDER=/home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I
```
```
perl /services/tools/ngstools/20190624/ngsLD/scripts/prune_graph.pl \
       --in_file $LDFILES \
       --max_kb_dist 2000 \
       --min_weight 0.5 \
       --out $OUTPUTFOLDER/Leona20dec21.subsamp.50.id
```

## Pruned SNPs list
SNPs list = 176 432 SNPs
Re-run angsd with the produced Pruned SNPs list with no linked SNPs (--min_weight **0.5**: Minimum weight (in --weight_field) of an edge to assume nodes are connected)

```
# Load module angsd
module load tools ngs computerome_utils/2.0
module load htslib/1.9
module load bedtools/2.30.0
module load pigz/2.3.4
module load parallel/20210722
module load angsd/0.931
```
```
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
BAMLIST=/home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Bam_list_13dec21
OUTPUTDIR=/home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I
SNPlist=/home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21.prunedlist
```

```
angsd sites index $SNPlist

angsd -b $BAMLIST -ref $REF -out $OUTPUTDIR/Leona20dec21_SNPs_11jan22 -sites $SNPlist \
-remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -setMaxDepth 1000 -MinMaf 0.015 -SNP_pval 1e-6 -postCutoff 0.95 \
-GL 2 -doMajorMinor 4 -doMaf 1 -doCounts 1 -doGlf 2 -doPost 2 -doGeno 2 -dumpCounts 2 -doHaploCall 1 -doIBS 1 -doDepth 1 \
-doCov 1 -makeMatrix 1 -P 12
```

## Missing Data on the Variant Calling 195446 SNPs 
##### Gets Real Coverage (_Genotype Likelihoods_):
```
zcat /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22.counts.gz | tail -n +2 | gawk ' {for (i=1;i<=NF;i++){a[i]+=$i;++count[i]}} END{ for(i=1;i<=NF;i++){print a[i]/count[i]}}' | paste /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Bam_list_13dec21.labels - > /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22.GL-RealCoverage.txt
```
##### Gets Missing Data (_Genotype Likelihoods_) 195446 SNPs:
```
N_SITES=`zcat /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22.beagle.gz | tail -n +2 | wc -l`

zcat /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22.beagle.gz | tail -n +2 | perl /home/projects/dp_00007/apps/Scripts/call_geno.pl --skip 3 | cut -f 4- | awk '{ for(i=1;i<=NF; i++){ if($i==-1)x[i]++} } END{ for(i=1;i<=NF; i++) print i"\t"x[i] }' | paste /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Bam_list_13dec21.labels - | awk -v N_INDawk="$N_IND" '{print $1"\t"$3"\t"$3*100/N_INDawk}' > /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22.GL-MissingData.txt
``` 

## Reduce the % of Missing Data
Missing data in the pruned SNPs beagle file ranged from 19% to 92% (because no -minInd filter).
66% of the data with more than 50% of missing data in the pruned SNPs beagle file.
Low confidence in the ngsAdmix or MDS/PCA results.
```
module load tools computerome_utils/2.0
module load gcc/11.1.0
module load intel/perflibs/2020_update4
module load R/4.1.0
```
```
zcat /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22.beagle.gz | tail -n +2 | cut -f 1 | sed -z 's/\n/\t/g' | awk '{print "Sample_ID""\t""Population""\t"$0}' > /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22-HEADER.tsv
zcat /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22.beagle.gz | tail -n +2 | perl /home/projects/dp_00007/apps/Scripts/call_geno.pl --skip 3 | cut -f 4- | awk '
{
    for (i=1; i<=NF; i++)  {
        a[NR,i] = $i
    }
}
NF>p { p = NF }
END {
    for(j=1; j<=p; j++) {
        str=a[1,j]
        for(i=2; i<=NR; i++){
            str=str"\t"a[i,j];
        }
        print str
    }
}' | paste /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Bam_list_13dec21.annot - | cat /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22-HEADER.tsv - | Rscript --vanilla --slave /home/projects/dp_00007/people/geopac/Software/Scripts/TEMP.R -m .25 -e HVAD -p 39 -o /home/projects/dp_00007/people/hmon/Flat_oysters/02_Missingness/Leona20dec21_SNPs_11jan22.25%missingness.list
```
>-m is the maximum missing that allowed. For instance, -m .25 ----> will keep SNPs that have a maximum of 25% of missing data in EACH and ALL populations.
>-p is the number of populations you have.
>-e is the population to exclude.
We will try to get the number of SNPs 
