Pairwise Windowed-fst with a snp list 
================
  - [Load module angsd](#load-module-angsd)
  - [Create global snp list](#create-global-snp-list)
  - [Build the dataset for snp-list-Fst-based](#build-the-dataset-for-snp-list-fst-based)
  - [SNP-list Fst calculation](#SNP-list-Fst-calculation)
  - [SNP-list Fst sliding window 15kb and 15kb step](#SNP-list-Fst-sliding-window-15kb-and-15kb-step)



## Load module angsd
```
module load tools computerome_utils/2.0
module load htslib/1.14
module load bedtools/2.30.0
module load pigz/2.3.4
module load parallel/20210722
module load angsd/0.935
```


## Create global snp list
```
gunzip -c /home/projects/dp_00007/people/hmon/Flat_oysters/02_angsdOutput/Dataset_I/Leona20dec21.mafs.gz | cut -f 1,2,3,4 | tail -n +2 > /home/projects/dp_00007/people/hmon/Flat_oysters/global_snp_list_Leona20dec21.txt
angsd sites index /home/projects/dp_00007/people/hmon/Flat_oysters/global_snp_list_Leona20dec21.txt
```
## Build the dataset for snp-list-Fst-based
```
POP=("ORIS" "CORS" "MOLU" "ZECE" "CRES" "PONT" "RIAE" "MORL" "USAM" "TOLL" "COLN" "BARR" "TRAL" "CLEW" "NELL" "RYAN" "GREV" "WADD" "FURI" "NISS" "LOGS" "VENO" "HALS" "THIS" "INNE" "HAUG" "HAFR" "AGAB" "OSTR" "VAGS" "LANG" "BUNN" "DOLV" "KALV" "HFJO" "RAMS" "ORNE" "HYPP")

for i1 in `seq 0 $((${#POP[@]}-2))`
    do
        pop1="${POP[i1]}"
        N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_${POP[i1]}-Fst.list | wc -l`
        REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
            /home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_${POP[i1]}-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -sites /home/projects/dp_00007/people/hmon/Flat_oysters/global_snp_list_Leona20dec21.txt -out /home/projects/dp_00007/data/hmon/angsd_Fst/Feb22--Unfolded_list_${POP[i1]}
    done
done
```
## SNP-list Fst calculation
```
cd /home/projects/dp_00007/data/hmon/angsd_Fst
POP=("ORIS" "CORS" "MOLU" "ZECE" "CRES" "PONT" "RIAE" "MORL" "USAM" "TOLL" "COLN" "BARR" "TRAL" "CLEW" "NELL" "RYAN" "GREV" "WADD" "FURI" "NISS" "LOGS" "VENO" "HALS" "THIS" "INNE" "HAUG" "HAFR" "AGAB" "OSTR" "VAGS" "LANG" "BUNN" "DOLV" "KALV" "HFJO" "RAMS" "ORNE" "HYPP")

for i1 in `seq 0 $((${#POP[@]}-2))`
do
    for i2 in `seq $((i1+1)) $((${#POP[@]}-1))`
    do
        pop1="Feb22--Unfolded_list_${POP[i1]}"
        pop2="Feb22--Unfolded_list_${POP[i2]}"
        N_SITES=`realSFS print $pop1.saf.idx $pop2.saf.idx | wc -l`
        echo -ne "${POP[i1]}\t${POP[i2]}\t$N_SITES\t"
        if [[ $N_SITES == 0 ]]; then
            echo "NA"
        else
            realSFS $pop1.saf.idx $pop2.saf.idx -fold 1 -P 40 > /home/projects/dp_00007/data/hmon/angsd_Fst/${POP[i1]}.${POP[i2]}_Feb22_List.sfs
            realSFS fst index $pop1.saf.idx $pop2.saf.idx -sfs /home/projects/dp_00007/data/hmon/angsd_Fst/${POP[i1]}.${POP[i2]}_Feb22_List.sfs -fold 1 -P 40 -fstout /home/projects/dp_00007/data/hmon/angsd_Fst/${POP[i1]}.${POP[i2]}_Feb22_List
            realSFS fst stats /home/projects/dp_00007/data/hmon/angsd_Fst/${POP[i1]}.${POP[i2]}_Feb22_List.fst.idx -P 40
        fi
    done
done > /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/14Feb22_ALLpop_list--Fst.tsv
```
$$$$$$$$$$$$$$$$$

## SNP-list Fst sliding window 15kb and 15kb step
```
cd /home/projects/dp_00007/data/hmon/angsd_Fst
POP=("ORIS" "CORS" "MOLU" "ZECE" "CRES" "PONT" "RIAE" "MORL" "USAM" "TOLL" "COLN" "BARR" "TRAL" "CLEW" "NELL" "RYAN" "GREV" "WADD" "FURI" "NISS" "LOGS" "VENO" "HALS" "THIS" "INNE" "HAUG" "HAFR" "AGAB" "OSTR" "VAGS" "LANG" "BUNN" "DOLV" "KALV" "HFJO" "RAMS" "ORNE" "HYPP")
for i1 in `seq 0 $((${#POP[@]}-2))`
do
    for i2 in `seq $((i1+1)) $((${#POP[@]}-1))`
    do
        pop1="${POP[i1]}"
        pop2="${POP[i2]}"
             realSFS fst stats2 /home/projects/dp_00007/data/hmon/angsd_Fst/${POP[i1]}.${POP[i2]}_Feb22_List.fst.idx -win 20000 -step 15000 | cut -f 2- | tail -n +2 | awk '{print $1"\t"$1":"$2"\t"$2-20000"\t"$2"\t"$3"\t"$4}' > /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/slidingwindow/SLWin20kb_20kbstep_14Feb22_LIST_${POP[i1]}.${POP[i2]}--ALLpop_Fst.tsv 
    done
done
```