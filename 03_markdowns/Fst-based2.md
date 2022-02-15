Fst-based analysis: Comparison of the trial dataset.
================

- [Fst-based analysis: Comparison of the trial dataset.](#fst-based-analysis-comparison-of-the-trial-dataset)
  - [Load module angsd](#load-module-angsd)
  - [Create global snp list](#create-global-snp-list)
  - [Build the dataset for snp-list-Fst-based OSTR-NISS-LANG-NELL-MOLU](#build-the-dataset-for-snp-list-fst-based-ostr-niss-lang-nell-molu)
  - [SNP-list Fst calculation](#snp-list-fst-calculation)
  - [SNP-list Fst sliding window](#snp-list-fst-sliding-window)
  - [SNP NO LIST Fst calculation](#snp-no-list-fst-calculation)
  - [SNP NO LIST Fst sliding window 15kb 5k steps](#snp-no-list-fst-sliding-window-15kb-5k-steps)


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

## Build the dataset for snp-list-Fst-based OSTR-NISS-LANG-NELL-MOLU
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_OSTR-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_OSTR-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -sites /home/projects/dp_00007/people/hmon/Flat_oysters/global_snp_list_Leona20dec21.txt -out /home/projects/dp_00007/data/hmon/angsd_Fst/Feb22--Unfolded_list_OSTR 
``` 
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_NISS-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_NISS-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -sites /home/projects/dp_00007/people/hmon/Flat_oysters/global_snp_list_Leona20dec21.txt -out /home/projects/dp_00007/data/hmon/angsd_Fst/Feb22--Unfolded_list_NISS
```
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_LANG-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_LANG-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -sites /home/projects/dp_00007/people/hmon/Flat_oysters/global_snp_list_Leona20dec21.txt -out /home/projects/dp_00007/data/hmon/angsd_Fst/Feb22--Unfolded_list_LANG
```
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_NELL-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_NELL-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -sites /home/projects/dp_00007/people/hmon/Flat_oysters/global_snp_list_Leona20dec21.txt -out /home/projects/dp_00007/data/hmon/angsd_Fst/Feb22--Unfolded_list_NELL
```
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_MOLU-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta
/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_MOLU-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -sites /home/projects/dp_00007/people/hmon/Flat_oysters/global_snp_list_Leona20dec21.txt -out /home/projects/dp_00007/data/hmon/angsd_Fst/Feb22--Unfolded_list_MOLU
```

## SNP-list Fst calculation
```
cd /home/projects/dp_00007/data/hmon/angsd_Fst
POP=("OSTR" "NISS" "LANG" "NELL" "MOLU")

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
            realSFS $pop1.saf.idx $pop2.saf.idx -fold 1 -P 40 > /home/projects/dp_00007/data/hmon/angsd_Fst/${POP[i1]}.${POP[i2]}_Feb22list.sfs
            realSFS fst index $pop1.saf.idx $pop2.saf.idx -sfs /home/projects/dp_00007/data/hmon/angsd_Fst/${POP[i1]}.${POP[i2]}_Feb22list.sfs -fold 1 -P 40 -fstout /home/projects/dp_00007/data/hmon/angsd_Fst/${POP[i1]}.${POP[i2]}_Feb22list
            realSFS fst stats /home/projects/dp_00007/data/hmon/angsd_Fst/${POP[i1]}.${POP[i2]}_Feb22list.fst.idx -P 40
        fi
    done
done > /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/8Feb22_5pop_list--Fst.tsv
```

## SNP-list Fst sliding window
```
cd /home/projects/dp_00007/data/hmon/angsd_Fst
POP=("OSTR" "NISS" "LANG" "NELL" "MOLU")
for i1 in `seq 0 $((${#POP[@]}-2))`
do
    for i2 in `seq $((i1+1)) $((${#POP[@]}-1))`
    do
        pop1="${POP[i1]}"
        pop2="${POP[i2]}"
             realSFS fst stats2 /home/projects/dp_00007/data/hmon/angsd_Fst/${POP[i1]}.${POP[i2]}_Feb22list.fst.idx -win 15000 -step 5000 | cut -f 2- | tail -n +2 | awk '{print $1"\t"$1":"$2"\t"$2-5000"\t"$2"\t"$3"\t"$4}' > /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/slidingwindow/SLWin_15K_Feb22list.fst.idx_${POP[i1]}.${POP[i2]}__Feb22listFst_15K_trial5pop--Fst.tsv 
    done
done
```

## SNP NO LIST Fst calculation
```
cd /home/projects/dp_00007/data/hmon/angsd_Fst
POP=("OSTR" "NISS" "LANG" "NELL" "MOLU")
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
done > /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/8Feb22_5pop_NOLIST--Fst.tsv
```

## SNP NO LIST Fst sliding window 15kb 5k steps
```
#to do
cd /home/projects/dp_00007/data/hmon/angsd_Fst
POP=("OSTR" "NISS" "LANG" "NELL" "MOLU")
for i1 in `seq 0 $((${#POP[@]}-2))`
do
    for i2 in `seq $((i1+1)) $((${#POP[@]}-1))`
    do
        pop1="${POP[i1]}"
        pop2="${POP[i2]}"
             realSFS fst stats2 /home/projects/dp_00007/data/hmon/angsd_Fst/${POP[i1]}.${POP[i2]}_Jan22.fst.idx -win 15000 -step 5000 | cut -f 2- | tail -n +2 | awk '{print $1"\t"$1":"$2"\t"$2-5000"\t"$2"\t"$3"\t"$4}' > /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/slidingwindow/SLWin_${POP[i1]}.${POP[i2]}_Feb22NOLISTFst_15K_trial5pop--Fst.tsv 
    done
done
```