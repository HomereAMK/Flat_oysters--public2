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
> used to do it with a loop... but it takes so long that I decided to run each individual K separately.
```
#wrapper_ngsAdmix on a Trial Dataset for testing scripts purposes
#used to do it with a loop... but it takes so long that I decided to run each individual K separately.
/home/projects/dp_00007/apps/Scripts/wrapper_ngsAdmix.sh -P 40 -debug 1 -likes /home/projects/dp_00007/people/geopac/Analyses/Lumpfish/Lumpfish_ANGSD/BSG_Lumpfish--AllSamples.beagle.gz -K 2 -minMaf 0 -tol 1e-6 -tolLike50 1e-3 -maxiter 10000 -o /home/projects/dp_00007/people/geopac/Analyses/Lumpfish/Lumpfish_ngsAdmix/BSG_Lumpfish--AllSamples.2
```
