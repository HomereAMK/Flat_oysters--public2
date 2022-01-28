#!/bin/bash
#PBS -d /home/projects/dp_00007/people/hmon/Flat_oysters
#PBS -W group_list=dp_00007 -A dp_00007
#PBS -N sfs_30pop
#PBS -e 99_logfiles/Fst/sfs.err
#PBS -o 99_logfiles/Fst/sfs.out
#PBS -l nodes=3:ppn=37:fatnode
#PBS -l walltime=100:00:00
#PBS -l mem=1300gb
#PBS -m n
#PBS -r n


# Load module angsd
module load tools computerome_utils/2.0
module load htslib/1.14
module load bedtools/2.30.0
module load pigz/2.3.4
module load parallel/20210722
module load angsd/0.935

#George Pacheco script adapted to Flat oysters dataset
# get the sfs step
cd /home/projects/dp_00007/data/hmon/angsd_Fst/
POP=("ORIS" "CORS" "MOLU" "PONT" "MORL" "USAM"  "BARR" "TRAL" "CLEW" "NELL" "RYAN" "GREV" "WADD" "NISS" "LOGS" "HALS" "THIS" "INNE" "HAUG" "HAFR" "AGAB" "OSTR" "VAGS" "LANG" "BUNN" "DOLV" "KALV" "HFJO" "RAMS" "ORNE" "HYPP")

for i1 in `seq 0 $((${#POP[@]}-2))`
do
    for i2 in `seq $((i1+1)) $((${#POP[@]}-1))`
    do
        pop1="Jan22--Unfolded_${POP[i1]}"
        pop2="Jan22--Unfolded_${POP[i2]}"
        N_SITES=`realSFS print $pop1.saf.idx $pop2.saf.idx | wc -l`
        echo -ne "${POP[i1]}\t${POP[i2]}\t$N_SITES\t"
        if [[ $N_SITES == 0 ]]; then
            echo "NA"
        else
            realSFS $pop1.saf.idx $pop2.saf.idx -fold 1 -P 40 > /home/projects/dp_00007/data/hmon/angsd_Fst/${POP[i1]}.${POP[i2]}_Jan22.sfs
            realSFS fst index $pop1.saf.idx $pop2.saf.idx -sfs /home/projects/dp_00007/data/hmon/angsd_Fst/${POP[i1]}.${POP[i2]}_Jan22.sfs -fold 1 -P 40 -fstout /home/projects/dp_00007/data/hmon/angsd_Fst/${POP[i1]}.${POP[i2]}_Jan22
            realSFS fst stats /home/projects/dp_00007/data/hmon/angsd_Fst/${POP[i1]}.${POP[i2]}_Jan22.fst.idx -P 40
        fi
    done
done > /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22_30pop--Fst.tsv

# sfs with a sliding window step
POP=("ORIS" "CORS" "MOLU" "PONT" "MORL" "USAM"  "BARR" "TRAL" "CLEW" "NELL" "RYAN" "GREV" "WADD" "NISS" "LOGS" "HALS" "THIS" "INNE" "HAUG" "HAFR" "AGAB" "OSTR" "VAGS" "LANG" "BUNN" "DOLV" "KALV" "HFJO" "RAMS" "ORNE" "HYPP")

for i1 in `seq 0 $((${#POP[@]}-2))`
do
    for i2 in `seq $((i1+1)) $((${#POP[@]}-1))`
    do
        pop1="${POP[i1]}"
        pop2="${POP[i2]}"
             realSFS fst stats2 /home/projects/dp_00007/data/hmon/angsd_Fst/${POP[i1]}.${POP[i2]}_Jan22.fst.idx -win 15000 -step 5000 | cut -f 2- | tail -n +2 | awk '{print $1"\t"$1":"$2"\t"$2-5000"\t"$2"\t"$3"\t"$4}' > /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/slidingwindow/SlWin_${POP[i1]}.${POP[i2]}_Jan22_15Kwin_5Kstep--Fst.tsv 
    done
done
