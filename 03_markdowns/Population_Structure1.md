PCA-based analyses
================

  - [Genome-wide PCA](#genome-wide-pca)
   - [Subsampled](#subsampled)
   - [LD estimation between SNPs](#LD-estimation-between-SNPs)
   - [LD pruning](#LD-pruning)
   - [Pruned SNPs list](#Pruned-SNPs-list)

## Genome-wide-pca
:oyster:    use iqsub for all the following scripts in a separate screen   :oyster:
## Subsampled
``` 
BASEDIR=02_angsdOutput/Dataset_I

## Prepare a geno file by subsampling one SNP in every 50 SNPs in the beagle file
zcat $BASEDIR/BigN_wrap_nrep.beagle.gz | awk 'NR % 50 == 0' | cut -f 4- | gzip  > $BASEDIR/BigN_wrap_nrep.subsamp.50.beagle.gz
## Prepare a pos file by subsampling one SNP in every 50 SNPs in the mafs filre
zcat $BASEDIR/BigN_wrap_nrep.mafs.gz | cut -f 1,2 |  awk 'NR % 50 == 0' | sed 's/:/_/g'| gzip > $BASEDIR/BigN_wrap_nrep.subsamp.50.pos.gz
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
OUTPUTDIR=02_ngsLDOutput
/services/tools/ngstools/20190624/ngsLD/ngsLD \
--geno $BASEDIR/BigN_wrap_nrep.subsamp.50.beagle.gz \
--pos $BASEDIR/BigN_wrap_nrep.subsamp.50.pos.gz \
--probs \
--n_ind ? \
--n_sites ? \
--max_kb_dist ? \
--n_threads ? \
--out $OUTPUTDIR/BigN_wrap_nrep.subsamp.50.ld
```
## LD pruning
```
LDFILES=02_ngsLDOutput/BigN_wrap_nrep.subsamp.50.ld
OUTPUTFOLDER=02_ngsLDOutput
```
```
perl /services/tools/ngstools/20190624/ngsLD/scripts/prune_graph.pl \
       --in_file $LDFILES \
       --max_kb_dist 2000 \
       --min_weight 0.5 \
       --out $OUTPUTFOLDER/BigN_wrap_nrep.subsamp.50.id
```

## Pruned SNPs list

