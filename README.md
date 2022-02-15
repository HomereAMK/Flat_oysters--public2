# Flat_oysters
lcWGS pipeline analysis of Flat oysters (<i>Ostrea edulis</i>) post data-processing

# Flat oyster populations throughout its distribution range
### Mitochondrial analysis
[Phylogeography](https://github.com/therkildsen-lab/Flat_oysters/blob/main/03_markdowns/Mitochondrial_phylogeo.md)
### Population Structure
[PCA](https://github.com/therkildsen-lab/Flat_oysters/blob/main/03_markdowns/Population_Structure1.md)
[Admixture](https://github.com/therkildsen-lab/Flat_oysters/blob/main/03_markdowns/Population_Structure2.md)
[Local-PCA](https://github.com/therkildsen-lab/Flat_oysters/blob/main/03_markdowns/Local_pca.md)
### Fst-based analysis
[Fst method comparison with Trial Dataset, All sites vs only-variants sites ](https://github.com/therkildsen-lab/Flat_oysters/blob/main/03_markdowns/Fst-based2.md)
[Fst method comparison with Complete Dataset, All sites vs only-variants sites ](https://github.com/therkildsen-lab/Flat_oysters/blob/main/03_markdowns/Fst-based3.md)

### SFS-based analysis
[Population genetics estimates](https://github.com/therkildsen-lab/Flat_oysters/blob/main/03_markdowns/PopGenEstimates.md)
# Side notes
All scripts are launch (except very long and demanding jobs) with iqsub command on a different screen.
screen -ls : "see all the screens"
screen -S {string} : "create screen"
ctrl A + D : "detached safely from the current screen"
screen -r {string} : "attach a screen"
screen -X -S {string} kill: "delete a screen"
