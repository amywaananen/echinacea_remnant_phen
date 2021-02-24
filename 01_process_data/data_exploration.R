### Data exploration script ### 

### The objective of this research is to find if there is a difference in flowering times between populations of Echinacea in Western Minnesota.###

explore <- read.csv("00_raw_data/headIDtoAKA20190612.csv")
nrow(explore) ###10262###

explore2 <- read.csv("00_raw_data/remPhenologyThru2019_20200909.csv")
nrow(explore2) ###9796###

### Merge the two datasets into one by headID column ###

explore_sum <- merge(explore, explore2, by = "headID")
nrow(explore_sum) ###9683###

es_withextra <- merge(explore, explore2, by = "headID", all = TRUE)
nrow(es_withextra) ###10406###

###subset individuals according to their sites###
unique(explore_sum$site)
sitesaa <- subset(explore_sum, site == "aa", drop = FALSE)
View(sitesaa)
