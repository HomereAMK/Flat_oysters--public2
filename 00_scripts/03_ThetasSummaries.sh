#!/bin/bash
#PBS -d /home/projects/dp_00007/people/hmon/Flat_oysters
#PBS -W group_list=dp_00007 -A dp_00007
#PBS -N ThetaSummariesBignode
#PBS -e ThetaSummariesBignode.err
#PBS -o ThetaSummariesBignode.out
#PBS -l nodes=2:ppn=30:fatnode
#PBS -l walltime=600:00:00
#PBS -l mem=1300gb
#PBS -m n
#PBS -r n


#angsd
module load tools computerome_utils/2.0
module load htslib/1.14
module load bedtools/2.30.0
module load pigz/2.3.4
module load parallel/20210722
module load angsd/0.935


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


## Run the R script GetsThetaSummaries.R, get summary for all pop
for query in MOLU ZECE CRES ORIS CORS PONT RIAE MORL USAM TOLL COLN BARR TRAL CLEW RYAN NELL GREV WADD FURI NISS LOGS VENO HALS THIS KALV HFJO RAMS ORNE HYPP LANG BUNN DOLV HAUG HAFR INNE VAGS AGAB OSTR
do
     N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_${query}-Fst.list | wc -l`
     Rscript --vanilla --slave /home/projects/dp_00007/apps/Scripts/GetsThetaSummaries.R /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}_PopGenEstimates.Print $N_IND $query
done > /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdPopGen/Dataset_I/ThetaSummaries_Feb22--Unfolded_PopGen_ALLpop.PopGenEstimates.txt


## Run do_stat, get the fixed window thetas, -win 15kb -step 15kb
for query in MOLU ZECE CRES ORIS CORS PONT RIAE MORL USAM TOLL COLN BARR TRAL CLEW RYAN NELL GREV WADD FURI NISS LOGS VENO HALS THIS KALV HFJO RAMS ORNE HYPP LANG BUNN DOLV HAUG HAFR INNE VAGS AGAB OSTR
do
    thetaStat do_stat /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}_PopGenEstimates.thetas.idx -win 15000 -step 15000 -outnames /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdPopGen/Dataset_I/window/Feb22--Unfolded_PopGen_${query}_PopGenEstimates-Windows15kb-Steps15kb
done


## Run do_stat, get per-chromosome average theta 
for query in MOLU ZECE CRES ORIS CORS PONT RIAE MORL USAM TOLL COLN BARR TRAL CLEW RYAN NELL GREV WADD FURI NISS LOGS VENO HALS THIS KALV HFJO RAMS ORNE HYPP LANG BUNN DOLV HAUG HAFR INNE VAGS AGAB OSTR
do
    thetaStat do_stat /home/projects/dp_00007/data/hmon/angsd_PopGen/Feb22--Unfolded_PopGen_${query}_PopGenEstimates.thetas.idx -outnames /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdPopGen/Dataset_I/Feb22--Unfolded_PopGen_${query}_PopGenEstimates-AverageperCHR_thetas
done
