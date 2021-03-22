# load cleaned data

library(plyr)
library(dplyr)

blm2020<-read.csv('../../gen/data-preparation/temp/BLM2020_dataset.csv', sep = '', na.strings=c("", "NA"), row.names=NULL)
blm2021<-read.csv('../../gen/data-preparation/temp/BLM2021_dataset.csv', sep = '', na.strings=c("", "NA"), row.names=NULL)

# merge data
blm_merged<- rbind(blm2020, blm2021)

##  ----------------------cleaning merged data; remove first column, set date as.Date and add column with year --------------------------- ##


# remove first column
blm_merged <- subset(blm_merged, select = -X)

# set user_created variable into Y-m-d
blm_merged$user_created <- gsub(x=blm_merged$user_created, pattern="+00:00",replacement="",fixed=T)
blm_merged$user_created <- sapply(strsplit(as.character(blm_merged$user_created), " "), "[", 1)
blm_merged$user_created_time <- sapply(strsplit(as.character(blm_merged$user_created), " "), "[", 2)
blm_merged$user_created <- as.Date(blm_merged$user_created, format = c("%Y-%m-%d"))

# Set date into as.Date
blm_merged$date <- as.Date(blm_merged$date)

# set variables with counting numbers into integers
blm_merged$user_amount_followers <- as.integer(blm_merged$user_amount_followers, na.strings = "NA")
blm_merged$user_amount_friends <- as.integer(blm_merged$user_amount_friends, na.strings = "NA")
blm_merged$user_amount_status <- as.integer(blm_merged$user_amount_status, na.strings = "NA")
blm_merged$user_listed_count <- as.integer(blm_merged$user_listed_count, na.strings = "NA")
blm_merged$user_media_count <- as.integer(blm_merged$user_media_count, na.strings = "NA")
blm_merged$quote_count <- as.integer(blm_merged$quote_count, na.strings = "NA")
blm_merged$retweeted_tweet <- as.integer(blm_merged$retweeted_tweet, na.strings = "NA")

# add column with year of tweets
blm_merged$year <- format(blm_merged$data, format = "%Y")

## --------------- end cleaning: write over in csv file -------------------## 

write.csv(blm_merged, '../../gen/data-preparation/merging.csv')
