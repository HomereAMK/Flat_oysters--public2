### The BEGINNING ~~~~~
##
# ~ Creates Map | By George PACHECO with later modification by Homère Alves Monteiro
rm(list=ls(all.names = TRUE))




# Loads required packages ~
pacman::p_load(rnaturalearth, rnaturalearthdata, rgeos, sf, ggspatial, tidyverse, ggrepel, extrafont, cowplot)
#install.packages("sf", configure.args = "--with-proj-lib=/usr/local/lib/")

# Imports extra fonts ~
loadfonts(device = "win", quiet = TRUE)


# Imports .shp files ~
Global <- ne_countries(scale = 'medium', returnclass = 'sf')


# Loads coordinates ~
Coords_Global <- read.csv("~/Desktop/Scripts/Shucking/01_infofiles/Master_list_pop.csv", header = TRUE, encoding = "UTF-8")
Coords_Global$lon <- as.numeric(Coords_Global$lon)
Coords_Global$lat <- as.numeric(Coords_Global$lat)



# Transforms coordinates ~
Coords_Global_sf <- st_as_sf(Coords_Global, coords = c("lon", "lat"), crs = 4326)


# Reorganises the data ~
#Coords_Global_sf$Class_Article <- factor(Coords_Global_sf$Class_Article, levels=c(
                               "Remote Localities Within Natural Range",
                               "Urban Localities Within Natural Range",
                               "Localities Outside Natural Range",
                               "Captive Populations"))
Coords_Global <- Coords_Global %>% filter(Tag != "HVAD")
Coords_Global <- Coords_Global %>% filter(Tag != "GASO")
Coords_Global <- Coords_Global %>% filter(Tag != "KLEV")
Coords_Global <- Coords_Global %>% filter(Tag != "BOVA")
Coords_Global <- Coords_Global %>% filter(Tag != "VADE")
Coords_Global <- Coords_Global %>% filter(Tag != "HAVS")
Coords_Global <- Coords_Global %>% filter(Tag != "Havs")
Coords_Global <- Coords_Global %>% filter(Tag != "SVAL")
Coords_Global <- Coords_Global %>% filter(Tag != "LILL")
Coords_Global <- Coords_Global %>% filter(Tag != "SYDK")
Coords_Global <- Coords_Global %>% filter(Tag != "USAM")

Coords_Global$Tag <- factor(Coords_Global$Tag, ordered = T,
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


Coords_Global_sf <- Coords_Global_sf %>% filter(Tag != "HVAD")
Coords_Global_sf <- Coords_Global_sf %>% filter(Tag != "GASO")
Coords_Global_sf <- Coords_Global_sf %>% filter(Tag != "KLEV")
Coords_Global_sf <- Coords_Global_sf %>% filter(Tag != "BOVA")
Coords_Global_sf <- Coords_Global_sf %>% filter(Tag != "VADE")
Coords_Global_sf <- Coords_Global_sf %>% filter(Tag != "HAVS")
Coords_Global_sf <- Coords_Global_sf %>% filter(Tag != "Havs")
Coords_Global_sf <- Coords_Global_sf %>% filter(Tag != "SVAL")
Coords_Global_sf <- Coords_Global_sf %>% filter(Tag != "LILL")
Coords_Global_sf <- Coords_Global_sf %>% filter(Tag != "SYDK")
Coords_Global_sf <- Coords_Global_sf %>% filter(Tag != "USAM")

Coords_Global_sf$Tag <- factor(Coords_Global_sf$Tag, ordered = T,
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


# Creates the base maps ~ limits = c(-12, 20, 36, 73),

# Map1 - Global ~
Map1 <-
 ggplot() +
  geom_sf(data = Global, fill = "#fff5f0", color = "black") +
  geom_sf(data = Coords_Global_sf, aes(fill = Tag), size = 3, show.legend = "point", shape = 21, colour = "black") +
  coord_sf(xlim = c(-25, 35), ylim = c(36, 73), expand = FALSE) +
  geom_label_repel(data = Coords_Global, size = 2, seed = 10, min.segment.length = 0, force = 5, segment.curvature = 1,
                   nudge_x = 0, nudge_y = 0, max.overlaps = Inf, fontface = "bold", colour = "black",
                   aes(x = lon, y = lat, label = Tag,
                   fill = Tag, family = "Helvetica"), alpha = 0.9, show.legend = FALSE) +
  scale_fill_manual(values = c("#A02353", "#A02353", "#A02353",
                               "#AD5B35",
                               "#ad7358",
                               "#CC480C",  "#CC480C",
                               "#969696",
                               "#000000",
                               "#D38C89", "#D38C89", "#D38C89",
                               "#C89AD1", "#C89AD1",
                               "#7210A0", "#7210A0",
                               "#91BD96", "#91BD96",
                               "#02630C", "#02630C","#02630C","#02630C", "#02630C", "#02630C",
                               "#45D1F7", "#45D1F7", "#45D1F7", "#45D1F7",  "#45D1F7","#45D1F7",
                               "#588cad", "#588cad", "#588cad", "#588cad", "#588cad",
                               "#240377", "#240377", "#240377", "#240377"), drop = FALSE) +
  scale_colour_manual(values = c("#A02353", "#A02353", "#A02353",
                                 "#AD5B35",
                                 "#ad7358",
                                 "#CC480C",  "#CC480C",
                                 "#969696",
                                 "#000000",
                                 "#D38C89", "#D38C89", "#D38C89",
                                 "#C89AD1", "#C89AD1",
                                 "#7210A0", "#7210A0",
                                 "#91BD96", "#91BD96",
                                 "#02630C", "#02630C","#02630C","#02630C", "#02630C", "#02630C",
                                 "#45D1F7", "#45D1F7", "#45D1F7", "#45D1F7",  "#45D1F7","#45D1F7",
                                 "#588cad", "#588cad", "#588cad", "#588cad", "#588cad",
                                 "#240377", "#240377", "#240377", "#240377"), drop = FALSE) +
  scale_x_continuous(breaks = seq(-120, 120, by = 25)) +
  scale_y_continuous(breaks = seq(-20, 70, by = 25)) +
  annotation_north_arrow(location = "tl", which_north = "false", style = north_arrow_fancy_orienteering,
                         pad_x = unit(0.25, "in"), pad_y = unit(6.5, "in")) +
  annotation_scale(location = 'br', line_width = 2, text_cex = 1.35, style = "ticks") +
  #annotate("rect", xmin = 76.9, xmax = 84, ymin = 3.25, ymax = 12, fill = "#f46d43",  alpha = 0.2, color = "#a50026", linetype = "dotdash") +
  #annotate("rect", xmin = -9, xmax = -4.5, ymin = 59.5, ymax = 64.5, fill = "#f46d43",  alpha = 0.2, color = "#a50026", linetype = "dotdash") +
  theme(panel.background = element_rect(fill = "#f7fbff"),
        panel.border = element_rect(colour = "black", size = 0.5, fill = NA),
        panel.grid.major = element_line(color = "#d9d9d9", linetype = "dashed", size = 0.00005),
        plot.margin = margin(t = 0.005, b = 0.005, r = 0.2, l = 0.2, unit = "cm"),
        legend.background = element_rect(fill = "#c6dbef", size = 0.15, color = "#5e5e5e", linetype = "dotted"),
        legend.key = element_rect(fill = "#c6dbef"))+
        #legend.position = c(0.10000, 0.18250)) +
  theme(axis.text.x = element_text(color = "black", size = 13, family = "Helvetica"),
        axis.text.y = element_text(color = "black", size = 13, family = "Helvetica"),
        axis.title = element_blank()) +
  theme(axis.ticks = element_line(color ="black", size = 0.5)) +
  guides(fill = guide_legend(title = "Populations", title.theme = element_text(size = 10.5, face = "bold", family = "Helvetica"),
                             label.theme = element_text(size = 8, face = "italic", family = "Helvetica"),
                             override.aes = list(size = 3, alpha = 0.9)), colour = "none")


ggsave(Map1, file = "~/Desktop/Scripts/Flat_oysters/04_local_R/03_results/PCA/Global_map.pdf", device = cairo_pdf, width = 26, height = 13, scale = 0.8, limitsize = FALSE, dpi = 1000)


###### Scandinavia ######
Coords_Global_scan <- Coords_Global %>% filter(Country != "Sardinia")
Coords_Global_scan <- Coords_Global_scan %>% filter(Country != "Corsica")
Coords_Global_scan <- Coords_Global_scan %>% filter(Country != "France")
Coords_Global_scan <- Coords_Global_scan %>% filter(Country != "Spain")
Coords_Global_scan <- Coords_Global_scan %>% filter(Country != "Croatia")
Coords_Global_scan <- Coords_Global_scan %>% filter(Country != "Netherlands")
Coords_Global_scan <- Coords_Global_scan %>% filter(Country != "England")
Coords_Global_scan <- Coords_Global_scan %>% filter(Country != "Scotland")
Coords_Global_scan <- Coords_Global_scan %>% filter(Country != "Ireland")
Coords_Global_scan$Tag <- factor(Coords_Global_scan$Tag, ordered = T,
                            levels = c("FURI", "NISS","LOGS","VENO", "HALS", "THIS",
                                       "KALV",  "HFJO", "RAMS", "ORNE", "HYPP",
                                       "LANG", "BUNN", "DOLV", "HAUG", "HAFR",  
                                       "INNE","VAGS", "AGAB", "OSTR"))
Coords_Global_sf_scan <- st_as_sf(Coords_Global_scan, coords = c("lon", "lat"), crs = 4326)
#map scandinavia limits = c(4, 14, 56, 63)
Map2<-ggplot() +
  geom_sf(data = Global, fill = "#fff5f0", color = "black") +
  geom_sf(data = Coords_Global_sf_scan, aes(fill = Tag), size = 3, show.legend = "point", shape = 21, colour = "black") +
  coord_sf(xlim = c(4, 14), ylim = c(56, 63), expand = FALSE) +
  geom_label_repel(data = Coords_Global_scan, size = 3, seed = 10, min.segment.length = 0, force = 5, segment.curvature = 1,
                   nudge_x = 0, nudge_y = 0, max.overlaps = Inf, fontface = "bold", colour = "black",
                   aes(x = lon, y = lat, label = Tag,
                       fill = Tag, family = "Helvetica"), alpha = 0.9, show.legend = FALSE) +
  scale_fill_manual(values = c( "#02630C", "#02630C","#02630C","#02630C", "#02630C", "#02630C",
                               "#45D1F7", "#45D1F7", "#45D1F7", "#45D1F7","#45D1F7",
                               "#588cad", "#588cad", "#588cad", "#588cad", "#588cad",
                               "#240377", "#240377", "#240377", "#240377"), drop = FALSE) +
  scale_colour_manual(values = c("#02630C", "#02630C","#02630C","#02630C", "#02630C", "#02630C",
                                 "#45D1F7", "#45D1F7", "#45D1F7", "#45D1F7","#45D1F7",
                                 "#588cad", "#588cad", "#588cad", "#588cad", "#588cad",
                                 "#240377", "#240377", "#240377", "#240377"), drop = FALSE) +
  scale_x_continuous(breaks = seq(-120, 120, by = 25)) +
  scale_y_continuous(breaks = seq(-20, 70, by = 25)) +
  annotation_north_arrow(location = "tl", which_north = "false", style = north_arrow_fancy_orienteering,
                         pad_x = unit(0.25, "in"), pad_y = unit(6.5, "in")) +
  annotation_scale(location = 'br', line_width = 2, text_cex = 1.35, style = "ticks") +
  #annotate("rect", xmin = 76.9, xmax = 84, ymin = 3.25, ymax = 12, fill = "#f46d43",  alpha = 0.2, color = "#a50026", linetype = "dotdash") +
  #annotate("rect", xmin = -9, xmax = -4.5, ymin = 59.5, ymax = 64.5, fill = "#f46d43",  alpha = 0.2, color = "#a50026", linetype = "dotdash") +
  theme(panel.background = element_rect(fill = "#f7fbff"),
        panel.border = element_rect(colour = "black", size = 0.5, fill = NA),
        panel.grid.major = element_line(color = "#d9d9d9", linetype = "dashed", size = 0.00005),
        plot.margin = margin(t = 0.005, b = 0.005, r = 0.2, l = 0.2, unit = "cm"),
        legend.background = element_rect(fill = "#c6dbef", size = 0.15, color = "#5e5e5e", linetype = "dotted"),
        legend.key = element_rect(fill = "#c6dbef"))+
  #legend.position = c(0.10000, 0.18250)) +
  theme(axis.text.x = element_text(color = "black", size = 13, family = "Helvetica"),
        axis.text.y = element_text(color = "black", size = 13, family = "Helvetica"),
        axis.title = element_blank()) +
  theme(axis.ticks = element_line(color ="black", size = 0.5)) +
  guides(fill = guide_legend(title = "Populations", title.theme = element_text(size = 10.5, face = "bold", family = "Helvetica"),
                             label.theme = element_text(size = 8, face = "italic", family = "Helvetica"),
                             override.aes = list(size = 3, alpha = 0.9)), colour = "none")

ggsave(Map2, file = "~/Desktop/Scripts/Flat_oysters/04_local_R/03_results/PCA/Scandinavia_map.pdf", device = cairo_pdf, width = 26, height = 13, scale = 0.8, limitsize = FALSE, dpi = 1000)
dev.off()





