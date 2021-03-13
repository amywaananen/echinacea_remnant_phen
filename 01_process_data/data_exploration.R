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

install.packages("dplyr")
library(dplyr)

group_by(explore_sum, site)    
g.site <- group_by(explore_sum, site)
View(g.site)

bad <- filter(explore_sum, startDtEarly != startDtLate)
nrow(bad)
bad2 <- filter(explore_sum, endDtEarly != endDtLate)
nrow(bad2)
head(bad2)

###Calculate the duration of flower time using late start time and early end time###
###What does late and early mean?###

install.packages("tidyr")
library(tidyr)
select(explore_sum, headID, site, year.y, startDtEarly,startDtLate, endDtEarly, endDtLate)
tidy <- (select(explore_sum, headID, site, year.y, startDtEarly,startDtLate, endDtEarly, endDtLate))

separated <- tidy %>%
separate(startDtLate, into = c("yearz", "month", "day"), sep = "-") %>%
separate(endDtEarly, into = c("yearz2", "month2", "day2"), sep = "-")
seperated %>%
  filter(yearz != yearz2)

mean(separated$month2)
sapply(separated, mode)
sapply(separated, class)

numex <- transform(separated, month = as.numeric(month))
mode(numex$month)

sep <- seperated %>% 
  transform(month = as.numeric(month)) %>% 
  transform(day = as.numeric(day)) %>% 
  transform(month2 = as.numeric(month2))%>% 
  transform(day2 = as.numeric(day2))
                
dur <- sep %>% 
  mutate(duration = (month2-month)*30 + (day2-day))

Sum <- dur%>%
  group_by(site)%>%
  summarise(avg_duration = mean(duration))