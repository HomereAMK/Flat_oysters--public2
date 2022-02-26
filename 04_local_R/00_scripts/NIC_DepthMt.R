#Clean space
rm(list=ls())
#setwd(dir = "Desktop/Sequencing_depth_lcWGS/")
library(tidyverse)

#Load depth csv
#df <- read_csv('depthPilotLib1.csv')
#df<-read_delim("Desktop/Scripts/Shucking/Rscripts/02_data/384_statsDepth.Lib2.csv", delim = ";")
df<-read_csv("~/Desktop/Scripts/Flat_oysters/04_local_R/02_data/MToutput_12dec21.csv")
dfé <- select(df, bamfile, mean_depth, proportion_of_reference_covered) 
list<-read_csv("~/Desktop/Scripts/Shucking/01_infofiles/Master_list_pop.csv")
unique(list$Tag)

#remove path bamfile
dfé$bamfile=sub(".bam","",dfé$bamfile)
dfé
dfé$bamfile=sub(".+/","",dfé$bamfile)
length(dfé$bamfile)
dfé$bamfile
dfé$bamfile=sub(".depth.gz","",dfé$bamfile)
length(dfé$bamfile)
#pop=substr(dfé$bamfile,0,3) #name only 3characters -> works for Lib2
summary(dfé)

#dfé <- cbind(dfé, pop)

##########
#ggplot(data = dfé) + 
#  geom_point(mapping = aes(x = bamfile, y = proportion_of_reference_covered, color = bamfile)) 

#ggplot(data = dfé) + 
#  geom_col(mapping = aes(x = bamfile, y = proportion_of_reference_covered, file = bamfile))


####### Add pop column 
dfyes <- dfé %>% add_column(pop=substr(dfé$bamfile,0,4))







#####FINAL PLOTS#####
###### % ref covered
#remove duplicate rows
dfyes <-dfyes %>%  distinct()
#first plot
p <-  ggplot(data = dfyes) + 
  geom_col(mapping = aes(x = bamfile, y = proportion_of_reference_covered, fill = pop))
summary(dfyes) # to get the yintercept for Mean_depth plot and prop_genom_cov
##########################
Prop<-p+labs(x = " samples", y = "Proportion of flat oyster genome covered")+
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())+
  theme(legend.key = element_blank()) +
  theme(legend.title=element_blank()) +
  theme(axis.title.x = element_text(size = 10, color="#000000", face="bold", margin = margin(t = 20, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(size = 10, color="#000000", face="bold", margin = margin(t = 0, r = 20, b = 0, l = 0))) +
  theme(legend.text=element_text(size=11)) +
  theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank()) +
  theme(axis.line = element_line(colour = "#000000", size = 0.3)) +
  theme(panel.border = element_blank())
Prop
ggsave(filename = "~/Desktop/Scripts/Flat_oysters/04_local_R/03_results/PropGenome_MT_12dec21") #change path
# Add horizontal line at mean y = 0.5761

###### mean depth1
#remove high cov USAM MORL
dfyes <- dfyes %>%
  filter(! str_detect(pop, c("USAM|MORL")))
p2 <-  ggplot(data = dfyes) + 
  geom_col(mapping = aes(x = bamfile, y = mean_depth, fill = pop))
p2
MeanD<-p2+labs(x = " samples", y = "Mean depth")+
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())
MeanD
summary(dfé)
# Add horizontal line at y = 1.2088
MeanD <-MeanD + geom_hline(yintercept=54.652, color="red")+
  theme(legend.title=element_blank()) +
  theme(axis.title.x = element_text(size = 10, color="#000000", face="bold", margin = margin(t = 20, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(size = 10, color="#000000", face="bold", margin = margin(t = 0, r = 20, b = 0, l = 0))) +
  theme(legend.text=element_text(size=11)) +
  theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank()) +
  theme(axis.line = element_line(colour = "#000000", size = 0.3)) +
  theme(panel.border = element_blank())
MeanD
ggsave(filename = "Desktop/Scripts/Flat_oysters/04_local_R/03_results/MeanDepth_MT_12dec21") #change path


