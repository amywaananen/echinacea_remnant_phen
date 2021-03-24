###codes not used###

###Check start and end date###
bad <- filter(explore_sum, startDtEarly != startDtLate)
nrow(bad)
bad2 <- filter(explore_sum, endDtEarly != endDtLate)
nrow(bad2)
head(bad2)

###the early and end dates are ranges of approximation of the actual dates, so taking the average of the ranges would be a good idea.###
startdate <- c(as.Date("startDtEarly"), as.Date("startDtLate"))
enddate <- c(as.Date("endDtEarly"), as.Date("endDtLate"))

tidy%>%
  mutate(StAve = )
#Attempt failed#


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
