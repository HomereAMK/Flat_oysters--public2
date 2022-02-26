rm(list=ls())
ls()
library(qqman)
library(tidyverse)
library(data.table)
library(ggpubr)

#########NISS_HAUG
fst3 <- read.table("Desktop/Sequencing_depth_lcWGS/Lib1_manhattan_fst_NISS_HAUG_RAMS_PONT/01_data/slidingwindow15kbNISS__HAUG", head=T)
fst3$SNP <- c(1:length(fst3$chr))
fst3$chr <- as.factor(fst3$chr) # create a number instead of a str for each chromosome
fst3$chr <- as.factor(as.numeric(fst3$chr))
fst3$chr <- as.numeric(fst3$chr)
fst3$chr
NISS_HAUG <- as.data.frame(fst3)
#tiff(filename = "Desktop/Sequencing_depth_lcWGS/Lib1_manhattan_fst_NISS_HAUG_RAMS_PONT/03_results/NISS_HAUGManhattanfst15kb_5indperPopsnptdata.png")
tiff("Desktop/Sequencing_depth_lcWGS/Lib1_manhattan_fst_NISS_HAUG_RAMS_PONT/03_results/NISS_HAUGManhattanfst15kb_5indperPopsnptdata2.tiff", units="in", width=8, height=7, res=300)
NISS_HAUG <-manhattan(NISS_HAUG,chr="chr",bp="midPos",p="Fst",snp="SNP",
                      ylim=c(0,1),logp=FALSE,xlab = "Chromosomes",
                      ylab="Fst estimated from genotype likelihood for each SNP",
                      col = c("gray70", "skyblue3"), main="Nissum (DK) vs. Haugevågen (NO) \
                      Fst=0.048",
                      abline(h = mean(fst3$Fst), col="red"))
abline(h = mean(fst3$Fst), col="red")
mean(fst3$Fst)
dev.off()
# Identify the SNPs over the 99% quantile of the Fst distribution:
quantile(fst3$Fst, probs=0.999, na.rm=T) # SNPs with Fst over: 0.129238
which(fst3$Fst>0.20)
#highlight them in the Manhattan plot
index <- which(fst3$Fst>0.20)
snp_names <- fst3$SNP[index] # applies the index to the SNP vector
manhattan(fst3,chr="chr",bp="midPos",p="Fst",snp="SNP",
                ylim=c(0,1),logp=FALSE,ylab="xxx",
                            highlight=snp_names)


##########NISS_PONT
fst4 <- read.table("Desktop/Sequencing_depth_lcWGS/Lib1_manhattan_fst_NISS_HAUG_RAMS_PONT/01_data/slidingwindow15kbNISS__PONT", head=T)
fst4$SNP <- c(1:length(fst4$chr))
fst4$chr <- as.factor(fst4$chr) # create a number instead of a str for each chromosome
fst4$chr <- as.factor(as.numeric(fst4$chr))
fst4$chr <- as.numeric(fst4$chr)
fst4$chr
NISS_PONT <- as.data.frame(fst4)

tiff("Desktop/Sequencing_depth_lcWGS/Lib1_manhattan_fst_NISS_HAUG_RAMS_PONT/03_results/NISS_PONTManhattanfst15kb_5indperPopsnptdata2.tiff", units="in", width=8, height=7, res=300)
NISS_PONT <-manhattan(NISS_PONT,chr="chr",bp="midPos",p="Fst",snp="SNP",
                      ylim=c(0,1),logp=FALSE,xlab = "Chromosomes",
                      ylab="Fst estimated from genotype likelihood for each SNP",
                      col = c("gray70", "skyblue3"), main="Nissum (DK) vs. Pontedeume (SPA) \
                      Fst=0.084")
abline(h = mean(fst4$Fst), col="red")
mean(fst4$Fst)
dev.off()




##########HAUG_RAMS
fst5 <- read.table("Desktop/Sequencing_depth_lcWGS/Lib1_manhattan_fst_NISS_HAUG_RAMS_PONT/01_data/slidingwindow15kbHAUG__RAMS", head=T)
fst5$SNP <- c(1:length(fst5$chr))
fst5$chr <- as.factor(fst5$chr) # create a number instead of a str for each chromosome
fst5$chr <- as.factor(as.numeric(fst5$chr))
fst5$chr <- as.numeric(fst5$chr)
fst5$chr
HAUG__RAMS <- as.data.frame(fst5)
mean(fst5$Fst)
tiff("Desktop/Sequencing_depth_lcWGS/Lib1_manhattan_fst_NISS_HAUG_RAMS_PONT/03_results/HAUG__RAMSManhattanfst15kb_5indperPopsnptdata2.tiff", units="in", width=8, height=7, res=300)
HAUG__RAMS <-manhattan(HAUG__RAMS,chr="chr",bp="midPos",p="Fst",snp="SNP",
                       ylim=c(0,1),logp=FALSE,xlab = "Chromosomes",
                       ylab="Fst estimated from genotype likelihood for each SNP",
                       col = c("gray70", "skyblue3"), main="Haugevågen (NO) vs. Ramsholmen (SW) \
                       Fst=0.069")
abline(h = mean(fst5$Fst), col="red")
dev.off()


##########NISS_RAMS
fst6 <- read.table("Desktop/Sequencing_depth_lcWGS/Lib1_manhattan_fst_NISS_HAUG_RAMS_PONT/01_data/slidingwindow15kbNISS__RAMS", head=T)
fst6$SNP <- c(1:length(fst6$chr))
fst6$chr <- as.factor(fst6$chr) # create a number instead of a str for each chromosome
fst6$chr <- as.factor(as.numeric(fst6$chr))
fst6$chr <- as.numeric(fst6$chr)
fst6$chr
NISS_RAMS <- as.data.frame(fst6)
mean(fst6$Fst)
tiff("Desktop/Sequencing_depth_lcWGS/Lib1_manhattan_fst_NISS_HAUG_RAMS_PONT/03_results/NISS_RAMSManhattanfst15kb_5indperPopsnptdata2.tiff", units="in", width=8, height=7, res=300)
NISS_RAMS <-manhattan(NISS_RAMS,chr="chr",bp="midPos",p="Fst",snp="SNP",ylim=c(0,1),
                      logp=FALSE,xlab = "Chromosomes",
                      ylab="Fst estimated from genotype likelihood for each SNP",
                      col = c("gray70", "skyblue3"), main="Nissum (DK) vs. Ramsholmen (SW) \
                      Fst=0.058")
abline(h = mean(fst6$Fst), col="red")
dev.off()


##########NISS_AGA
fst7 <- read.table("Desktop/Sequencing_depth_lcWGS/Lib1_manhattan_fst_NISS_HAUG_RAMS_PONT/01_data/slidingwindow15kbNISS__AGA", head=T)
fst7$SNP <- c(1:length(fst7$chr))
fst7$chr <- as.factor(fst7$chr) # create a number instead of a str for each chromosome
fst7$chr <- as.factor(as.numeric(fst7$chr))
fst7$chr <- as.numeric(fst7$chr)
fst7$chr
NISS_AGA <- as.data.frame(fst7)
mean(fst7$Fst)
tiff("Desktop/Sequencing_depth_lcWGS/Lib1_manhattan_fst_NISS_HAUG_RAMS_PONT/03_results/NISS_AGAManhattanfst15kb_5indperPopsnptdata2.tiff", units="in", width=8, height=7, res=300)
NISS_AGA <-manhattan(NISS_AGA,chr="chr",bp="midPos",p="Fst",snp="SNP",ylim=c(0,1),
                      logp=FALSE,xlab = "Chromosomes",
                      ylab="Fst estimated from genotype likelihood for each SNP",
                      col = c("gray70", "skyblue3"), main="Nissum (DK) vs. Aga Bømlo (NO) \
                      Fst=0.08")
abline(h = mean(fst7$Fst), col="red")
dev.off()
NISS_AGA

##########NISS_INNE
fst8 <- read.table("Desktop/Sequencing_depth_lcWGS/Lib1_manhattan_fst_NISS_HAUG_RAMS_PONT/01_data/slidingwindow15kbNISS__INNE", head=T)
fst8$SNP <- c(1:length(fst8$chr))
fst8$chr <- as.factor(fst8$chr) # create a number instead of a str for each chromosome
fst8$chr <- as.factor(as.numeric(fst8$chr))
fst8$chr <- as.numeric(fst8$chr)
fst8$chr
NISS_INNE <- as.data.frame(fst8)
mean(fst8$Fst)
tiff("Desktop/Sequencing_depth_lcWGS/Lib1_manhattan_fst_NISS_HAUG_RAMS_PONT/03_results/NISS_INNEManhattanfst15kb_5indperPopsnptdata2.tiff", units="in", width=8, height=7, res=300)
NISS_INNE <-manhattan(NISS_INNE,chr="chr",bp="midPos",p="Fst",snp="SNP",ylim=c(0,1),
                     logp=FALSE,xlab = "Chromosomes",
                     ylab="Fst estimated from genotype likelihood for each SNP",
                     col = c("gray70", "skyblue3"), main="Nissum (DK) vs. Innerøyen (NO) \
                      Fst=0.082")
abline(h = mean(fst8$Fst), col="red")
dev.off()
NISS_AGA





####NISS vs AGA 30kb_win
fst9 <- read.table("Desktop/Sequencing_depth_lcWGS/Lib1_manhattan_fst_NISS_HAUG_RAMS_PONT/01_data/slidingwindow30kbNISS__AGA", head=T)
fst9$SNP <- c(1:length(fst9$chr))
fst9$chr <- as.factor(fst9$chr) # create a number instead of a str for each chromosome
fst9$chr <- as.factor(as.numeric(fst9$chr))
fst9$chr <- as.numeric(fst9$chr)
fst9$chr
NISS_AGA_30 <- as.data.frame(fst9)
mean(fst9$Fst)
tiff("Desktop/Sequencing_depth_lcWGS/Lib1_manhattan_fst_NISS_HAUG_RAMS_PONT/03_results/NISS_AGAManhattanfst30kbwin.tiff", units="in", width=8, height=7, res=300)
NISS_AGA_30 <-manhattan(NISS_AGA_30,chr="chr",bp="midPos",p="Fst",snp="SNP",ylim=c(0,1),
                      logp=FALSE,xlab = "Chromosomes",
                      ylab="Fst estimated from genotype likelihood for each SNP",
                      col = c("blue4", "skyblue3"), main="Nissum (DK) vs. Aga Bømlo (NO) 30kb sliding window\
                      Fst=0.081")
abline(h = mean(fst9$Fst), col="red")
dev.off()
NISS_AGA_30


####NISS vs INNE 30kb_win
fst10 <- read.table("Desktop/Sequencing_depth_lcWGS/Lib1_manhattan_fst_NISS_HAUG_RAMS_PONT/01_data/slidingwindow30kbNISS__INNE", head=T)
fst10$SNP <- c(1:length(fst10$chr))
fst10$chr <- as.factor(fst10$chr) # create a number instead of a str for each chromosome
fst10$chr <- as.factor(as.numeric(fst10$chr))
fst10$chr <- as.numeric(fst10$chr)
fst10$chr
NISS_INNE_30 <- as.data.frame(fst10)
mean(fst10$Fst)
tiff("Desktop/Sequencing_depth_lcWGS/Lib1_manhattan_fst_NISS_HAUG_RAMS_PONT/03_results/NISS_INNEManhattanfst30kbwin.tiff", units="in", width=8, height=7, res=300)
NISS_INNE_30_plot <-manhattan(NISS_INNE_30,chr="chr",bp="midPos",p="Fst",snp="SNP",ylim=c(0,1),
                        logp=FALSE,xlab = "Chromosomes",
                        ylab="Fst estimated from genotype likelihood for each SNP",
                        col = c("blue4", "skyblue3"), main="Nissum (DK) vs. Innerøyen (NO) 30kb sliding window\
                      Fst=0.082")
abline(h = mean(fst10$Fst), col="red")
dev.off()
NISS_INNE_30_plot


library(cowplot)
right_col <- plot_grid(NISS_AGA,NISS_AGA_30)
left_col <- plot_grid(NISS_INNE,NISS_INNE_30_plot,nrow = 2,rel_heights = c(1,1))
plot_grid(left_col,right_col,ncol = 2)


##Display 4 plots
fst7 <- read.table("Desktop/Sequencing_depth_lcWGS/Lib1_manhattan_fst_NISS_HAUG_RAMS_PONT/01_data/slidingwindow15kbNISS__AGA", head=T)
fst7$SNP <- c(1:length(fst7$chr))
fst7$chr <- as.factor(fst7$chr) # create a number instead of a str for each chromosome
fst7$chr <- as.factor(as.numeric(fst7$chr))
fst7$chr <- as.numeric(fst7$chr)
fst7$chr
NISS_AGA <- as.data.frame(fst7)
fst8 <- read.table("Desktop/Sequencing_depth_lcWGS/Lib1_manhattan_fst_NISS_HAUG_RAMS_PONT/01_data/slidingwindow15kbNISS__INNE", head=T)
fst8$SNP <- c(1:length(fst8$chr))
fst8$chr <- as.factor(fst8$chr) # create a number instead of a str for each chromosome
fst8$chr <- as.factor(as.numeric(fst8$chr))
fst8$chr <- as.numeric(fst8$chr)
fst8$chr
NISS_INNE <- as.data.frame(fst8)
fst9 <- read.table("Desktop/Sequencing_depth_lcWGS/Lib1_manhattan_fst_NISS_HAUG_RAMS_PONT/01_data/slidingwindow30kbNISS__AGA", head=T)
fst9$SNP <- c(1:length(fst9$chr))
fst9$chr <- as.factor(fst9$chr) # create a number instead of a str for each chromosome
fst9$chr <- as.factor(as.numeric(fst9$chr))
fst9$chr <- as.numeric(fst9$chr)
fst9$chr
NISS_AGA_30 <- as.data.frame(fst9)
fst10 <- read.table("Desktop/Sequencing_depth_lcWGS/Lib1_manhattan_fst_NISS_HAUG_RAMS_PONT/01_data/slidingwindow30kbNISS__INNE", head=T)
fst10$SNP <- c(1:length(fst10$chr))
fst10$chr <- as.factor(fst10$chr) # create a number instead of a str for each chromosome
fst10$chr <- as.factor(as.numeric(fst10$chr))
fst10$chr <- as.numeric(fst10$chr)
fst10$chr
NISS_INNE_30 <- as.data.frame(fst10)




A <- function() { manhattan(NISS_AGA,chr="chr",bp="midPos",p="Fst",snp="SNP",ylim=c(0,1),
                            logp=FALSE,xlab = "  ",
                            ylab="Fst", 
                            col = c("gray70", "skyblue3"), main="Nissum (DK) vs. Aga Bømlo (NO) 15kb \
                      Fst=0.081") }

B <- function() { manhattan(NISS_AGA_30,chr="chr",bp="midPos",p="Fst",snp="SNP",ylim=c(0,1),
                            logp=FALSE,xlab = "  ",ylab="  ",
                            col = c("blue4", "skyblue3"), main="30kb_win") }

C <- function() { manhattan(NISS_INNE,chr="chr",bp="midPos",p="Fst",snp="SNP",ylim=c(0,1),
                            logp=FALSE,xlab = "Chromosomes",
                            ylab="Fst",
                            col = c("gray70", "skyblue3"), main="Nissum (DK) vs. Innerøyen (NO) \
                      Fst=0.082") }

D <- function() { manhattan(NISS_INNE_30,chr="chr",bp="midPos",p="Fst",snp="SNP",ylim=c(0,1),
                            logp=FALSE,xlab = "Chromosomes",ylab="  ",
                            col = c("blue4", "skyblue3"), main="30kb_win") }

Total <- plot_grid(A, B, C, D, labels = c("a", " ","b", " "), ncol = 2, nrow = 2)
tiff("Desktop/Sequencing_depth_lcWGS/Lib1_manhattan_fst_NISS_HAUG_RAMS_PONT/03_results/15_30kbManhattanComp.tiff", units="in", width=8, height=7, res=300)
Total
dev.off()


