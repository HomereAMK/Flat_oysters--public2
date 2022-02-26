rm(list=ls(all.names = TRUE))

library(tidyverse)
basedir="~/Desktop"  

chr<- c("scaffold1:", "scaffold2:", "scaffold3:", "scaffold4:", "scaffold5:",
        "scaffold6:", "scaffold7:", "scaffold8:", "scaffold9:", "scaffold10:")

pruned_position <- read_lines(paste0(basedir, "/Scripts/Flat_oysters/04_local_R/02_data/Leona20dec21.subsamp.50.id")) %>% 
  str_remove("scaffold10:") %>% str_remove("scaffold1:") %>% str_remove("scaffold2:") %>% 
  str_remove("scaffold3:") %>% str_remove("scaffold4:") %>% str_remove("scaffold5:") %>%
  str_remove("scaffold6:") %>% str_remove("scaffold7:") %>% str_remove("scaffold8:") %>%
  str_remove("scaffold9:") %>% 
  as.integer()
pruned_position


pruned_snp_list <- read_tsv(paste0(basedir, "/Scripts/Flat_oysters/04_local_R/02_data/Leona20dec21.mafs.gz")) %>%
  dplyr::select(1:4) %>%
  filter(position %in% pruned_position)

write_tsv(pruned_snp_list, paste0(basedir, "/Scripts/Flat_oysters/04_local_R/03_results/Leona20dec21.prunedlist"), col_names = F)

