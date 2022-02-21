### The BEGINNING ~~~~~
##
# ~ Plots Local_pca | First written by Nicolas Lou with later modifications by Homère Alves Monteiro

#### Cleans the environment #### 
rm(list=ls())

#### Assemble local_pca input #### 
lg_list <- read_lines("~/Desktop/Scripts/Data/Local_PCA/lg_list.txt")
i=1
for (lg in lg_list){
  pca_summary_temp <- read_tsv(paste0("~/Desktop/Scripts/Data/Local_PCA/Dataset_Ipca_summary_10000snp_", lg, "_2pc.tsv"), col_names = F)
  snp_position_temp <- read_tsv(paste0("~/Desktop/Scripts/Data/Local_PCA/Dataset_Isnp_position_10000snp_", lg, "_2pc.tsv"), col_names = F)
  if (i == 1) {
    pca_summary <- pca_summary_temp
    snp_position <- snp_position_temp
  } else {
    pca_summary <- bind_rows(pca_summary, pca_summary_temp)
    snp_position <- bind_rows(snp_position, snp_position_temp)
  }
  i <- i+1
}
write_tsv(pca_summary, "~/Desktop/Scripts/Data/Local_PCA/Dataset_Ipca_summary_10000snp_2pc.tsv", col_names = F)
write_tsv(snp_position, "~/Desktop/Scripts/Data/Local_PCA/Dataset_Isnp_position_10000snp_2pc.tsv", col_names = F)

#### Run pc_dist and assemble the output#### 
 library(tidyverse)
#install.packages("data.table")
#devtools::install_github("petrelharp/local_pca/lostruct")
library(lostruct)
# Read the input
pca_summary <- read_tsv('~/Desktop/Scripts/Data/Local_PCA/Dataset_Ipca_summary_10000snp_2pc.tsv', col_names = F) 
# Run pc_dist with pca_summary
pca_summary <- as.matrix(pca_summary)
attr(pca_summary, 'npc') <- 2
dist <- pc_dist(pca_summary)
write_tsv(as.data.frame(dist), '~/Desktop/Scripts/Data/Local_PCA/Dataset_Iwindow_dist_10000snp_2pc.tsv', col_names = F)

#### Analysis with all windows ####
## Read the SNP position file
snp_position <- read_tsv("~/Desktop/Scripts/Data/Local_PCA/Dataset_Isnp_position_10000snp_2pc.tsv", col_names = F) %>%
  transmute(lg = sub("\\_.*", "", X1), 
            start = as.integer(sub(".*\\_", "", X1)), 
            stop = as.integer(sub(".*\\_", "", X2)), 
            center = (start+stop)/2)
## Read in the window distance matrix
dist <- read_tsv("~/Desktop/Scripts/Data/Local_PCA/Dataset_Iwindow_dist_10000snp_2pc.tsv", col_names = F) %>%
  as.matrix()
## Do MDS with the distance matrix
mds <- cmdscale(as.dist(dist), k=10, eig = T)
proportion_variance <- round(mds$eig/sum(mds$eig)*100,2)
mds <- mds$points %>%
  as.data.frame() %>%
  set_names(paste0("dist_", 1:10)) %>%
  bind_cols(snp_position, .)
mds %>%
  gather(key = axis, value = value, 5:14) %>%
  mutate(axis=fct_relevel(axis, paste0("dist_", 1:10))) %>%
  ggplot(aes(x=center/10^6, y=value, color=axis)) +
  geom_point(size=0.5) +
  facet_grid(axis~lg, scales="free_x", space="free_x") +
  theme_bw() +
  xlab("position (Mbp)") +
  ylab("principal coordinate value") +
  theme(panel.spacing = unit(0.1, "lines"),
        axis.title.x=element_text(),
        legend.position="none",
        text = element_text(size=10),
        axis.text = element_text(size=6),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) 
#mds
ggplot(mds, aes(x=dist_1, y=dist_2, color=lg, shape=lg)) +
  geom_point() +
  scale_shape_manual(values = c(rep(c(15,16,17,18),7), 15, 16)) +
  xlab(paste0("PCo1 (", proportion_variance[1], "%)")) +
  ylab(paste0("PCo2 (", proportion_variance[2], "%)")) +
  cowplot::theme_cowplot()
ggplot(mds, aes(x=dist_3, y=dist_4, color=lg, shape=lg)) +
  geom_point() +
  scale_shape_manual(values = c(rep(c(15,16,17,18),7), 15, 16)) +
  xlab(paste0("PCo3 (", proportion_variance[3], "%)")) +
  ylab(paste0("PCo4 (", proportion_variance[4], "%)")) +
  cowplot::theme_cowplot()
ggplot(mds, aes(x=dist_5, y=dist_6, color=lg, shape=lg)) +
  geom_point() +
  scale_shape_manual(values = c(rep(c(15,16,17,18),7), 15, 16)) +
  xlab(paste0("PCo5 (", proportion_variance[5], "%)")) +
  ylab(paste0("PCo6 (", proportion_variance[6], "%)")) +
  cowplot::theme_cowplot()
ggplot(mds, aes(x=dist_7, y=dist_8, color=lg, shape=lg)) +
  geom_point() +
  scale_shape_manual(values = c(rep(c(15,16,17,18),7), 15, 16)) +
  xlab(paste0("PCo7 (", proportion_variance[7], "%)")) +
  ylab(paste0("PCo8 (", proportion_variance[8], "%)")) +
  cowplot::theme_cowplot()


###### Check the PCA pattern with local PCA outliers including the inversions ######
#Subset the list of all beagle files to only include outlier windows
snp_position <- read_tsv("~/Desktop/Scripts/Data/Local_PCA/Dataset_Isnp_position_10000snp_2pc.tsv", col_names = c("start", "stop"))
write_tsv(mds, "~/Desktop/Scripts/Data/Local_PCA/trialMDS_datasetI_3chr.tsv", col_names = T)
beagle_list <- read_tsv("~/Desktop/Scripts/Data/Local_PCA/DatasetI_beagle_list.txt", col_names = F)

## dist1 outliers
dist1_outlier_index <- which(mds$dist_1 < -0.15)
beagle_list_dist1_outlier <- beagle_list[dist1_outlier_index,]
write_tsv(beagle_list_dist1_outlier, "~/Desktop/Scripts/Data/Local_PCA/DatasetI_trial_beagle_list_dist1_outlier.txt", col_names = F)
## dist2 outliers
dist2_outlier_index <- which(mds$dist_2 > -0.25)
beagle_list_dist2_outlier <- beagle_list[dist2_outlier_index,]
write_tsv(beagle_list_dist2_outlier, "~/Desktop/Scripts/Data/Local_PCA/DatasetI_trialbeagle_list_dist2_outlier.txt", col_names = F)




