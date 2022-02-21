#!/bin/bash
#PBS -d /home/projects/dp_00007/people/hmon/Flat_oysters
#PBS -W group_list=dp_00007 -A dp_00007
#PBS -N BigN_angsd_regular10dec
#PBS -e SFSbignode21feb22.err
#PBS -o SFSbignode21feb22.out
#PBS -l nodes=2:ppn=36:fatnode
#PBS -l walltime=600:00:00
#PBS -l mem=1300gb
#PBS -m n
#PBS -r n


module load tools computerome_utils/2.0
module load htslib/1.14
module load bedtools/2.30.0
module load pigz/2.3.4
module load parallel/20210722
module load angsd/0.935

## Run realSFS, site frequency spectrum.
for query in MOLU ZECE CRES ORIS CORS PONT RIAE MORL USAM TOLL COLN BARR TRAL CLEW RYAN 
do
    realSFS -P 40 -fold 1 /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}.saf.idx > /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}.sfs
done
for query in NELL GREV WADD FURI NISS LOGS VENO HALS THIS KALV HFJO RAMS ORNE HYPP LANG BUNN DOLV HAUG HAFR INNE VAGS AGAB OSTR
do
    realSFS -P 40 -fold 1 /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}.saf.idx > /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}.sfs
done


## Run saf2theta, calculate the thetas for each site.
for query in MOLU ZECE CRES ORIS CORS PONT RIAE MORL USAM TOLL COLN BARR TRAL CLEW RYAN NELL GREV WADD FURI NISS LOGS VENO HALS THIS KALV HFJO RAMS ORNE HYPP LANG BUNN DOLV HAUG HAFR INNE VAGS AGAB OSTR
do
    realSFS saf2theta /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}.saf.idx \
    -sfs /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}.sfs \
    -fold 1 -outname /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}_PopGenEstimates
done

## Run thetaStat print, get summary of Thetas per pop
for query in MOLU ZECE CRES ORIS CORS PONT RIAE MORL USAM TOLL COLN BARR TRAL CLEW RYAN NELL GREV WADD FURI NISS LOGS VENO HALS THIS KALV HFJO RAMS ORNE HYPP LANG BUNN DOLV HAUG HAFR INNE VAGS AGAB OSTR
do
    thetaStat print /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}_PopGenEstimates.thetas.idx > /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}_PopGenEstimates.Print
done


# Run the R script GetsThetaSummaries.R, get summary for all pop
for query in MOLU ZECE CRES ORIS CORS PONT RIAE MORL USAM TOLL COLN BARR TRAL CLEW RYAN NELL GREV WADD FURI NISS LOGS VENO HALS THIS KALV HFJO RAMS ORNE HYPP LANG BUNN DOLV HAUG HAFR INNE VAGS AGAB OSTR
do
     N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_${query}-Fst.list | wc -l`
     Rscript --vanilla --slave /home/projects/dp_00007/apps/Scripts/GetsThetaSummaries.R /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}_PopGenEstimates.Print $N_IND $query
done > /home/projects/dp_00007/data/hmon/angsd_PopGen/ThetaSummaries_Feb22--Unfolded_PopGen_ALLpop.PopGenEstimates.txt
