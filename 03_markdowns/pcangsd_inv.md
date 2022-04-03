



python2 /home/projects/dp_00007/apps/pcangsd/pcangsd.py \
-beagle /home/projects/dp_00007/people/hmon/Flat_oysters/05_inversions/scaffold8_inv/batch8_scaffold8_inv.beagle.gz \
-selection \
-minMaf 0.05 \
-threads 40 \
-o /home/projects/dp_00007/people/hmon/Flat_oysters/05_inversions/batch8_scaffold8_inv.beagle.gz_e10 \
-sites_save \
-e 10


python2 /home/projects/dp_00007/apps/pcangsd/pcangsd.py \
-b /home/projects/dp_00007/people/hmon/Flat_oysters/05_inversions/scaffold8_inv/batch8_scaffold8_inv.beagle.gz \
-e 10 -t 64 -o /home/projects/dp_00007/people/hmon/Flat_oysters/05_inversions/batch8_scaffold8_inv.beagle.gz_e10


/home/projects/dp_00007/apps/ngsDist/ngsDist --n_threads 16 --geno /home/projects/dp_00007/people/hmon/Flat_oysters/05_inversions/scaffold8_inv/batch8_scaffold8_inv.beagle.gz --seed 47 --probs --n_ind 675 --n_sites 261371 --labels /home/projects/dp_00007/people/hmon/Flat_oysters/01_infofiles/Bam_list_21feb22.labels --out /home/projects/dp_00007/people/hmon/Flat_oysters/05_inversions/scaffold8_inv/batch8_scaffold8_inv_ngsDist



#GEORGE script
module purge
module load tools computerome_utils/2.0
module load anaconda2/4.4.0
module load pcangsd/20190125
python /services/tools/pcangsd/20190125/pcangsd.py -threads 40 -beagle /home/projects/dp_00007/people/hmon/Flat_oysters/05_inversions/scaffold8_inv/batch8_scaffold8_inv.beagle.gz -o /home/projects/dp_00007/people/hmon/Flat_oysters/05_inversions/pcangsd_batch8_scaffold8_inv.beagle