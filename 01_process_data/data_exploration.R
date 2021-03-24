### Data exploration script ### 

### The objective of this research is to find if there is a difference in flowering times between populations of Echinacea in Western Minnesota.###

###install packages dplyr and tidyr###
install.packages("dplyr")
library(dplyr)

install.packages("tidyr")
library(tidyr)

### import dataset###
explore <- read.csv("00_raw_data/headIDtoAKA20190612.csv")
nrow(explore) ###10262###

explore2 <- read.csv("00_raw_data/remPhenologyThru2019_20200909.csv")
nrow(explore2) ###9796###

### Merge the two datasets into one by headID column ###

explore_sum <- merge(explore, explore2, by = "headID")
nrow(explore_sum) ###9683###

es_withextra <- merge(explore, explore2, by = "headID", all = TRUE)
nrow(es_withextra) ###10406###


###Check start and end date###
bad <- filter(explore_sum, startDtEarly != startDtLate)
nrow(bad)
bad2 <- filter(explore_sum, endDtEarly != endDtLate)
nrow(bad2)
head(bad2)

###Calculate the duration of flower time using late start time and early end time###

###select relevant columns only###
select(explore_sum, headID, site, year.y, startDtEarly,startDtLate, endDtEarly, endDtLate)
tidy <- (select(explore_sum, headID, site, year.y, startDtEarly,startDtLate, endDtEarly, endDtLate))

###separate the date columns for easier calculation###
separated <- tidy %>%
  separate(startDtLate, into = c("yearz", "month", "day"), sep = "-") %>%
  separate(endDtEarly, into = c("yearz2", "month2", "day2"), sep = "-")

###Check if there is errors in the years column###
separated %>%
  filter(yearz != yearz2)

###change the separated columns to numeric from character###
sapply(separated, mode)
sapply(separated, class)

sep <- separated %>% 
  transform(month = as.numeric(month)) %>% 
  transform(day = as.numeric(day)) %>% 
  transform(month2 = as.numeric(month2))%>% 
  transform(day2 = as.numeric(day2))

###Calculate the duration###           
dur <- sep %>% 
  mutate(duration = (month2-month)*30 + (day2-day))

###Summarize the duration by sites###

unique(Sum$site)
Sum <- dur%>%
  group_by(site)%>%
  summarise(avg_duration = mean(duration))
