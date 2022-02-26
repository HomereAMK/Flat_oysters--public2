### The BEGINNING ~~~~~
##
# ~ Plots BGS_AtlanticCod--ngsAdmix | First written by Jose Samaniego with later modifications by George Pacheco.

# Cleans the environment ~ 
rm(list=ls())


# Sets working directory ~
#setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
setwd("~/Desktop/Scripts/Data/NGSadmix")

# Loads required packages ~
pacman::p_load(tidyverse, scales, optparse, plyr, RColorBrewer, extrafont, gtable, grid, mdthemes, ggtext, glue)


# Creates colour palette ~
nb.cols <- 15
MyColours <- colorRampPalette(brewer.pal(9, "Paired"))(nb.cols)


# Loads the data ~
samples <- read.table("~/Desktop/Scripts/Data/NGSadmix/Leona20dec21_SNPs_11jan22-AllSamples--popfile.txt", stringsAsFactors = FALSE, sep = "\t")


# Reads the annotation file ~
ids <- read.table("~/Desktop/Scripts/Data/NGSadmix/Bam_list_13dec21.annot", stringsAsFactors = FALSE, sep = "\t", header = FALSE)


# Adds column ids names ~
colnames(ids) <- c("Sample_ID", "Population")


# Loads MissingData ~


# Adds column names to MissingData ~
#colnames(MissingData) <- c("Sample_ID", "NumberMissing", "PercentageMissing")


# Binds the 2 DFs based on common columns ~
#idsUp <- merge(ids, MissingData, by = "Sample_ID")


# Ask Sama ~
fulldf <- data.frame()


# Ask Sama 2 ~
x <- list(c(13, 11, 15, 5, 3, 6, 1, 8, 2, 10, 14, 4, 7, 12, 9),
          c(1, 9, 12, 3, 5, 8, 11, 13, 6, 4, 10, 2, 7, 14),
          c(11, 4, 7, 6, 1, 10, 13, 9, 12, 8, 3, 2, 5),
          c(8, 11, 3, 1, 12, 2, 10, 9, 4, 7, 5, 6),
          c(5, 4, 6, 8, 10, 3, 9, 7, 2, 11, 1),#c(1,2,3,4,5,6,7,8,9,10,11), #K=11
          c(9, 3, 7, 4, 8, 6, 1, 10, 5, 2), #K=10
          c(8, 6, 7, 4, 1, 5, 2, 3, 9), #K=9
          c(8, 7, 3, 6, 5, 4, 2, 1), #K=8
          c(7, 3, 1, 4, 6, 2, 5), #K=7
          c(6, 5, 2, 1, 4, 3), #K=6
          c(5, 4, 3, 1, 2), #K=5
          c(4, 2, 3, 1), #K=4
          c(3, 1, 2),   #K=3
          c(2, 1))  #K=2


# Defines samples' IDs ~
sampleid = "Sample_ID"


# Ask Sama 3 ~
for (j in 1:length(samples[,1])){
  data <- read.table(samples[j,1])[, x[[j]]]
  for (i in 1:dim(data)[2]) { 
    temp <- data.frame(Ancestry = data[, i])
    temp$K <- as.factor(rep(i, times = length(temp$Ancestry)))
    temp[sampleid] <- as.factor(ids[sampleid][,1])
    temp$K_Value <- as.factor(rep(paste("K = ", dim(data)[2], sep = ""), times = length(temp$Ancestry)))
    temp <- merge(ids, temp)
    fulldf <- rbind(fulldf, temp)}}


# Specifies xbalebels colours ~
#fulldf$xlabelscolours <- ifelse(fulldf$PercentageMissing > 50, "red", "black")



# Reorders Population ~
fulldf$Population <- factor(fulldf$Population, ordered = T,
                          levels = c("MOLU", "ZECE", "CRES",
                                     "ORIS","CORS", "PONT",  "RIAE",
                                     "MORL",
                                     "USAM",
                                     "TOLL", "COLN", "BARR", 
                                     "TRAL", "CLEW",
                                      "RYAN", "NELL",
                                     "GREV", "WADD", 
                                     "FURI", "NISS","LOGS","VENO", "HALS", "THIS",
                                     "HVAD", "KALV",  "HFJO", "RAMS", "ORNE", "HYPP",
                                     "LANG", "BUNN", "DOLV", "HAUG", "HAFR",  
                                     "INNE","VAGS", "AGAB", "OSTR"))



#fulldf$xlabelscolours_Ordered <- fulldf$xlabelscolours[order(fulldf$Population)]


# Defines the target to be plotted ~
target = "Population"

fulldf <- fulldf %>% filter(Population != "HVAD")

# Creates the plots ~
ngsAdmix <-
 ggplot(fulldf, aes(x = Sample_ID, y = Ancestry, fill = K)) +
  geom_bar(stat = "identity", width = .85) +
   facet_grid(K_Value ~ get(target), space = "free_x", scales = "free_x") +
   scale_x_discrete(expand = c(0, 0)) + 
   scale_y_continuous(expand = c(0, 0), breaks = NULL) +
 theme(
    panel.background = element_rect(fill = "#ffffff"),
    panel.grid.minor.x = element_blank(),
    panel.grid.major = element_blank(),
    panel.spacing = unit(.2, "lines"),
    plot.title = element_blank(),
    axis.title = element_blank(),
    axis.text.x.bottom = element_text(colour = "#000000", face = "bold", angle = 90, vjust = .5, hjust = .5, size = 1),
    axis.text.y = element_blank(),
    axis.ticks = element_blank(),
    strip.background = element_rect(colour = "#000000", fill = "#FAFAFA", size = .05),
    strip.text.x = element_text(colour = "#000000", face = "bold", size = 4, angle = 90, margin = margin(.75, 0, .75, 0, "cm")),
    strip.text.y = element_text(colour = "#000000", face = "bold", size = 10, angle = 90, margin = margin(0, .1, 0, .1, "cm")),
    legend.position = "none")
 
 
 # Saves the final plot ~
 ggsave(ngsAdmix, file = "~/Desktop/Scripts/Flat_oysters/04_local_R/03_results/Leona-Flatoysters--ngsAdmix_RColours.pdf", device = cairo_pdf, width = 16, height = 8, dpi = 600)







# Adds grob ~
ngsAdmix_G <- ggplotGrob(ngsAdmix)
ngsAdmix_G <- gtable_add_rows(ngsAdmix_G, unit(1.25, "cm"), pos = 5)


# Adds top strips ~
ngsAdmix_G <- gtable_add_grob(ngsAdmix_G, list(rectGrob(gp = gpar(col = "#000000", fill = "#44AA99", alpha = .9, size = .75, lwd = 0.25)),
               textGrob("Remote Localities Within Natural Range", gp = gpar(cex = 1.4, fontface = 'bold', col = "black"))),
               t = 6, l = 4, b = 6, r = 17, name = c("a", "b"))
ngsAdmix_G <- gtable_add_grob(ngsAdmix_G, list(rectGrob(gp = gpar(col = "#000000", fill = "#F0E442", alpha = .9, size = .75, lwd = 0.25)),
               textGrob("Urban Localities Within Natural Range", gp = gpar(cex = 1.4, fontface = 'bold', col = "black"))),
               t = 6, l = 19, b = 6, r = 49, name = c("a", "b"))
ngsAdmix_G <- gtable_add_grob(ngsAdmix_G, list(rectGrob(gp = gpar(col = "#000000", fill = "#E69F00", alpha = .9, size = .5, lwd = 0.25)),
               textGrob("Localities Outside Natural Range", gp = gpar(cex = 1.4, fontface = 'bold', col = "black"))),
               t = 6, l = 51, b = 6, r = 75, name = c("a", "b"))
ngsAdmix_G <- gtable_add_grob(ngsAdmix_G, list(rectGrob(gp = gpar(col = "#000000", fill = "#56B4E9", alpha = .9, size = .5, lwd = 0.25)),
               textGrob("Captives", gp = gpar(cex = 1.4, fontface = 'bold', col = "black"))),
               t = 6, l = 77, b = 6, r = 81, name = c("a", "b"))


# Controls separation ~
ngsAdmix_G <- gtable_add_rows(ngsAdmix_G, unit(2/10, "line"), 6)


# Creates the final plot ~
grid.newpage()
grid.draw(ngsAdmix_G)


# Saves the final plot ~
ggsave(ngsAdmix_G, file = "FPG--ngsAdmix_RColours.pdf", device = cairo_pdf, width = 40, height = 15, dpi = 600)


#
##
### The END ~~~~~



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20),
#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19),
#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18),
#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17),
#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16),
#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15),
#c(1,2,3,4,5,6,7,8,9,10,11,12,13,14),
#c(1,2,3,4,5,6,7,8,9,10,11,12,13),
#c(1,2,3,4,5,6,7,8,9,10,11,12),
#c(1,2,3,4,5,6,7,8,9,10,11),
#c(1,2,3,4,5,6,7,8,9,10),
#c(1,2,3,4,5,6,7,8,9),
#c(1,2,3,4,5,6,7,8),
#c(1,2,3,4,5,6,7),
#c(1,2,3,4,5,6),
#c(1,2,3,4,5),
#c(1,2,3,4),
#c(1,2,3),
#c(1,2))