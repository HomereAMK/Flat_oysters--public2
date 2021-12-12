library(tidyverse)
library(cowplot)
library(ape)
library(knitr)
#library(pegas)
#library(RColorBrewer)
#library(insect)
#library(haplo.stats)

source("~Desktop/Scripts/FlatOysters/04_local_R/00_scripts/mtgenome_functions.R")

# minimum depth 2, minimum major allele frequency 0.75
concensus <- convert_count_to_concensus(x="../angsd/bam_list_realigned_mtgenome_sorted_filtered_minq20.allele_counts.gz", min_depth=2, min_maf=0.75)

#We will also add a column with population assingments
bams=read.table("")[,1] # list of bam files
bams=sub(".bam","",bams)
bams=sub(".+/","",bams)
length(bams)
bams0=bams
bams
#defining the population var
pop=substr(bams,0,4)
pop
ind_label <- read_tsv("../sample_lists/sample_table_merged_filtered.tsv")$sample_id_corrected
concensus_to_fasta(concensus, ind_label, "../angsd/bam_list_realigned_mtgenome_sorted_filtered_minq20_mindepth2_minmaf75.fasta")

# minimum depth 4, minimum major allele frequency 0.75
concensus <- convert_count_to_concensus(x="../angsd/bam_list_realigned_mtgenome_sorted_filtered_minq20.allele_counts.gz", min_depth=4, min_maf=0.75)
ind_label <- read_tsv("../sample_lists/sample_table_merged_filtered.tsv")$sample_id_corrected
concensus_to_fasta(concensus, ind_label, "../angsd/bam_list_realigned_mtgenome_sorted_filtered_minq20_mindepth4_minmaf75.fasta")