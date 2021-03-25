# load cleaned data

library(plyr)
library(dplyr)

blm2020<-read.csv('../../gen/data-preparation/temp/BLM2020_dataset.csv', sep = '', na.strings=c("", "NA"), row.names=NULL)
blm2021<-read.csv('../../gen/data-preparation/temp/BLM2021_dataset.csv', sep = '', na.strings=c("", "NA"), row.names=NULL)

# merge data
blm_merged <- rbind(blm2020, blm2021)
blm_merged$quote_count <- as.integer(blm_merged$quote_count)
##  ----------------------cleaning merged data; remove first column, set date as.Date and add column with year --------------------------- ##


# remove first column
blm_merged <- subset(blm_merged, select = -row.names)

# Set date into as.Date since we csv does not recognize as.Date
format(Sys.Date(), "%Y-%m-%d")
blm_merged$tweet_date <- as.Date(blm_merged$tweet_date)
blm_merged$user_created_date <- as.Date(blm_merged$user_created_date)


# add column with year of tweets
blm_merged$year <- format(blm_merged$tweet_date, format = "%Y-%m-%d")

## --------------- end cleaning: write over in csv file -------------------## 

write.csv(blm_merged, '../../gen/data-preparation/merging.csv')
