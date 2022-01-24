```
# Load module angsd
module load tools computerome_utils/2.0
module load htslib/1.9
module load bedtools/2.30.0
module load pigz/2.3.4
module load parallel/20210722
module load angsd/0.935
```

# unfolded step
# for NISS pop only
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_NISS-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_NISS-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_NISS
```
# for AGAB pop only
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_AGAB-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_AGAB-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_AGAB
```
# get the sfs step
cd /home/projects/dp_00007/people/hmon/Flat_oysters/Fst

POP=("ORIS" "CORS" "MOLU" "ZECE" "CRES" "PONT" "RIAE" "MORL" "USAM" "TOLL" "COLN" "BARR" "TRAL" "CLEW" "NELL" "RYAN" "GREV" "WADD" "FURI" "NISS" "LOGS" "VENO" "HALS" "THIS" "INNE" "HAUG" "HAFR" "AGAB" "OSTR" "VAGS" "LANG" "BUNN" "DOLV" "KALV" "HFJO" "RAMS" "ORNE" "HYPP")

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
            realSFS $pop1.saf.idx $pop2.saf.idx -fold 1 -P 40 > /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/${POP[i1]}.${POP[i2]}_Jan22.sfs
            realSFS fst index $pop1.saf.idx $pop2.saf.idx -sfs /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/${POP[i1]}.${POP[i2]}_Jan22.sfs -fold 1 -P 40 -fstout /home/projects/dp_00007/data/geopac/angsd_Fst/Lumpfish/${POP[i1]}.${POP[i2]}_Ind66
            realSFS fst stats /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/${POP[i1]}.${POP[i2]}_Jan22.fst.idx -P 40
        fi
    done
done > /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Fst.tsv
# get the sfs step Trial
cd /home/projects/dp_00007/people/hmon/Flat_oysters/Fst

POP=("AGAB" "NISS" "RYAN" "MOLU")

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
            realSFS $pop1.saf.idx $pop2.saf.idx -fold 1 -P 40 > /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/${POP[i1]}.${POP[i2]}_Jan22.sfs
            realSFS fst index $pop1.saf.idx $pop2.saf.idx -sfs /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/${POP[i1]}.${POP[i2]}_Jan22.sfs -fold 1 -P 40 -fstout /home/projects/dp_00007/data/geopac/angsd_Fst/Lumpfish/${POP[i1]}.${POP[i2]}_Ind66
            realSFS fst stats /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/${POP[i1]}.${POP[i2]}_Jan22.fst.idx -P 40
        fi
    done
done > /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Fst.tsv
# sfs with a sliding window step
POP=("ORIS" "CORS" "MOLU" "ZECE" "CRES" "PONT" "RIAE" "MORL" "USAM" "TOLL" "COLN" "BARR" "TRAL" "CLEW" "NELL" "RYAN" "GREV" "WADD" "FURI" "NISS" "LOGS" "VENO" "HALS" "THIS" "INNE" "HAUG" "HAFR" "AGAB" "OSTR" "VAGS" "LANG" "BUNN" "DOLV" "KALV" "HFJO" "RAMS" "ORNE" "HYPP")
for i1 in `seq 0 $((${#POP[@]}-2))`
do
    for i2 in `seq $((i1+1)) $((${#POP[@]}-1))`
    do
        pop1="${POP[i1]}"
        pop2="${POP[i2]}"
             realSFS fst stats2 /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/${POP[i1]}.${POP[i2]}_Jan22.fst.idx -win 5000 -step 5000 | cut -f 2- | tail -n +2 | awk '{print $1"\t"$1":"$2"\t"$2-5000"\t"$2"\t"$3"\t"$4}' > /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/slidingwindow/SlWin_${POP[i1]}.${POP[i2]}_Jan22_5K--Fst.tsv 
    done
done


```
POP=("ORIS" "CORS" "MOLU" "ZECE" "CRES" "PONT" "RIAE" "MORL" "USAM" "TOLL" "COLN" "BARR" "TRAL" "CLEW" "NELL" "RYAN" "GREV" "WADD" "FURI" "NISS" "LOGS" "VENO" "HALS" "THIS" "INNE" "HAUG" "HAFR" "AGAB" "OSTR" "VAGS" "LANG" "BUNN" "DOLV" "KALV" "HFJO" "RAMS" "ORNE" "HYPP")

for query in ${POP[*]}
do 
    grep ${query} /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Bam_list_13dec21 > /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_${query}-Fst.list

done
```


# for ORIS pop
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_ORIS-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_ORIS-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_ORIS

# CORS
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_CORS-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_CORS-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_CORS

# MOLU
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_MOLU-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_MOLU-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_MOLU

# PONT
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_PONT-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_PONT-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_PONT
```

# MORL
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_MORL-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_MORL-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_MORL
```

# USAM
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_USAM-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_USAM-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_USAM
```

# BARR
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_BARR-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_BARR-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_BARR
```

# TRAL
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_TRAL-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_TRAL-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_TRAL
```

# CLEW
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_CLEW-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_CLEW-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_CLEW
```

# NELL
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_NELL-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_NELL-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_NELL
```

# RYAN
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_RYAN-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_RYAN-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_RYAN
```






# NELL
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_NELL-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_NELL-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_NELL
```

# GREV
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_GREV-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_GREV-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_GREV
```

# WADD
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_WADD-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_WADD-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_WADD
```
# LOGS
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_LOGS-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_LOGS-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_LOGS
```
# HALS
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_HALS-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_HALS-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_HALS
```

# THIS
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_THIS-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_THIS-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_THIS
```
# INNE
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_INNE-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_INNE-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_INNE
```
# HAUG
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_HAUG-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_HAUG-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_HAUG
```
# HAFR
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_HAFR-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_HAFR-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_HAFR
```

# OSTR
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_OSTR-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_OSTR-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_OSTR
```

# VAGS
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_VAGS-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_VAGS-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_VAGS
```

# LANG
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_LANG-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_LANG-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_LANG
```

# BUNN
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_BUNN-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_BUNN-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_BUNN
```
# DOLV
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_DOLV-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_DOLV-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_DOLV
```

# KALV
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_KALV-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_KALV-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_KALV
```
# HFJO

```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_HFJO-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_HFJO-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_HFJO
```

# RAMS
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_RAMS-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_RAMS-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_RAMS
```


# ORNE
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_ORNE-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_ORNE-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_ORNE
```

# HYPP
```
N_IND=`cat /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_HYPP-Fst.list | wc -l`
REF=/home/projects/dp_00007/people/hmon/AngsdPopStruct/01_infofiles/fileOegenome10scaffoldC3G.fasta

/home/projects/dp_00007/apps/Scripts/wrapper_angsd.sh -debug 2 -nThreads 40 -ref $REF -anc $REF -bam /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Jan22--AllSamples_HYPP-Fst.list -remove_bads 1 -uniqueOnly 1 -baq 1 -C 50 -minMapQ 20 -minQ 20 -minInd $((N_IND*2/3)) -GL 1 -doSaf 1 -out /home/projects/dp_00007/people/hmon/Flat_oysters/Fst/Jan22--Unfolded_HYPP
```