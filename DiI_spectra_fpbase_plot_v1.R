#DiI_spectra_fpbase_plot_v1 (03 July 2024)
#Code for plotting the spectral information of fluorescent probes & dyes
#using data from FPbase.org (exported csv)
# MAKES AN AREA PLOT  

#Still to edit & annotate

#LOAD PACKAGES
library(tidyverse)

#READ DATA
# data from https://www.fpbase.org/spectra/?s=1895,1894&showY=1&showX=1&showGrid=1&areaFill=1&logScale=0&scaleEC=0&scaleQY=1&shareTooltip=1&palette=wavelength
df <- read_csv("FPbase_DiI_Em_Ex.csv")

# AREA PLOT
#https://r-charts.com/evolution/area-chart-ggplot2/
#https://stackoverflow.com/questions/22945651/remove-space-between-plotted-data-and-the-axes
#https://www.sthda.com/english/wiki/ggplot2-density-plot-quick-start-guide-r-software-and-data-visualization
#https://ggplot2-book.org/annotations#sec-custom-annotations
  
#Colours
#Crayola Yellow-Orange #FFAE42
#Crayola Maximum-Green-Yello #D9E650

# Warning is just to NAs
#Removed 75 rows containing non-finite values (`stat_align()`). 
#Removed 202 rows containing non-finite values (`stat_align()`). 

ggplot(df) +
  geom_area(aes(x = Wavelength, y = DiIEX),
            alpha = 0.6, fill ="#D9E650", color = "#D9E650") +
  geom_vline(xintercept = 551, color = "#D9E650", linetype="dashed", size=1) +
  annotate("text", x = 515, y = 0.75, label = "Excitation\n551 nm",
           fontface = 'italic', size = 5, color = "#D9E650") +
  geom_area(aes(x = Wavelength, y = DiIEM),
            alpha = 0.6, fill = "#FFAE42",  color = "#FFAE42") +
  geom_vline(xintercept = 569, color = "#FFAE42", linetype="dashed", size=1) +
  annotate("text", x = 610, y = 0.63, label = "Emission\n569 nm",
           fontface = 'italic', size = 5, color = "#FFAE42") +
  #scale_x_continuous(breaks=seq(0, 800, 25)) + # seq(lower, upper, divisions)
  scale_x_continuous(limits = c(300,775),
                     breaks = seq(300,775, 25),
                     expand = c(0,0)) +
  scale_y_continuous(limits = c(0,1),
                     breaks = seq(0, 1, by=.25),
                     expand = c(0,0.0)) +
  labs(x = "Wavelength (nm)", y = "Relative Intensity",
       title = "Spectral Data of DiI (Dye)",
       subtitle = "Data obtained from fpbase.org") +
  theme(
    plot.title = element_text(family = "sans", size = 16, face = "bold.italic", color = "grey90"),
    plot.subtitle = element_text(family = "sans", size = 14, face = "italic", color = "grey90"),
    axis.line = element_line(linewidth = 0.5, color = "grey90"),
    axis.ticks = element_line(linewidth =0.5, colour = "grey90"),
    axis.title = element_text(family = "sans", size = 14, face = "plain", color = "grey90"),
    axis.text = element_text(family ="sans", size = 12, face = "plain", color ="grey90"),
    panel.background = element_rect(fill = "black"),
    panel.grid.major = element_line(linetype = "solid", linewidth = 0.2, color = "grey50"),
    panel.grid.minor = element_line(linetype = "solid", linewidth = 0.2, color = "grey50"),
    plot.margin = margin(0.25,0.75,.25,.25, "cm"),
    plot.background = element_rect(fill = "black", color = "black")
  )

