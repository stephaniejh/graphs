# ggsankey test (15 Aug 2024)
# makes a sankey plot with node counts with the titanic dataset

#RESOURCES 
#https://github.com/davidsjoberg/ggsankey
#https://r-charts.com/flow/sankey-diagram-ggplot2/
#https://rpubs.com/techanswers88/sankey-with-own-data-in-ggplot
#https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/Titanic.html
#https://r-graph-gallery.com/color-palette-finder


# LOAD PACKAGES
library(datasets) #for titanic dataset
library(tidyverse) #ggplot, dplyr, tidyr, tibble
library(ggsankey) #make_long() , geom_sankey()
library(rcartocolor) #for node colors


# DATA
df <- as.tibble(Titanic)


# PLOT PREP
# Expand the values to remove the n count column
# Use the uncount() function from tidyr 
# the uncount() function is basically the opposite of the count() function
expand_df <- df %>%
  uncount(n)

# then make into long form with nodes (with the ggsankey make_long() )
df_long <- expand_df %>% 
  make_long(Class, Age, Sex, Survived) #order you want the sankey to be in

# Add a tally for annotating the nodes
df_tally <- df_long %>%
  group_by(node) %>%
  tally() #dplyr tally

# Merge the 2 data frames together
df_merged <- merge(df_long, df_tally, by.x = 'node', by.y = 'node', all.x = TRUE)


# SANKEY PLOT
display_carto_all() # displays the colours from Rcartocolor

ggplot(df_merged, aes(x = x, next_x = next_x, node = node, next_node = next_node,
                    fill = factor(node), 
                    label = paste0(node, " n=", n))) +  #adds the tally on! 
  geom_sankey(flow.alpha = 0.7, node.color = "grey20") + #sankey itself
  geom_sankey_label(size = 4, color = "grey20") + # must specify in aes above as label = node
  labs(title = "Survival of passengers on the Titanic",
       subtitle = "Sankey plot (ggsankey + ggplot2) with counts using the Titanic data (datasets)") +
  scale_fill_carto_d(palette = "Pastel") + 
  theme_sankey(base_size = 16) +
  theme(plot.title = element_text(family = "sans", size = 15,  face="bold.italic", colour = "grey10"),
        plot.subtitle = element_text(family = "sans", size = 12,  face="italic", colour = "grey10"),
        axis.text = element_text(family ="sans", size = 11, face = "plain", color ="grey10"), #axis labels 
        axis.title.x = element_blank(),
        legend.position = "none")

