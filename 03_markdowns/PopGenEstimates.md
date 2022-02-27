PopGenestimates:
Thetas, Tajima, Neutrality tests estimations from angsd for each populations.
================

  - [Load module angsd.](#load-module-angsd.)
  - [Runs ANGSD under -doSaf on all populations.](#Runs-ANGSD-under-doSaf-on-all-populations,-estimate-the-site-allele-frequency-likelihood-for-each-pop.)
  - [Run realSFS, site frequency spectrum.](#Run-realSFS,-site-frequency-spectrum.)
  - [Run saf2theta, calculate the thetas for each site.](#Run-saf2theta,-calculate-the-thetas-for-each-site.)
  - [Run thetaStat print, get summary of Thetas](#Run-thetaStat-print,-get-summary-of-Thetas)
  - [Run the R script GetsThetaSummaries.R, get summary for all pop](#Run-the-R-script-GetsThetaSummaries.R,-get-summary-for-all-pop)
  - [Run do_stat, get the fixed window thetas, -win 15kb -step 15kb](#Run-do_stat,-get-the-fixed-window-thetas,--win-15kb--step-15kb)
  - [Run do_stat, get per-chromosome average theta](#Run-do_stat,-get-per-chromosome-average-theta) 




## Load module angsd.
```
module load tools computerome_utils/2.0
module load htslib/1.14
module load bedtools/2.30.0
module load pigz/2.3.4
module load parallel/20210722
module load angsd/0.935
```

## Runs ANGSD under -doSaf on all populations, estimate the site allele frequency likelihood for each pop.
```
#first version
POP=("ORIS" "CORS" "MOLU" "ZECE" "CRES" "PONT" "RIAE" "MORL" "USAM" "TOLL" "COLN" "BARR" "TRAL" "CLEW" "NELL" "RYAN" "GREV" "WADD" "FURI" "NISS" "LOGS" "VENO" "HALS" "THIS" "INNE" "HAUG" "HAFR" "AGAB" "OSTR" "VAGS" "LANG" "BUNN" "DOLV" "KALV" "HFJO" "RAMS" "ORNE" "HYPP")
for i1 in `seq 0 $((${#POP[@]}-2))`
    do
        pop1="${POP[i1]}"
        N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_${POP[i1]}-Fst.list | wc -l`
        REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
            /home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_${POP[i1]}-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${POP[i1]}
    done
done
```
```
#second version
for query in MOLU ZECE CRES ORIS CORS PONT RIAE MORL USAM TOLL COLN BARR TRAL CLEW RYAN NELL GREV WADD FURI NISS LOGS VENO HALS THIS KALV HFJO RAMS ORNE HYPP LANG BUNN DOLV HAUG HAFR INNE VAGS AGAB OSTR
    do
        N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_${query}-Fst.list | wc -l`
        REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta 
            /home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_${query}-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 \
            -out /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}
done
```

## Run realSFS, site frequency spectrum.
```
for query in MOLU ZECE CRES ORIS CORS PONT RIAE MORL USAM TOLL COLN BARR TRAL CLEW RYAN 
do
    realSFS -P 40 -fold 1 /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}.saf.idx > /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}.sfs
done
for query in NELL GREV WADD FURI NISS LOGS VENO HALS THIS KALV HFJO RAMS ORNE HYPP LANG BUNN DOLV HAUG HAFR INNE VAGS AGAB OSTR
do
    realSFS -P 40 -fold 1 /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}.saf.idx > /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}.sfs
done


```
$$$$$$$$$$$$$$$$$$$$$$$$$$
## Run saf2theta, calculate the thetas for each site.
```
for query in MOLU ZECE CRES ORIS CORS PONT RIAE MORL USAM TOLL COLN BARR TRAL CLEW RYAN NELL GREV WADD FURI NISS LOGS VENO HALS THIS KALV HFJO RAMS ORNE HYPP LANG BUNN DOLV HAUG HAFR INNE VAGS AGAB OSTR
do
    realSFS saf2theta /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}.saf.idx \
    -sfs /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}.sfs \
    -fold 1 -outname /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}_PopGenEstimates
done
```

## Run thetaStat print, get summary of Thetas per pop
```
for query in MOLU ZECE CRES ORIS CORS PONT RIAE MORL USAM TOLL COLN BARR TRAL CLEW RYAN NELL GREV WADD FURI NISS LOGS VENO HALS THIS KALV HFJO RAMS ORNE HYPP LANG BUNN DOLV HAUG HAFR INNE VAGS AGAB OSTR
do
    thetaStat print /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}_PopGenEstimates.thetas.idx > /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}_PopGenEstimates.Print
done
```
## Run the R script GetsThetaSummaries.R, get summary for all pop

```
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
```


```
for query in MOLU ZECE CRES ORIS CORS PONT RIAE MORL USAM TOLL COLN BARR TRAL CLEW RYAN NELL GREV WADD FURI NISS LOGS VENO HALS THIS KALV HFJO RAMS ORNE HYPP LANG BUNN DOLV HAUG HAFR INNE VAGS AGAB OSTR
do
     N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_${query}-Fst.list | wc -l`
     Rscript --vanilla --slave /home/projects/dp_00007/apps/Scripts/GetsThetaSummaries.R /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}_PopGenEstimates.Print $N_IND $query
done > /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdPopGen/Dataset_I/ThetaSummaries_Feb22--Unfolded_PopGen_ALLpop.PopGenEstimates.txt
```

## Run do_stat, get the fixed window thetas, -win 15kb -step 15kb
```
for query in MOLU ZECE CRES ORIS CORS PONT RIAE MORL USAM TOLL COLN BARR TRAL CLEW RYAN NELL GREV WADD FURI NISS LOGS VENO HALS THIS KALV HFJO RAMS ORNE HYPP LANG BUNN DOLV HAUG HAFR INNE VAGS AGAB OSTR
do
    thetaStat do_stat /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}_PopGenEstimates.thetas.idx -win 15000 -step 15000 -outnames /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdPopGen/Dataset_I/window/Feb22--Unfolded_PopGen_${query}_PopGenEstimates-Windows15kb-Steps15kb
done
```

for query in MOLU ZECE CRES ORIS CORS PONT RIAE MORL USAM TOLL COLN BARR TRAL CLEW RYAN NELL GREV WADD FURI NISS LOGS VENO HALS THIS KALV HFJO RAMS ORNE HYPP LANG BUNN DOLV HAUG HAFR INNE VAGS AGAB OSTR
do
    cut -f 2,3,4,5,9,14 /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdPopGen/Dataset_I/window/Feb22--Unfolded_PopGen_${query}_PopGenEstimates-Windows15kb-Steps15kb.pestPG | tail -n +2 | sed -r 's/LG//g' | sed 's/^0*//' | awk '$6 > 0' | awk '{print $1"\t"$1":"$2"\t"$2-15000"\t"$2"\t"$6"\t"$3"\t"$3/$6"\t"$4"\t"$4/$6"\t"$5}' | awk 'BEGIN{print "CHR\tSNP\tgPoint\tWindow\tNumberOfSites\tsumTw\tTw\tsumTp\tTp\tTd"}1' > /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdPopGen/Dataset_I/window/Feb22--Unfolded_PopGen_${query}_PopGenEstimates-Windows15kb-Steps15kb.tsv

done

## Run do_stat, get per-chromosome average theta 
```
for query in MOLU ZECE CRES ORIS CORS PONT RIAE MORL USAM TOLL COLN BARR TRAL CLEW RYAN NELL GREV WADD FURI NISS LOGS VENO HALS THIS KALV HFJO RAMS ORNE HYPP LANG BUNN DOLV HAUG HAFR INNE VAGS AGAB OSTR
do
    thetaStat do_stat /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}_PopGenEstimates.thetas.idx -outnames /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}_PopGenEstimates-AverageperCHR_thetas
done
```



## Heterozygosity
# Runs _ANGSD
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Bam_list_21feb22 | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
BAMLIST=/home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Bam_list_21feb22

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF  -bam $BAMLIST -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*1/4)) -setMaxDepth $((N_IND*10)) -doCounts 1 -doGlf 2 -GL 2 -doMajorMinor 4 -doMaf 1 -doPost 2 -doGeno 2 -dumpCounts 2 -postCutoff 0.95 -doHaploCall 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdPopGen/heterozygosity/GEO_FlatOysters--AllSamples_0.25_SITES
```
# Generates a `.bed` file based on the `.mafs` file:
```
zcat /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdPopGen/heterozygosity/GEO_FlatOysters--AllSamples_0.25_SITES.mafs.gz | cut -f1,2 | tail -n +2 | awk '{print $1"\t"$2-1"\t"$2}' | bedtools merge -i - > /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdPopGen/heterozygosity/GEO_FlatOysters--AllSamples_0.25_SITES.bed
```
# Creates a position file based on this new `.bed`:
```
awk '{print $1"\t"($2+1)"\t"$3}' /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdPopGen/heterozygosity/GEO_FlatOysters--AllSamples_0.25_SITES.bed > /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdPopGen/heterozygosity/GEO_FlatOysters--AllSamples_0.25_SITES_bed.pos
```
# Indexs the `.pos` file created above:
```
angsd sites index /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdPopGen/heterozygosity/GEO_FlatOysters--AllSamples_0.25_SITES_bed.pos
```
# Runs _ANGSD_ under -doSaf::
```
parallel --plus angsd -i {} -ref $REF -anc $REF -sites /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdPopGen/heterozygosity/GEO_FlatOysters--AllSamples_0.25_SITES_bed.pos -GL 1 -doSaf 1 -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 30 -minQ 20 -out /home/projects/dp_00007/data/hmon/angsd_Het{/...} :::: /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Bam_list_21feb22
```
# Calculates fractions:
```
parallel --tmpdir /home/projects/dp_00007/data/hmon/angsd_Het/ --plus "realSFS -fold 1 -P 40 {} > /home/projects/dp_00007/data/hmon/angsd_Het/{/..}.het" ::: /home/projects/dp_00007/data/hmon/angsd_Het/*.saf.idx
```

# Calculates heterozygosity:
```
fgrep '.' *.het | tr ":" " " | awk '{print $1"\t"$3/($2+$3)*100}' | sed -r 's/.het//g' | awk '{split($0,a,"_"); print $1"\t"a[1]"\t"$2"\t"$3'} | awk '{split($2,a,"-"); print $1"\t"a[2]"\t"$3'} > /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdPopGen/heterozygosity/GEO_FlatOysters--AllSamples_0.25--HET.txt
```