### The BEGINNING ~~~~~
##
# ~ Plots BSG_Lumpfish--PCA | First written by Homère J. Alves Monteiro with later modifications by George Pacheco and Homère J. Alves Monteiro


# Cleans the environment ~ 
rm(list=ls())

# Sets working directory ~
#setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
setwd("~/Desktop/Scripts/")

# Loads required packages ~
pacman::p_load(optparse, tidyverse, plyr, RColorBrewer, extrafont, ggforce, ggstar, RcppCNPy)


# Imports extra fonts ~
#loadfonts(device = "win", quiet = TRUE)


#### Loads data ~ ####
data <- as.matrix(read.table("Data/PCA/Leona20dec21_SNPs_11jan22.covMat"))
annot <- read.table("Data/PCA/Bam_list_13dec21.annot", sep = "\t", header = FALSE, stringsAsFactors = FALSE)
MissingData <- read.table("Data/PCA/Leona20dec21_SNPs_11jan22.GL-MissingData.txt", sep = "\t", header = FALSE)
colnames(MissingData) <- c("Sample_ID", "NumberMissing", "PercentageMissing")


# Runs PCA ~
PCA <- eigen(data)


# Merges the first 3 PCs with annot ~
PCA_Annot <- as.data.frame(cbind(annot, PCA$vectors[, c(1:3)]))
colnames(PCA_Annot) <- c("Sample_ID", "Population", "PCA_1", "PCA_2", "PCA_3")


# Binds the 2 DFs based on common columns ~
fulldf <- merge(PCA_Annot, MissingData, by = "Sample_ID")


# PercentageMissing as Numeric ~
fulldf$PercentageMissing <- as.numeric(as.character(fulldf$PercentageMissing))


# Expands MissingData by adding MissingCategory ~
fulldf$MissingCategory <- ifelse(fulldf$PercentageMissing <= 10, "< 10%",
                           ifelse(fulldf$PercentageMissing <= 15, "< 15%",
                           ifelse(fulldf$PercentageMissing <= 25, "< 25%",
                           ifelse(fulldf$PercentageMissing <= 40, "< 40%",
                           ifelse(fulldf$PercentageMissing <= 50, "< 50%",
                           ifelse(fulldf$PercentageMissing <= 60, "< 60%", "> 60%"))))))


# Corrects legend labels ~
#levels(fulldf$Population <- sub("Oeresund", "?resund", fulldf$Population))
#levels(fulldf$Population <- sub("BalticSea", "Baltic Sea", fulldf$Population))


# Reorders Population ~
fulldf$Population <- factor(fulldf$Population, ordered = T,
                          levels = c("ORIS",
                                     "CORS", 
                                     "MOLU", "ZECE", "CRES", 
                                     "PONT",  "RIAE",
                                     "MORL",
                                     "USAM",
                                     "TOLL", "COLN", "BARR", 
                                     "TRAL", "CLEW",
                                     "NELL", "RYAN",
                                     "GREV", "WADD", 
                                     "FURI", "NISS","LOGS","VENO", "HALS", "THIS",
                                     "INNE", "HAUG", "HAFR", "AGAB", "OSTR", "VAGS", "LANG", "BUNN", "DOLV",
                                     "KALV",  "HFJO", "RAMS", "ORNE", "HYPP", "HVAD"))


# Gets Eigenvalues of each Eigenvectors ~
PCA_Eigenval_Sum <- sum(PCA$values)
varPC1 <-(PCA$values[1]/PCA_Eigenval_Sum)*100
varPC2 <-(PCA$values[2]/PCA_Eigenval_Sum)*100
varPC3 <-(PCA$values[3]/PCA_Eigenval_Sum)*100


#### Creates PCA plot Missing Data ~ #### 
PCA_MissData <-ggplot(fulldf, aes_string(x = "PCA_1", y = "PCA_2", fill = "MissingCategory")) +
  geom_point(alpha = .9, size = 2.75, shape = 21, colour = "#000000") +
  scale_fill_manual(values = c("#fef0d9", "#fdd49e", "#fdbb84", "#fc8d59", "#e34a33", "#b30000")) +
  scale_x_continuous(paste("PC1, ", round(varPC1,digits =3), "% variation", sep=""),
                     #breaks = c(0.99, 1, 1.01),
                     #labels = c("0.99", "1", "1.01"),
                     #limits = c(-0.25, 0.15),
                     expand = c(.015, .015)) +
  scale_y_continuous(paste("PC2, ", round(varPC2,digits =3), "% variation", sep=""),
                     #breaks = c(-0.05, -0.025, 0, 0.025, 0.05), 
                     #labels = c("-0.05", "-0.025", "0", "0.025", "0.05"), 
                     #limits = c(-0.0525, 0.0525),
                     expand = c(.015, .015)) +
  theme(panel.background = element_rect(fill = "#ffffff"),
        panel.border = element_blank(),
        panel.grid.minor = element_blank(), 
        panel.grid.major = element_blank(),
        legend.background = element_blank(),
        legend.key = element_blank(),
        legend.position = "right",
        legend.title = element_text(color = "#000000", size = 13),
        legend.text = element_text(size = 11),
        axis.title.x = element_text(size = 18, face = "bold", margin = margin(t = 20, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(size = 18, face = "bold", margin = margin(t = 0, r = 20, b = 0, l = 0)),
        axis.text = element_text(color = "#000000", size = 13),
        axis.ticks = element_line(color = "#000000", size = 0.3),
        axis.line = element_line(colour = "#000000", size = 0.3)) +
  guides(fill = guide_legend(title = "Population", title.theme = element_text(size = 15, face = "bold"),
                             label.theme = element_text(size = 14)))


# Saves plot ~
ggsave(PCA_MissData, file = "~/Desktop/Scripts/Flat_oysters/04_local_R/03_results/Leona_PCA_MissingCategory.pdf", device = cairo_pdf, scale = 1.1, width = 12, height = 8, dpi = 600)


#### Create PCA plot Missing Data - Labels #### 
LABELPCA_MissData  <-ggplot(fulldf, aes(PCA_1, PCA_2, label = Sample_ID)) +
      geom_point()+
      geom_label(aes(fill = MissingCategory))+
          scale_fill_manual(values = c("#fef0d9", "#fdd49e", "#fdbb84", "#fc8d59", "#e34a33", "#b30000"))+
  scale_x_continuous(paste("PC1, ", round(varPC1,digits =3), "% variation", sep=""),
                     #breaks = c(0.99, 1, 1.01),
                     #labels = c("0.99", "1", "1.01"),
                     #limits = c(-0.25, 0.15),
                     expand = c(.015, .015)) +
  scale_y_continuous(paste("PC2, ", round(varPC2,digits =3), "% variation", sep=""),
                     #breaks = c(-0.05, -0.025, 0, 0.025, 0.05), 
                     #labels = c("-0.05", "-0.025", "0", "0.025", "0.05"), 
                     #limits = c(-0.0525, 0.0525),
                     expand = c(.015, .015)) +
  theme(panel.background = element_rect(fill = "#ffffff"),
        panel.border = element_blank(),
        panel.grid.minor = element_blank(), 
        panel.grid.major = element_blank(),
        legend.background = element_blank(),
        legend.key = element_blank(),
        legend.position = "right",
        legend.title = element_text(color = "#000000", size = 13),
        legend.text = element_text(size = 11),
        axis.title.x = element_text(size = 18, face = "bold", margin = margin(t = 20, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(size = 18, face = "bold", margin = margin(t = 0, r = 20, b = 0, l = 0)),
        axis.text = element_text(color = "#000000", size = 13),
        axis.ticks = element_line(color = "#000000", size = 0.3),
        axis.line = element_line(colour = "#000000", size = 0.3)) +
  guides(fill = guide_legend(title = "Missing Data", title.theme = element_text(size = 15, face = "bold"),
                             label.theme = element_text(size = 14)))

# Saves plot ~
ggsave(LABELPCA_MissData, file = "~/Desktop/Scripts/Flat_oysters/04_local_R/03_results/Leona_PCA_LabelMissingCategory.pdf", device = cairo_pdf, scale = 1.1, width = 12, height = 8, dpi = 600)

#### Create PCA plot Missing Data - Labels #### 
LABELPCA_MissData_1vs3  <-ggplot(fulldf, aes(PCA_1, PCA_3, label = Sample_ID)) +
  geom_point()+
  geom_label(aes(fill = MissingCategory))+
  scale_fill_manual(values = c("#fef0d9", "#fdd49e", "#fdbb84", "#fc8d59", "#e34a33", "#b30000"))+
  scale_x_continuous(paste("PC1, ", round(varPC1,digits =3), "% variation", sep=""),
                     #breaks = c(0.99, 1, 1.01),
                     #labels = c("0.99", "1", "1.01"),
                     #limits = c(-0.25, 0.15),
                     expand = c(.015, .015)) +
  scale_y_continuous(paste("PC2, ", round(varPC2,digits =3), "% variation", sep=""),
                     #breaks = c(-0.05, -0.025, 0, 0.025, 0.05), 
                     #labels = c("-0.05", "-0.025", "0", "0.025", "0.05"), 
                     #limits = c(-0.0525, 0.0525),
                     expand = c(.015, .015)) +
  theme(panel.background = element_rect(fill = "#ffffff"),
        panel.border = element_blank(),
        panel.grid.minor = element_blank(), 
        panel.grid.major = element_blank(),
        legend.background = element_blank(),
        legend.key = element_blank(),
        legend.position = "right",
        legend.title = element_text(color = "#000000", size = 13),
        legend.text = element_text(size = 11),
        axis.title.x = element_text(size = 18, face = "bold", margin = margin(t = 20, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(size = 18, face = "bold", margin = margin(t = 0, r = 20, b = 0, l = 0)),
        axis.text = element_text(color = "#000000", size = 13),
        axis.ticks = element_line(color = "#000000", size = 0.3),
        axis.line = element_line(colour = "#000000", size = 0.3)) +
  guides(fill = guide_legend(title = "Missing Data", title.theme = element_text(size = 15, face = "bold"),
                             label.theme = element_text(size = 14)))

# Saves plot ~
ggsave(LABELPCA_MissData_1vs3, file = "~/Desktop/Scripts/Flat_oysters/04_local_R/03_results/Leona_PCA_MissingCategory_1vs3.pdf", device = cairo_pdf, scale = 1.1, width = 12, height = 8, dpi = 600)



#### Create PCA plot With Countries colors #### 
PCA<- ggplot(data = fulldf) + 
  geom_point(aes(x = PCA_1, y = PCA_2, color = Population, shape=Population)) +
  theme(legend.title  = element_blank())+
  scale_colour_manual(values =c( "#AD5B35",
                                 "#8E0917",
                                 "#A02353", "#A02353", "#A02353",
                                 "#CC480C",  "#CC480C",
                                 "#949191",                                                                          
                                 "#000000",
                                 "#D38C89", "#D38C89", "#D38C89",
                                 "#C89AD1", "#C89AD1",
                                 "#7210A0", "#7210A0",
                                 "#91BD96", "#91BD96",
                                 "#02630C", "#02630C","#02630C","#02630C", "#02630C", "#02630C",
                                 "#240377", "#240377", "#240377", "#240377", "#240377", "#240377", "#240377", "#240377", "#240377",
                                 "#45D1F7", "#45D1F7", "#45D1F7", "#45D1F7", "#45D1F7", "#45D1F7" ))+
  scale_shape_manual(values=c(16,
                              17,
                              16, 17, 18, 
                              16,17,
                              18,
                              17,
                              16,17,18,
                              18,16,
                              17,16,
                              17,18,
                              10, 6, 9, 8, 14,11,
                              10, 6, 9, 8, 14,11,0,1,12,
                              10, 6, 9, 8, 14,11))+
  xlab(paste("PC1, ", round(varPC1,digits =3), "% variation", sep="")) + 
  ylab(paste("PC2, ",round(varPC2, digits = 3),"% variation", sep="")) + 
  theme(legend.key = element_blank()) +
  theme(legend.title=element_blank()) +
  theme(axis.title.x = element_text(size = 10, color="#000000", face="bold", margin = margin(t = 20, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(size = 10, color="#000000", face="bold", margin = margin(t = 0, r = 20, b = 0, l = 0))) +
  theme(legend.text=element_text(size=11)) +
  theme(panel.background = element_rect(fill = '#FAFAFA')) +
  theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank()) +
  theme(axis.line = element_line(colour = "#000000", size = 0.3)) +
  theme(panel.border = element_blank())

# Saves plot ~
ggsave(PCA, file = "~/Desktop/Scripts/Flat_oysters/04_local_R/03_results/PRUNED-Leona_PCA.pdf", device = cairo_pdf, scale = 1.1, width = 12, height = 8, dpi = 600)

#### Create PCA plot With Countries colors 1vs3 #### 
PCA_1vs3<- ggplot(data = fulldf) + 
  geom_point(aes(x = PCA_1, y = PCA_3, color = Population, shape=Population)) +
  theme(legend.title  = element_blank())+
  scale_colour_manual(values =c( "#AD5B35",
                                 "#8E0917",
                                 "#A02353", "#A02353", "#A02353",
                                 "#CC480C",  "#CC480C",
                                 "#949191",                                                                          
                                 "#000000",
                                 "#D38C89", "#D38C89", "#D38C89",
                                 "#C89AD1", "#C89AD1",
                                 "#7210A0", "#7210A0",
                                 "#91BD96", "#91BD96",
                                 "#02630C", "#02630C","#02630C","#02630C", "#02630C", "#02630C",
                                 "#240377", "#240377", "#240377", "#240377", "#240377", "#240377", "#240377", "#240377", "#240377",
                                 "#45D1F7", "#45D1F7", "#45D1F7", "#45D1F7", "#45D1F7", "#45D1F7" ))+
  scale_shape_manual(values=c(16,
                              17,
                              16, 17, 18, 
                              16,17,
                              18,
                              17,
                              16,17,18,
                              18,16,
                              17,16,
                              17,18,
                              10, 6, 9, 8, 14,11,
                              10, 6, 9, 8, 14,11,0,1,12,
                              10, 6, 9, 8, 14,11))+
  xlab(paste("PC1, ", round(varPC1,digits =3), "% variation", sep="")) + 
  ylab(paste("PC3, ",round(varPC3, digits = 3),"% variation", sep="")) + 
  theme(legend.key = element_blank()) +
  theme(legend.title=element_blank()) +
  theme(axis.title.x = element_text(size = 10, color="#000000", face="bold", margin = margin(t = 20, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(size = 10, color="#000000", face="bold", margin = margin(t = 0, r = 20, b = 0, l = 0))) +
  theme(legend.text=element_text(size=11)) +
  theme(panel.background = element_rect(fill = '#FAFAFA')) +
  theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank()) +
  theme(axis.line = element_line(colour = "#000000", size = 0.3)) +
  theme(panel.border = element_blank())

# Saves plot ~
ggsave(PCA_1vs3, file = "~/Desktop/Scripts/Flat_oysters/04_local_R/03_results/PRUNED-Leona_PCA_1vs3.pdf", device = cairo_pdf, scale = 1.1, width = 12, height = 8, dpi = 600)

#
##
### The END ~~~~~

#### Loadings ####

