```
#module load
module load tools computerome_utils/2.0
module load htslib/1.14
module load bedtools/2.30.0
module load pigz/2.3.4
module load parallel/20210722
module load angsd/0.935


```
### First we generate a file with allele frequencies (mafs.gz) and a file with genotype likelihoods (glf.gz).
for query in MOLU ZECE CRES ORIS CORS PONT RIAE MORL USAM TOLL COLN BARR TRAL CLEW RYAN NELL GREV WADD FURI NISS LOGS VENO HALS THIS KALV HFJO RAMS ORNE HYPP LANG BUNN DOLV HAUG HAFR INNE VAGS AGAB OSTR
    do
    angsd -b Jan22--AllSamples_${query}-Fst.list -gl 2 -domajorminor 1 -snp_pval 1e-6 -domaf 1 -minmaf 0.05 -doGlf 3 -out 06_ngsrelate/${query}.ngsrelate
done
### Then we extract the frequency column from the allele frequency file and remove the header (to make it in the format NgsRelate needs)
for query in MOLU ZECE CRES ORIS CORS PONT RIAE MORL USAM TOLL COLN BARR TRAL CLEW RYAN NELL GREV WADD FURI NISS LOGS VENO HALS THIS KALV HFJO RAMS ORNE HYPP LANG BUNN DOLV HAUG HAFR INNE VAGS AGAB OSTR
    do
zcat ${query}.mafs.gz | cut -f5 |sed 1d >${query}.freq
done
### run NgsRelate
/home/projects/dp_00007/people/hmon/Software/ngsRelate/ngsRelate  -g ${query}.glf.gz -n 100 -f ${query}.freq  -O ${query}.newres
```

```
Options:
   -f <filename>       Name of file with frequencies
   -O <filename>       Output filename
   -L <INT>            Number of genomic sites. Must be provided if -f (allele frequency file) is NOT provided 
   -m <INTEGER>        model 0=normalEM 1=acceleratedEM
   -i <UINTEGER>       Maximum number of EM iterations
   -t <FLOAT>          Tolerance for breaking EM
   -r <FLOAT>          Seed for rand
   -R <chr:from-to>    Region for analysis (only for bcf)
   -g gfile            Name of genotypellh file
   -p <INT>            threads (default 4)
   -c <INT>            Should call genotypes instead?
   -s <INT>            Should you swich the freq with 1-freq?
   -F <INT>            Estimate inbreeding instead of estimating the nine jacquard coefficients
   -o <INT>            estimating the 3 jacquard coefficient, assumming no inbreeding
   -v <INT>            Verbose. print like per iteration
   -e <INT>            Errorrates when calling genotypes?
   -a <INT>            First individual used for analysis? (zero offset)
   -b <INT>            Second individual used for analysis? (zero offset)
   -B <INT>            Number of bootstrap replicates for (only for single pairs)
   -N <INT>            How many times to start each pair with random seed?
   -n <INT>            Number of samples in glf.gz
   -l <INT>            minMaf or 1-Maf filter
   -z <INT>            Name of file with IDs (optional)
   -T <STRING>         For -h vcf use PL (default) or GT tag
   -A <STRING>         For -h vcf use allele frequency TAG e.g. AFngsrelate (default)
   -P <filename>       plink name of the binary plink file (excluding the .bed)
```

### Test for inbreeding only
```
#To only estimate inbreeding, use the following command
./ngsrelate -F 1
```