## The BEGINNING ~~~~~
##
#  FastaFromAlleleCounts Mtgenome phylogeography | First written by Nicolas Lou with later modifications by Hom?re J. Alves Monteiro

# Cleans the environment  
rm(list=ls())
library(tidyverse)
library(cowplot)
library(ape)
library(knitr)
library(pegas)
library(RColorBrewer)
library(insect)
library(haplo.stats)

source("~/Desktop/Scripts/Flat_oysters/04_local_R/00_scripts/mtgenome_functions.R")

#### minimum depth 2, minimum major allele frequency 0.75 #### 
concensus <- convert_count_to_concensus(x="~/Desktop/Scripts/Flat_oysters/04_local_R/02_data/bam_list_realigned_mtgenome_sorted_filtered_minq20.allele.counts.gz", min_depth=2, min_maf=0.75)
summary(concensus)

####wrangling the bam list####
bams=read.table("~/Desktop/Scripts/Flat_oysters/04_local_R/02_data/list_Mt_14dec21")[,1] # list of bam files
bams=sub(".bam","",bams)
bams=sub(".+/","",bams)
length(bams)
bams0=bams
bams
#defining the population var
pop=substr(bams,0,4)
pop
ind_label <- substr(bams,0,7)
concensus_to_fasta(concensus, ind_label, "~/Desktop/Scripts/Flat_oysters/04_local_R/03_results/bam_list_realigned_mtgenome_sorted_filtered_minq20_mindepth2_minmaf75.fasta")
tail(concensus)
#### minimum depth 4, minimum major allele frequency 0.75 ####
concensus <- convert_count_to_concensus(x="~/Desktop/Scripts/Flat_oysters/04_local_R/02_data/bam_list_realigned_mtgenome_sorted_filtered_minq20.allele.counts.gz", min_depth=4, min_maf=0.75)
concensus_to_fasta(concensus, ind_label, "~/Desktop/Scripts/Flat_oysters/04_local_R/03_results/bam_list_realigned_mtgenome_sorted_filtered_minq20_mindepth4_minmaf75.fasta")

#Convert fasta file to nexus for PopArt (relaxed filter)
fasta <- read.dna("~/Desktop/Scripts/Flat_oysters/04_local_R/03_results/bam_list_realigned_mtgenome_sorted_filtered_minq20_mindepth2_minmaf75.fasta", format="fasta")
# get depth count
depth_count <- read_tsv("~/Desktop/Scripts/Flat_oysters/04_local_R/02_data/bam_list_realigned_mtgenome_sorted_filtered_minq20.depth.counts.gz") %>%
  dplyr::select(-X481) %>%
  t() %>%
  as_tibble() %>%
  bind_cols(ind=ind_label, population=pop, .) %>%
  gather(key = position, value="depth", 3:16356) %>%
  mutate(position=as.numeric(substring(position, 2)))

#### exclude samples depth>2 ####
samples_to_exclude <- filter(depth_count, depth>2) %>%
  count(ind) %>%
  mutate(position_missing = 16356-n) %>%
  arrange(desc(position_missing)) %>%
  filter(position_missing > 0.3*16356) %>%
  .$ind
fasta <- subset(fasta, subset = !(attr(fasta,"dimnames")[[1]] %in% samples_to_exclude))
fasta
write.nexus.data(fasta, file="~/Desktop/Scripts/Flat_oysters/04_local_R/03_results/bam_list_realigned_mtgenome_sorted_filtered_minq20_mindepth2_minmaf75.nex", format="dna")


#### exclude samples depth>10 ####
samples_to_exclude2 <- filter(depth_count, depth>10) %>%
  count(ind) %>%
  mutate(position_missing = 16356-n) %>%
  arrange(desc(position_missing)) %>%
  filter(position_missing > 0.3*16356) %>%
  .$ind
fasta <- subset(fasta, subset = !(attr(fasta,"dimnames")[[1]] %in% samples_to_exclude2))
fasta
write.nexus.data(fasta, file="~/Desktop/Scripts/Flat_oysters/04_local_R/03_results/bam_list_realigned_mtgenome_sorted_filtered_minq20_mindepth10_minmaf75.nex", format="dna")



###### Average depth per individual ####
set.seed(1)
dfyes <- depth_count %>%
  filter(! str_detect(population, c("USAM|MORL")))
ind_average_depth <- group_by(dfyes, ind, population) %>%
  summarise(average_depth=mean(depth))
ggplot(ind_average_depth, mapping=aes(x=population, y=average_depth, group=population)) +
  geom_boxplot() +
  geom_jitter() +
  theme_cowplot() +
  coord_flip()
last_plot()
ggsave(filename = "Desktop/Scripts/Flat_oysters/04_local_R/03_results/Average_depthMt_pop.pdf") #change path


#### Average depth per position ####
group_by(depth_count, position) %>%
  summarise(average_depth=mean(depth)) %>%
  ggplot(aes(x=position, y=average_depth)) +
  geom_line() +
  theme_cowplot()
last_plot()
ggsave(filename = "Desktop/Scripts/Flat_oysters/04_local_R/03_results/Average_depthMt_perPosition.pdf") #change path

sample_table<- data.frame(bams, ind_label, pop)


####traits table for popart####
sample_table %>%
  dplyr::filter(!(ind_label %in% samples_to_exclude)) %>%
  dplyr::select(ind_label, pop) %>%
  mutate(temp=1) %>%
  spread(key = pop, value = temp) %>%
  mutate_all(~replace(., is.na(.), 0)) %>%
  write_csv("~/Desktop/Scripts/Flat_oysters/04_local_R/03_results/bam_list_realigned_mtgenome_sorted_filtered_population_trait_table_for_popart.csv")

####traits table for popart mindepth>10####
sample_table %>%
  dplyr::filter(!(ind_label %in% samples_to_exclude2)) %>%
  dplyr::select(ind_label, pop) %>%
  mutate(temp=1) %>%
  spread(key = pop, value = temp) %>%
  mutate_all(~replace(., is.na(.), 0)) %>%
  write_csv("~/Desktop/Scripts/Flat_oysters/04_local_R/03_results/bam_list_realigned_mtgenome_sorted_filtered_population_trait_table_for_popart_mindepth10.csv")
