### The BEGINNING ~~~~~
##
# ~ Plots BSG_Turbot--PopGenEstimates | designed George Pacheco modified by Homère J. Alves Monteiro


# Cleans the environment ~ 
rm(list=ls())


# Sets working directory ~
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# Loads required packages ~
pacman::p_load(tidyverse, lemon, extrafont)


# Imports extra fonts ~
#loadfonts(device = "win", quiet = TRUE)


# Loads datasets ~
MOLU <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_MOLU_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)
ZECE <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_ZECE_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE) 
CRES <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_CRES_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)
ORIS <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_ORIS_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)
CORS <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_CORS_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)
PONT <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_PONT_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)
RIAE <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_RIAE_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)
USAM <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_USAM_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)
TOLL <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_TOLL_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)
COLN <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_COLN_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)
BARR <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_BARR_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE) 
TRAL <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_TRAL_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)
CLEW <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_CLEW_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)
RYAN <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_RYAN_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE) 
NELL <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_NELL_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)
GREV <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_GREV_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)
WADD <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_WADD_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)
FURI <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_FURI_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)
NISS <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_NISS_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)
LOGS <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_LOGS_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)
VENO <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_VENO_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE) 
HALS <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_HALS_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE) 
THIS <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_THIS_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)
KALV <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_KALV_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE) 
HFJO <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_HFJO_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE) 
RAMS <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_RAMS_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE) 
ORNE <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_ORNE_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)
HYPP <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_HYPP_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)
LANG <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_LANG_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE) 
BUNN <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_BUNN_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE) 
DOLV <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_DOLV_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE) 
HAUG <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_HAUG_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE) 
HAFR <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_HAFR_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)  
INNE <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_INNE_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)
VAGS <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_VAGS_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)
AGAB <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_AGAB_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)
OSTR <- read.table("~/Desktop/Scripts/Data/PopGenEstimates/Dataset_I/window/Feb22--Unfolded_PopGen_OSTR_PopGenEstimates-Windows15kb-Steps15kb.tsv", header = TRUE)

# Adds Pops column to each Fst comparisons ~
MOLU$Pops <- factor(paste("MOLU"))
ZECE$Pops <- factor(paste("ZECE")) 
CRES$Pops <- factor(paste("CRES")) 
ORIS$Pops <- factor(paste("ORIS")) 
CORS$Pops <- factor(paste("CORS"))
PONT$Pops <- factor(paste("PONT"))
RIAE$Pops <- factor(paste("RIAE"))
USAM$Pops <- factor(paste("USAM"))
TOLL$Pops <- factor(paste("TOLL"))
COLN$Pops <- factor(paste("COLN"))
BARR$Pops <- factor(paste("BARR"))
TRAL$Pops <- factor(paste("TRAL"))
CLEW$Pops <- factor(paste("CLEW"))
RYAN$Pops <- factor(paste("RYAN"))
NELL$Pops <- factor(paste("NELL"))
GREV$Pops <- factor(paste("GREV"))
WADD$Pops <- factor(paste("WADD"))
FURI$Pops <- factor(paste("FURI"))
NISS$Pops <- factor(paste("NISS"))
LOGS$Pops<- factor(paste("LOGS"))
VENO$Pops <- factor(paste("VENO"))
HALS$Pops <- factor(paste("HALS"))
THIS$Pops <- factor(paste("THIS"))
KALV$Pops <- factor(paste("KALV"))
HFJO$Pops <- factor(paste("HFJO"))
RAMS$Pops <- factor(paste("RAMS"))
ORNE$Pops <- factor(paste("ORNE"))
HYPP$Pops <- factor(paste("HYPP"))
LANG$Pops <- factor(paste("LANG"))
BUNN$Pops <- factor(paste("BUNN"))
DOLV$Pops <- factor(paste("DOLV"))
HAUG$Pops <- factor(paste("HAUG"))
HAFR$Pops <- factor(paste("HAFR")) 
INNE$Pops <- factor(paste("INNE"))
VAGS$Pops <- factor(paste("VAGS"))
AGAB$Pops <- factor(paste("AGAB"))
OSTR$Pops <- factor(paste("OSTR"))


# Gets column names ~
PopGenEstimates_Windows_ColumnNames <- colnames(BARR)


# Merges DFs ~
fulldf0 <- full_join(USAM, NISS, by = PopGenEstimates_Windows_ColumnNames)
fulldf <- full_join(fulldf0, OSTR, by = PopGenEstimates_Windows_ColumnNames)


# Converts DF from wide into long ~
fulldfUp <- gather(fulldf, Category, Value, "Tp")


# Reorders Species ~
fulldf$Pops <- factor(fulldf$Pops, ordered = T,
                            levels = c("MOLU", "ZECE", "CRES",
                                       "ORIS","CORS", "PONT",  "RIAE",
                                       "USAM",
                                       "TOLL", "COLN", "BARR", 
                                       "TRAL", "CLEW",
                                       "RYAN", "NELL",
                                       "GREV", "WADD", 
                                       "FURI", "NISS","LOGS","VENO", "HALS", "THIS",
                                       "HVAD", "KALV",  "HFJO", "RAMS", "ORNE", "HYPP",
                                       "LANG", "BUNN", "DOLV", "HAUG", "HAFR",  
                                       "INNE","VAGS", "AGAB", "OSTR"))

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


# Creates Tp plot ~
Tp_Plot <-
  ggplot() +
  geom_line(data = fulldf, aes(x = gPoint, y = Tp, colour = Pops), linetype = 1, size = .2) +
  facet_rep_grid(CHR ~. , scales = "free", labeller = labeller(CHR = y_strip_labels)) +
  geom_hline(yintercept = 0, linetype = "dotted", size = .2, color = "#FF6545") +
  scale_x_continuous("Genomic Position",
                     breaks = c( 15000000, 30000000, 40000000, 50000000, 60000000, 70000000, 80000000, 90000000, 100000000, 110000000, 115000000), 
                     labels = c( "15Mb", "30Mb", "40Mb", "50Mb", "60Mb", "70Mb", "80Mb","90Mb","100Mb", "110Mb", "115Mb"),
                     limits = c(0,115000000 ),
                     expand = c(0.01, 0.01)) +
  scale_y_continuous("Nucleotide Diversity Across Chrmosomes",
                     breaks = c(.005, .015, 0.025), 
                     labels = c(".005", ".015", ".025" ),
                     limits = c(0, .025),
                     expand = c(0.0025, 0.0025)) +
  scale_colour_manual(values = c("#000000", "#02630C", "#240377")) +
  theme(panel.background = element_rect(fill = "#ffffff"),
        panel.border = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "#000000", size = .3),
        axis.title.x = element_text(size = 20, face = "bold", color = "#000000", margin = margin(t = 30, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(size = 20, face = "bold", color = "#000000", margin = margin(t = 0, r = 30, b = 0, l = 0)),
        axis.text = element_text(colour = "#000000", size = 15, face = "bold"),
        axis.ticks = element_line(color = "#000000", size = .3),
        strip.background.y = element_rect(colour = "#000000", fill = "#d6d6d6", size = .3),
        strip.text = element_text(colour = "#000000", size = 11.5, face = "bold"),
        legend.position = "top",
        legend.margin = margin(t = 0, b = 0, r = 0, l = 0),
        legend.box.margin = margin(t = 30, b = 25, r = 0, l = 0),
        legend.key = element_rect(fill = NA),
        legend.background =element_blank()) +
  guides(colour = guide_legend(title = "Populations:", title.theme = element_text(size = 21, face = "bold"),
                               label.theme = element_text(size = 19), override.aes = list(size = 1.4)),
         fill = "none")


# Saves Tp plot ~
ggsave(Tp_Plot, file = "~/Desktop/Scripts/Flat_oysters/04_local_R/03_results/PopGenEstimates/window/USAM_NISS_OSTR_PopGenEstimates-Windows_π.pdf",
       device = cairo_pdf, scale = 1, width = 26, height = 30, dpi = 600)

§§§§§§§§§§§§§§§§§§§§
# Removes uncommon Windows ~
#setdiff(NorthSea$SNP, BalticSea$SNP)
#setdiff(Kattegat$SNP, BalticSea$SNP)
NorthSea <- NorthSea %>% filter(SNP != "CP026246.1:20650000")
Kattegat <- Kattegat %>% filter(SNP != "CP026246.1:20650000")


# Gets DiffTp ~
NorthSea_R <- NorthSea[, c(1:4, 9)]
BalticSea_R <- BalticSea[, c(1:4, 9)]
NorthSea_BalticSea <- cbind(NorthSea_R, BalticSea_R)
NorthSea_BalticSea$DiffTp <- NorthSea_BalticSea[, 5] - NorthSea_BalticSea[, 10]
NorthSea_BalticSea <- NorthSea_BalticSea[, c(1:4, 11)]


# Creates DiffTp plot ~
DiffTp_Plot <-
  ggplot() +
  geom_line(data = NorthSea_BalticSea, aes(x = gPoint, y = DiffTp), colour = "#088080", linetype = 1, size = .6) +
  facet_rep_grid(CHR ~. , scales = "free", labeller = labeller(CHR = y_strip_labels)) +
  geom_hline(yintercept = 0, linetype = "dotted", size = .3, color = "#FF6545") +
  scale_x_continuous("Genomic Position",
                     breaks = c(5000000, 10000000, 15000000, 20000000, 25000000, 30000000), 
                     labels = c("5Mb", "10Mb", "15Mb", "20Mb", "25Mb", "30Mb"),
                     limits = c(0, 31800000),
                     expand = c(0.01, 0.01)) +
  scale_y_continuous("\U0394 Nucleotide Diversity Across Chrmosomes (North Sea - Baltic Sea)",
                     breaks = c(-.002, .002), 
                     labels = c("-.002", ".002"),
                     limits = c(-0.00175, 0.003074),
                     expand = c(0.0025, 0.0025)) +
  scale_colour_manual(values = c("#4daf4a", "#377eb8", "#e41a1c")) +
  theme(panel.background = element_rect(fill = "#ffffff"),
        panel.border = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "#000000", size = .3),
        axis.title.x = element_text(size = 20, face = "bold", color = "#000000", margin = margin(t = 30, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(size = 20, face = "bold", color = "#000000", margin = margin(t = 0, r = 30, b = 0, l = 0)),
        axis.text = element_text(colour = "#000000", size = 15, face = "bold"),
        axis.ticks = element_line(color = "#000000", size = .3),
        strip.background.y = element_rect(colour = "#000000", fill = "#d6d6d6", size = .3),
        strip.text = element_text(colour = "#000000", size = 11.5, face = "bold"),
        legend.position = "top",
        legend.margin = margin(t = 0, b = 0, r = 0, l = 0),
        legend.box.margin = margin(t = 30, b = 25, r = 0, l = 0),
        legend.key = element_rect(fill = NA),
        legend.background =element_blank()) +
  guides(colour = guide_legend(title = "Populations:", title.theme = element_text(size = 21, face = "bold"),
                               label.theme = element_text(size = 19), override.aes = list(size = 1.4)),
         fill = "none")


# Saves DiffTp plot ~
ggsave(DiffTp_Plot, file = "BSG_Turbot_Ind66_20K_PopGenEstimates-Windows_DiffTp.pdf",
       device = cairo_pdf, scale = 1, width = 26, height = 30, dpi = 600)
ggsave(DiffTp_Plot, file = "BSG_Turbot_Ind66_20K_PopGenEstimates-Windows_DiffTp.jpg",
       scale = 1, width = 26, height = 30, dpi = 600)


# Creates Tw plot ~
Tw_Plot <-
  ggplot() +
  geom_line(data = fulldf, aes(x = gPoint, y = Tw, colour = Pops), linetype = 1, size = .6) +
  facet_rep_grid(CHR ~. , scales = "free", labeller = labeller(CHR = y_strip_labels)) +
  scale_x_continuous("Genomic Position",
                     breaks = c(5000000, 10000000, 15000000, 20000000, 25000000, 30000000), 
                     labels = c("5Mb", "10Mb", "15Mb", "20Mb", "25Mb", "30Mb"),
                     limits = c(0, 31800000),
                     expand = c(0.01, 0.01)) +
  scale_y_continuous("Watterson's Theta Across Chrmosomes",
                     breaks = c(0, .02, .04), 
                     labels = c("0.00", "0.02", "0.04"),
                     limits = c(0, .0415),
                     expand = c(0.0025, 0.0025)) +
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
  guides(colour = guide_legend(title = "Populations:", title.theme = element_text(size = 21, face = "bold"),
                               label.theme = element_text(size = 19), override.aes = list(size = 1.4)),
         fill = "none")


# Saves Tw plot ~
ggsave(Tw_Plot, file = "BSG_Turbot_Ind66_20K_PopGenEstimates-Windows_Tw.pdf",
       device = cairo_pdf, scale = 1, width = 26, height = 30, dpi = 600)


# Creates Td plot ~
Td_Plot <-
  ggplot() +
  geom_line(data = fulldf, aes(x = gPoint, y = Td, colour = Pops), linetype = 1, size = .6) +
  facet_rep_grid(CHR ~. , scales = "free", labeller = labeller(CHR = y_strip_labels)) +
  scale_x_continuous("Genomic Position",
                     breaks = c(5000000, 10000000, 15000000, 20000000, 25000000, 30000000), 
                     labels = c("5Mb", "10Mb", "15Mb", "20Mb", "25Mb", "30Mb"),
                     limits = c(0, 31800000),
                     expand = c(0.01, 0.01)) +
  scale_y_continuous("Tajima's D Across Chrmosomes",
                     breaks = c(-1.5, 0, 1.5), 
                     labels = c("-1.5", "0", "1.5"),
                     limits = c(-2.375, 3.0),
                     expand = c(0.0025, 0.0025)) +
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
  guides(colour = guide_legend(title = "Populations:", title.theme = element_text(size = 21, face = "bold"),
                               label.theme = element_text(size = 19), override.aes = list(size = 1.4)),
         fill = "none")


# Saves Td plot ~
ggsave(Td_Plot, file = "BSG_Turbot_Ind66_20K_PopGenEstimates-Windows_Td.pdf",
       device = cairo_pdf, scale = 1, width = 26, height = 30, dpi = 600)


#
##
### The END ~~~~~