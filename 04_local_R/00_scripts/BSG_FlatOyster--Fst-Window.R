### The BEGINNING ~~~~~
##
# ~ Plots BSG_Turbot--Fst | By George Pacheco.


# Cleans the environment ~ 
rm(list=ls())


# Sets working directory ~
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Loads required packages ~
pacman::p_load(tidyverse, extrafont, lemon)


# Imports extra fonts ~
loadfonts(device = "win", quiet = TRUE)


# Loads datasets ~
NorthSea_Kattegat <- read.table("BSG_Turbot_NorthSea.Kattegat_Ind66_20K--Fst-Window.tsv", header = FALSE)
NorthSea_BalticSea <- read.table("BSG_Turbot_NorthSea.BalticSea_Ind66_20K--Fst-Window.tsv", header = FALSE)
Kattegat_BalticSea <- read.table("BSG_Turbot_Kattegat.BalticSea_Ind66_20K--Fst-Window.tsv", header = FALSE)


# Adds column names to MissingData ~
colnames(NorthSea_Kattegat) <- c("CHR", "SNP", "gPoint", "END", "NumberOfSites", "Fst")
colnames(NorthSea_BalticSea) <- c("CHR", "SNP", "gPoint", "END", "NumberOfSites", "Fst")
colnames(Kattegat_BalticSea) <- c("CHR", "SNP", "gPoint", "END", "NumberOfSites", "Fst")


# Adds Pops column to each DF ~
NorthSea_Kattegat$Pops <- factor(paste("North Sea Vs Kattegat"))
NorthSea_BalticSea$Pops <- factor(paste("North Sea Vs Baltic Sea"))
Kattegat_BalticSea$Pops <- factor(paste("Kattegat Vs Baltic Sea"))


# Gets column names ~
Fst_Window_ColumnNames <- colnames(NorthSea_Kattegat)


# Merges DFs ~
fulldf0 <- full_join(NorthSea_Kattegat, NorthSea_BalticSea, by = Fst_Window_ColumnNames)
fulldf <- full_join(fulldf0, Kattegat_BalticSea, by = Fst_Window_ColumnNames)


# Reorders Species ~
fulldf$Pops <- factor(fulldf$Pops, ordered = T,
                            levels = c("North Sea Vs Kattegat",
                                       "Kattegat Vs Baltic Sea",
                                       "North Sea Vs Baltic Sea"))


# Corrects the y-strip facet labels ~
y_strip_labels <- c("CP026243.1" = "CHR 01", "CP026244.1" = "CHR 02", "CP026245.1" = "CHR 03", "CP026246.1" = "CHR 04",
                    "CP026247.1" = "CHR 05", "CP026248.1" = "CHR 06", "CP026249.1" = "CHR 07", "CP026250.1" = "CHR 08",
                    "CP026251.1" = "CHR 09", "CP026252.1" = "CHR 10", "CP026253.1" = "CHR 11", "CP026254.1" = "CHR 12",
                    "CP026255.1" = "CHR 13", "CP026256.1" = "CHR 14", "CP026257.1" = "CHR 15", "CP026258.1" = "CHR 16",
                    "CP026259.1" = "CHR 17", "CP026260.1" = "CHR 18", "CP026261.1" = "CHR 19", "CP026262.1" = "CHR 20",
                    "CP026263.1" = "CHR 21", "CP026264.1" = "CHR 22")


# Creates Manhattan panel ~
Fst_Window <-
  ggplot() +
  geom_line(data = fulldf, aes(x = gPoint, y = Fst, colour = Pops), linetype = 1, size = .6) +
  facet_rep_grid(CHR ~. , scales = "free", labeller = labeller(CHR = y_strip_labels)) +
  scale_x_continuous("Genomic Position",
                     breaks = c(5000000, 10000000, 15000000, 20000000, 25000000, 30000000), 
                     labels = c("5Mb", "10Mb", "15Mb", "20Mb", "25Mb", "30Mb"),
                     limits = c(0, 31950000),
                     expand = c(0.01, 0.01)) +
  scale_y_continuous("Fst Across Chrmosomes",
                     breaks = c(.25, .5, .75), 
                     labels = c(".25", ".50", ".75"),
                     limits = c(0, 1),
                     expand = c(0.01, 0.01)) +
  scale_colour_manual(values = c("#4daf4a", "#377eb8", "#e41a1c")) +
  theme(panel.background = element_rect(fill = "#ffffff"),
        panel.border = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "#000000", size = .3),
        axis.title.x = element_text(size = 20, face = "bold", color = "#000000", margin = margin(t = 30, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(size = 20, face = "bold", color = "#000000", margin = margin(t = 0, r = 30, b = 0, l = 0)),
        axis.text = element_text(colour = "#000000", size = 15),
        axis.ticks = element_line(color = "#000000", size = .3),
        strip.background.y = element_rect(colour = "#000000", fill = "#d6d6d6", size = 0.3),
        strip.text = element_text(colour = "#000000", size = 11.5, face = "bold"),
        legend.position = "top",
        legend.margin = margin(t = 0, b = 0, r = 0, l = 0),
        legend.box.margin = margin(t = 30, b = 25, r = 0, l = 0),
        legend.key = element_rect(fill = NA),
        legend.background =element_blank()) +
  guides(colour = guide_legend(title = "Fst Comparisons:", title.theme = element_text(size = 21, face = "bold"),
                             label.theme = element_text(size = 19), override.aes = list(size = 1.4)),
         fill = "none")


# Saves Manhattan plot ~
ggsave(Fst_Window, file = "BSG_Turbot_Ind66_20K--Fst-Windows.pdf", device = cairo_pdf, scale = 1, width = 26, height = 30, dpi = 600)


#
##
### The END ~~~~~