### The BEGINNING ~~~~~
##
# ~ Plots BSG_Turbot--Fst | By George Pacheco modified by Homere J. Alves Monteiro


# Cleans the environment ~ 
rm(list=ls())
setwd("~/Desktop/Scripts/Data/FST")


# Loads required packages ~
pacman::p_load(tidyverse, extrafont, lemon)


# Loads datasets ~
LANG_MOLU <- read.table("SLWin_15K_Feb22list.fst.idx_LANG.MOLU__Feb22listFst_15K_trial5pop--Fst.tsv", header = FALSE)
LANG_NELL <- read.table("SLWin_15K_Feb22list.fst.idx_LANG.NELL__Feb22listFst_15K_trial5pop--Fst.tsv", header = FALSE)
LANG_NISS <- read.table("SLWin_15K_Feb22list.fst.idx_NISS.LANG__Feb22listFst_15K_trial5pop--Fst.tsv", header = FALSE)
LANG_OSTR <- read.table("SLWin_15K_Feb22list.fst.idx_OSTR.LANG__Feb22listFst_15K_trial5pop--Fst.tsv", header = FALSE)
OSTR_MOLU <- read.table("SLWin_15K_Feb22list.fst.idx_OSTR.MOLU__Feb22listFst_15K_trial5pop--Fst.tsv", header = FALSE)
OSTR_NELL <- read.table("SLWin_15K_Feb22list.fst.idx_OSTR.NELL__Feb22listFst_15K_trial5pop--Fst.tsv", header = FALSE)
OSTR_NISS <- read.table("SLWin_15K_Feb22list.fst.idx_OSTR.NISS__Feb22listFst_15K_trial5pop--Fst.tsv", header = FALSE)
NISS_MOLU <- read.table("SLWin_15K_Feb22list.fst.idx_NISS.MOLU__Feb22listFst_15K_trial5pop--Fst.tsv", header = FALSE)
NISS_NELL <- read.table("SLWin_15K_Feb22list.fst.idx_NISS.NELL__Feb22listFst_15K_trial5pop--Fst.tsv", header = FALSE)
NELL_MOLU <- read.table("SLWin_15K_Feb22list.fst.idx_NISS.MOLU__Feb22listFst_15K_trial5pop--Fst.tsv", header = FALSE)
# Adds column names to MissingData ~
colnames(LANG_MOLU) <- c("CHR", "SNP", "gPoint", "END", "NumberOfSites", "Fst")
colnames(LANG_NELL) <- c("CHR", "SNP", "gPoint", "END", "NumberOfSites", "Fst")
colnames(LANG_NISS) <- c("CHR", "SNP", "gPoint", "END", "NumberOfSites", "Fst")
colnames(LANG_OSTR) <- c("CHR", "SNP", "gPoint", "END", "NumberOfSites", "Fst")
colnames(OSTR_MOLU) <- c("CHR", "SNP", "gPoint", "END", "NumberOfSites", "Fst")
colnames(OSTR_NELL) <- c("CHR", "SNP", "gPoint", "END", "NumberOfSites", "Fst")
colnames(OSTR_NISS) <- c("CHR", "SNP", "gPoint", "END", "NumberOfSites", "Fst")
colnames(NISS_MOLU) <- c("CHR", "SNP", "gPoint", "END", "NumberOfSites", "Fst")
colnames(NISS_NELL) <- c("CHR", "SNP", "gPoint", "END", "NumberOfSites", "Fst")
colnames(NELL_MOLU) <- c("CHR", "SNP", "gPoint", "END", "NumberOfSites", "Fst")


# Adds Pops column to each DF ~
LANG_MOLU$Pops <- factor(paste("Langesand_Sørlandsleia Vs Molunat"))
LANG_NELL$Pops <- factor(paste("Langesand_Sørlandsleia Vs Loch_Nell"))
LANG_NISS$Pops <- factor(paste("Langesand_Sørlandsleia Vs Nissum"))
LANG_OSTR$Pops <- factor(paste("Langesand_Sørlandsleia Vs Ostrevigtjønn_Hauge_I_Dalane"))
OSTR_MOLU$Pops <- factor(paste("Ostrevigtjønn_Hauge_I_Dalane Vs Molunat"))
OSTR_NELL$Pops <- factor(paste("Ostrevigtjønn_Hauge_I_Dalane Vs Loch_Nell"))
OSTR_NISS$Pops <- factor(paste("Ostrevigtjønn_Hauge_I_Dalane Vs Nissum"))
NISS_MOLU$Pops <- factor(paste("Nissum Vs Molunat"))
NISS_NELL$Pops <- factor(paste("Nissum Vs Loch_Nell"))
NELL_MOLU$Pops <- factor(paste("Loch_Nell Vs Molunat"))


# Gets column names ~
Fst_Window_ColumnNames <- colnames(LANG_MOLU)


# Merges DFs ~
fulldf0 <- full_join(NISS_NELL, LANG_NELL,  by = Fst_Window_ColumnNames)
fulldf <- full_join(fulldf0, NELL_MOLU, by = Fst_Window_ColumnNames)
#fulldf <- full_join(fulldf, LANG_OSTR, by = Fst_Window_ColumnNames)
#fulldf <- full_join(fulldf, OSTR_MOLU, by = Fst_Window_ColumnNames)
#fulldf <- full_join(fulldf, OSTR_NELL, by = Fst_Window_ColumnNames)
#fulldf <- full_join(fulldf, OSTR_NISS, by = Fst_Window_ColumnNames)
#fulldf <- full_join(fulldf, NISS_MOLU, by = Fst_Window_ColumnNames)
#fulldf <- full_join(fulldf, NISS_NELL, by = Fst_Window_ColumnNames)
#fulldf <- full_join(fulldf, NELL_MOLU, by = Fst_Window_ColumnNames)


# Reorders Species ~
fulldf$Pops <- factor(fulldf$Pops, ordered = T,
                            levels = c("Langesand_Sørlandsleia Vs Nissum",
                                       "Langesand_Sørlandsleia Vs Ostrevigtjønn_Hauge_I_Dalane",
                                       "Ostrevigtjønn_Hauge_I_Dalane Vs Nissum",
                                       "Langesand_Sørlandsleia Vs Loch_Nell",
                                       "Ostrevigtjønn_Hauge_I_Dalane Vs Loch_Nell",
                                       "Nissum Vs Loch_Nell",
                                       "Loch_Nell Vs Molunat",
                                       "Ostrevigtjønn_Hauge_I_Dalane Vs Molunat",
                                       "Langesand_Sørlandsleia Vs Molunat",
                                       "Nissum Vs Molunat"))
fulldf$CHR <- factor(fulldf$CHR, ordered = T,
                      levels = c("scaffold1",
                                 "scaffold2",
                                 "scaffold3",
                                 "scaffold4",
                                 "scaffold5",
                                 "scaffold6",
                                 "scaffold7",
                                 "scaffold8",
                                 "scaffold9",
                                 "scaffold10"))

y_strip_labels <- c("scaffold1" = "CHR 01", "scaffold2" = "CHR 02", "scaffold3" = "CHR 03", "scaffold4" = "CHR 04",
                    "scaffold5" = "CHR 05", "scaffold6" = "CHR 06", "scaffold7" = "CHR 07", "scaffold8" = "CHR 08",
                    "scaffold9" = "CHR 09", "scaffold10" = "CHR 10")

#### Creates Manhattan panel ~ ####
Fst_Window <-
  ggplot() +
  geom_line(data = fulldf, aes(x = gPoint, y = Fst, colour = Pops), linetype = 1, size = .2) +
  facet_rep_grid(CHR ~. , scales = "free", labeller = labeller(CHR = y_strip_labels)) +
  scale_x_continuous("Genomic Position",
                     breaks = c( 15000000, 30000000, 40000000, 50000000, 60000000, 70000000, 80000000, 90000000, 100000000, 110000000, 115000000), 
                     labels = c( "15Mb", "30Mb", "40Mb", "50Mb", "60Mb", "70Mb", "80Mb","90Mb","100Mb", "110Mb", "115Mb"),
                     limits = c(0,115000000 ),
                     expand = c(0.01, 0.01)) +
  scale_y_continuous("Fst Across Chromosomes",
                     breaks = c(.25, .5, .75), 
                     labels = c(".25", ".50", ".75"),
                     limits = c(0, 1),
                     expand = c(0.01, 0.01)) +
  scale_colour_manual(values = c("#083359", "#BF820F",  "#1BBC9B")) +
  theme(panel.background = element_rect(fill = "#ffffff"),
        panel.border = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "#000000", size = .3),
        axis.title.x = element_text(size = 16, face = "bold", color = "#000000", margin = margin(t = 30, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(size = 16, face = "bold", color = "#000000", margin = margin(t = 0, r = 30, b = 0, l = 0)),
        axis.text = element_text(colour = "#000000", size = 10),
        axis.ticks = element_line(color = "#000000", size = .3),
        strip.background.y = element_rect(colour = "#000000", fill = "#d6d6d6", size = 0.3),
        strip.text = element_text(colour = "#000000", size = 10, face = "bold"),
        legend.position = "top",
        legend.margin = margin(t = 0, b = 0, r = 0, l = 0),
        legend.box.margin = margin(t = 30, b = 25, r = 0, l = 0),
        legend.key = element_rect(fill = NA),
        legend.background =element_blank()) +
  guides(colour = guide_legend(title = "Fst Comparisons:", title.theme = element_text(size = 16, face = "bold"),
                             label.theme = element_text(size = 16), override.aes = list(size = 1.4)),
         fill = "none")


# Saves Manhattan plot ~
ggsave(Fst_Window, file = "~/Desktop/Scripts/Flat_oysters/04_local_R/03_results/FST/SLWin_15K_Feb22list--Fst-Windows--NISS_NELl.LANG_NELL.NELL_MOLU_resize.pdf", device = cairo_pdf, scale = 1, width = 26, height = 20, dpi = 600)
dev.off()



##### Scandinavia Manhattan plot #####
fulldf0 <- full_join(LANG_NISS, OSTR_NISS,  by = Fst_Window_ColumnNames)
fulldf <- full_join(fulldf0, LANG_OSTR, by = Fst_Window_ColumnNames)

fulldf$CHR <- factor(fulldf$CHR, ordered = T,
                     levels = c("scaffold1",
                                "scaffold2",
                                "scaffold3",
                                "scaffold4",
                                "scaffold5",
                                "scaffold6",
                                "scaffold7",
                                "scaffold8",
                                "scaffold9",
                                "scaffold10"))

Fst_Window2 <-
  ggplot() +
  geom_line(data = fulldf, aes(x = gPoint, y = Fst, colour = Pops), linetype = 1, size = .2) +
  facet_rep_grid(CHR ~. , scales = "free", labeller = labeller(CHR = y_strip_labels)) +
  scale_x_continuous("Genomic Position",
                     breaks = c( 15000000, 30000000, 40000000, 50000000, 60000000, 70000000, 80000000, 90000000, 100000000, 110000000, 115000000), 
                     labels = c( "15Mb", "30Mb", "40Mb", "50Mb", "60Mb", "70Mb", "80Mb","90Mb","100Mb", "110Mb", "115Mb"),
                     limits = c(0,115000000 ),
                     expand = c(0.01, 0.01)) +
  scale_y_continuous("Fst Across Chromosomes",
                     breaks = c(.25, .5, .75), 
                     labels = c(".25", ".50", ".75"),
                     limits = c(0, 1),
                     expand = c(0.01, 0.01)) +
  scale_colour_manual(values = c("#33691E", "#ACEBAE", "#ff9dff")) +
  theme(panel.background = element_rect(fill = "#ffffff"),
        panel.border = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "#000000", size = .3),
        axis.title.x = element_text(size = 16, face = "bold", color = "#000000", margin = margin(t = 30, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(size = 16, face = "bold", color = "#000000", margin = margin(t = 0, r = 30, b = 0, l = 0)),
        axis.text = element_text(colour = "#000000", size = 10),
        axis.ticks = element_line(color = "#000000", size = .3),
        strip.background.y = element_rect(colour = "#000000", fill = "#d6d6d6", size = 0.3),
        strip.text = element_text(colour = "#000000", size = 10, face = "bold"),
        legend.position = "top",
        legend.margin = margin(t = 0, b = 0, r = 0, l = 0),
        legend.box.margin = margin(t = 30, b = 25, r = 0, l = 0),
        legend.key = element_rect(fill = NA),
        legend.background =element_blank()) +
  guides(colour = guide_legend(title = "Fst Comparisons:", title.theme = element_text(size = 16, face = "bold"),
                               label.theme = element_text(size = 16), override.aes = list(size = 1.4)),
         fill = "none")

# Saves Manhattan plot ~
ggsave(Fst_Window2, file = "~/Desktop/Scripts/Flat_oysters/04_local_R/03_results/FST/SLWin_15K_Feb22list--Fst-Windows--NISS_OSTR_LANGresize.pdf", device = cairo_pdf, scale = 1, width = 26, height = 20, dpi = 600)
dev.off()
#
##
### The END ~~~~~