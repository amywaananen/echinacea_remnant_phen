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


###Calculate the duration of flower time using late start time and early end time###


###select relevant columns only###
select(explore_sum, headID, site, year.y, startDtEarly,startDtLate, endDtEarly, endDtLate)
tidy <- (select(explore_sum, headID, site, year.y, startDtEarly,startDtLate, endDtEarly, endDtLate))


###Use both early date###

Duration <- tidy %>% 
  mutate(duration = as.Date(endDtEarly) - as.Date(startDtEarly))
View(Duration)

###Summarize the duration by sites###

unique(Duration$site)

Sum <- Duration%>%
  group_by(site)%>%
  summarise(avg_dur = mean(duration))
View(Sum)




###Try clear NA columns###

?na.omit
View(Duration)
nrow(Duration)
NoNA <- Duration%>% 
  drop_na(site, startDtEarly,endDtEarly)%>%
  drop_na()
nrow(NoNA)
unique(NoNA$site)
unique(Duration$site)

Sum2 <- NoNA%>%
  group_by(site)%>%
  summarise(avg_dur = mean(duration))
View(Sum2)


valid <- NoNA%>%
  filter(duration > -1)%>%
  filter(duration < 50)
nrow(valid)

date <- c(as.Date("2021-03-16"), as.Date("2021-02-03"))
mean(date)

###take average of early and late date or take one of the time window###
###install.packages('here')
explore <- read.csv(here('00_raw_data/headIdToAKA20190612.csv'))###
