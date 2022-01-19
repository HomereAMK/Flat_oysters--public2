Admixture-based analyses: Estimation of Individual Ancestries.
================

  - [NGSadmix](#NGSadmix)
   - [](#)
  - [](#)
  - [](#)
   - [](#)
  - [](#)

## NGSadmix
:oyster:    use iqsub for all the following scripts in a separate screen   :oyster:

_Runs ngsAdmix--v32 on the .beagle file using the wrapper_ngsAdmix:
_
```
# Load module angsd
module load tools
module load ngs
module load htslib/1.11
module load angsd/0.935

# Load modules for PCAngsd
module load anaconda2/4.4.0
module load pcangsd/20190125

#Load module for R
module load gsl/2.6
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

# We also need ngsTools +ngsadmix
module load perl/5.30.2         
module load samtools/1.11
module load ngstools/20190624
module load ngsadmix/32
```
> used to do it with a loop... but it takes so long that I decided to run each individual K separately.
```
#wrapper_ngsAdmix on a Trial Dataset for testing scripts purposes
#used to do it with a loop... but it takes so long that I decided to run each individual K separately.
/home/projects/dp_00007/apps/Scripts/wrapper_ngsAdmix.sh -P 40 -debug 1 -likes /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdOutput/Dataset_I/Leona20dec21.MyTrialData.beagle.gz -K 2 -minMaf 0 -tol 1e-6 -tolLike50 1e-3 -maxiter 10000 -o /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsAdmixOutput/Trial/Leona20dec21.MyTrialData--AllSamples.2
```

```
#wrapper_ngsAdmix with 11M snps datasets "Leona20dec21"
/home/projects/dp_00007/apps/Scripts/wrapper_ngsAdmix.sh -P 40 -debug 1 -likes /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdOutput/Dataset_I/Leona20dec21.beagle.gz -K 2 -minMaf 0 -tol 1e-6 -tolLike50 1e-3 -maxiter 10000 -o /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsAdmixOutput/Trial/Leona20dec21.MyTrialData--AllSamples.2
```

#ngsAdmix (no wrapper) on a Trial Dataset for testing scripts purposes
```
BEAGLE=/home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdOutput/Dataset_I/Leona20dec21.MyTrialData.beagle.gz
OUTPUT=/home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsAdmixOutput/Trial/Leona20dec21.MyTrialData--AllSamples.9
K=9
/services/tools/ngsadmix/32/NGSadmix -likes "$BEAGLE" -K "$K" -outfiles "$OUTPUT" -P 28
```
#plot with ngstools Rscript
```
Rscript /services/tools/ngstools/20190624/Scripts/plotAdmix.R -i "$OUTPUT" -o "$OUTPUT".pdf &> /dev/null
Rscript /services/tools/ngstools/20190624/Scripts/plotAdmix.R -i /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsAdmixOutput/Trial/Leona20dec21.MyTrialData--AllSamples.2 -o /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsAdmixOutput/Trial/Leona20dec21.MyTrialData--AllSamples.2.pdf &> /dev/null
```
#With Unpruned Dataset (11M SNPs)
```
BEAGLE=/home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdOutput/Dataset_I/Leona20dec21.beagle.gz
OUTPUT=/home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsAdmixOutput/Dataset_I/Leona20dec21.2
K=2
/services/tools/ngsadmix/32/NGSadmix -likes "$BEAGLE" -K "$K" -outfiles "$OUTPUT" -P 28
```

#wrapper_ngsAdmix on a pruned Dataset (195446 SNPs)
```
/home/projects/dp_00007/apps/Scripts/wrapper_ngsAdmix.sh -P 40 -debug 1 -likes /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22.beagle.gz -K 2 -minMaf 0 -tol 1e-6 -tolLike50 1e-3 -maxiter 10000 -o /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22-AllSamples.2
```
```
/home/projects/dp_00007/apps/Scripts/wrapper_ngsAdmix.sh -P 40 -debug 1 -likes /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22.beagle.gz -K 3 -minMaf 0 -tol 1e-6 -tolLike50 1e-3 -maxiter 10000 -o /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22-AllSamples.3
```
```
/home/projects/dp_00007/apps/Scripts/wrapper_ngsAdmix.sh -P 40 -debug 1 -likes /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22.beagle.gz -K 4 -minMaf 0 -tol 1e-6 -tolLike50 1e-3 -maxiter 10000 -o /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22-AllSamples.4
```
```
/home/projects/dp_00007/apps/Scripts/wrapper_ngsAdmix.sh -P 40 -debug 1 -likes /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22.beagle.gz -K 5 -minMaf 0 -tol 1e-6 -tolLike50 1e-3 -maxiter 10000 -o /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22-AllSamples.5
```
```
/home/projects/dp_00007/apps/Scripts/wrapper_ngsAdmix.sh -P 40 -debug 1 -likes /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22.beagle.gz -K 6 -minMaf 0 -tol 1e-6 -tolLike50 1e-3 -maxiter 10000 -o /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22-AllSamples.6
```
```
/home/projects/dp_00007/apps/Scripts/wrapper_ngsAdmix.sh -P 40 -debug 1 -likes /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22.beagle.gz -K 7 -minMaf 0 -tol 1e-6 -tolLike50 1e-3 -maxiter 10000 -o /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22-AllSamples.7
```
```
/home/projects/dp_00007/apps/Scripts/wrapper_ngsAdmix.sh -P 40 -debug 1 -likes /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22.beagle.gz -K 8 -minMaf 0 -tol 1e-6 -tolLike50 1e-3 -maxiter 10000 -o /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22-AllSamples.8
```
```
/home/projects/dp_00007/apps/Scripts/wrapper_ngsAdmix.sh -P 40 -debug 1 -likes /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22.beagle.gz -K 9 -minMaf 0 -tol 1e-6 -tolLike50 1e-3 -maxiter 10000 -o /home/projects/dp_00007/people/hmon/Flat_oysters/02_ngsLDOutput/Dataset_I/Leona20dec21_SNPs_11jan22-AllSamples.9
```
