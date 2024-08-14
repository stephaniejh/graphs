# R alluvial plot (14 Aug 2024)

# RESOURCES
#https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/HairEyeColor.html
#https://datavizcatalogue.com/blog/sankey-diagrams-parallel-sets-alluvial-diagrams-whats-the-difference/
#https://corybrunson.github.io/ggalluvial/



# PACKAGES
library(datasets) #for HairEyeColor dataset (need R tools? not sure!)
library(tidyverse) #for for dplyr, tibble, tidyr, ggplot
library(ggalluvial) # for alluvial plots (extension for ggplot2)


# DATA
# Using the HairEyeColor dataset from the datasets package
df <- as.tibble(HairEyeColor)

# Use the uncount() function from tidyr - NEVERMIND IGNORE THIS!
#to expand the data backout & remove the n column of the counts
# the uncount() function is basically the opposite of the count() function
# expanded_df <- df %>%
#   select(Hair, Eye, Sex, n) %>%
#   uncount(n)


#Alluvial plot v1
ggplot(df, 
       aes(axis1=Sex, axis2 = Hair, axis3 = Eye, # the 3 x-axes
           y = n)) +
  geom_alluvium(aes(fill = Sex)) + #makes alluvial plot
  scale_x_discrete(limits = c("Sex", "Hair", "Eye"), # labels x axis
                   expand = c(.2, .05)) + # widens graph
  geom_stratum(aes(fill = Sex)) + # the blocks in between
  geom_text(stat = "stratum", aes(label = after_stat(stratum))) + # adds the text
  theme_bw()



# EVERYTHING FROM HERE ONWARDS STILL DOESN'T WORK!!!!
# PLOT PREP
#SET FACTORS 
df$Hair= factor(df$Hair, levels=c("Black", "Blond", "Brown", "Red"))
df$Eye = factor(df$Eye, levels=c("Blue", "Brown", "Green", "Hazel"))
df$Sex = factor(df$Sex, levels=c("Female", "Male"))

#assign colours
colorlist <- list(Sex = c("Female" = "#f88787" , "Male" = "#7cc6eb"),
                  Eye = c("Blue" = "#2e536f", "Brown" = "#634e34", 
                          "Green" = "#1c7847", "Hazel" = "#464e25"),
                  Hair = c("Black" = "#1c1712", "Blond" = "#d7d67c" , 
                           "Brown" = "#583f32", "Red" = "#9a3300"))

# ALLUVIAL PLOT 2 
ggplot(df, 
       aes(axis1=Sex, axis2 = Hair, axis3 = Eye, # the 3 x-axes
           y = n)) +
  geom_stratum(aes(fill = Sex), color = "white", position = position_stack(vjust = 0.5)) +  # Sex
  geom_alluvium(aes(fill = Sex), width = 1/12) + #makes alluvial plot
  geom_stratum(aes(fill = Hair), color = "white") +  # Fill based on hair
  geom_stratum(aes(fill = Eye), color = "white", position = position_stack(vjust = 0.5)) +  # Eye colour
  scale_fill_manual(values = unlist(colorlist)) +  # Use the fill colors for all
  scale_x_discrete(limits = c("Sex", "Hair", "Eye"), # labels x axis
                   expand = c(.2, .05)) + # widens graph
  geom_text(stat = "stratum", aes(label = after_stat(stratum))) + # adds the text
  theme_bw()


ggplot(df, 
       aes(axis1= Sex, axis2 = Hair, axis3 = Eye, # the 3 x-axes
           y = n)) +
  geom_stratum(aes(fill = Sex), color = "white", position = position_stack(vjust = 0.5)) +  # Sex
  geom_alluvium(aes(fill = Sex), width = 1/12) + #makes alluvial plot
  geom_stratum(aes(fill = Hair), color = "white") +  # Fill based on hair
  geom_stratum(aes(fill = Eye), color = "white", position = position_stack(vjust = 0.5)) +  # Eye colour
  scale_fill_manual(values = unlist(colorlist)) +  # Use the fill colors for all
  scale_x_discrete(limits = c("Sex", "Hair", "Eye"), # labels x axis
                   expand = c(.2, .05)) + # widens graph
  geom_text(stat = "stratum", aes(label = after_stat(stratum))) + # adds the text
  theme_bw()


