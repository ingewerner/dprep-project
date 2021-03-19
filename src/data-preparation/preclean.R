#-------------------------------------------------------------------------------
# Preclean data 2020
#-------------------------------------------------------------------------------\n")

# Make current directory the working directory
# setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Load packages
library(data.table)
library(dplyr)
library(tidyr)
# install.packages(pandas)
# library(pandas)

# download data 

blm2020 <- read.csv('../../datasets/Dataset1/BLM2020_Dataset.csv', stringsAsFactors = FALSE, sep = '\t', na.strings=c("", "NA"))

# this what we need to do

my_data = lapply(c('../../datasets/Dataset1/BLM2020_Dataset.csv',
                   '../../datasets/Dataset2/BLM2021_Dataset.csv'),
                  function(fn) {
                  read.csv(fn, stringsAsFactors = FALSE, sep = '\t', na.strings=c("", "NA"))})


  for (i in seq(along=my_data)) {
    print(i)
    blmdata = my_data[[i]]
    print(count(blmdata),
          nrow(blmdata))
  } 
# 
    count(blmdata)
    is.na(blmdata)
    sum(is.na(blmdata$datetime))
    sum(is.na(blmdata$quoted_tweet))
    sum(is.na(blmdata$retweeted_tweet))
    sum(is.na(blmdata$location))
    sum(is.na(blmdata$location))
    which(is.na(blmdata))
  }
                  }
#### this hannes example

my_data = lapply(c('../../datasets/Dataset1/BLM2020_Dataset.csv',
                   '../../datasets/Dataset2/BLM2021_Dataset.csv'),
                 function(fn) {
                   read.csv(fn, stringsAsFactors = FALSE, sep = '\t', na.strings=c("", "NA"))})


for (i in seq(along=my_data)) {
  print(i)
  blmdata = my_data[[i]]
  print(nrow(blmdata))
  # all of your cleaning and prep and here
  
}
  

# Get a first look of the data
# View(blm2020)
count(blm2020)

# See if there are missing values 
is.na(blm2020)
sum(is.na(blm2020$datetime))
sum(is.na(blm2020$tweet_id))
sum(is.na(blm2020$location))
sum(is.na(blm2020$retweeted_tweet))
sum(is.na(blm2020$quoted_tweet))
which(is.na(blm2020))

blm2020$retweeted_tweet[is.na(blm2020$retweeted_tweet)] <- 0
blm2020$quoted_tweet[is.na(blm2020$quoted_tweet)] <- "No"


# Remove duplicates with the distinct function
sum(duplicated(blm2020))
blm2020 %>% distinct(blm2020$tweet_id)

# See the type of data of the variables
glimpse(blm2020)

# Separate the date and the time into 2 variables
blm2020$date <- sapply(strsplit(as.character(blm2020$datetime), " "), "[", 1)
blm2020$time <- sapply(strsplit(as.character(blm2020$datetime), " "), "[", 2)

#see the class of the date
class(blm2020$date)
# The data is a character and needs to be converted into a date variable
blm2020$date <- as.Date(blm2020$date, format = c("%Y-%m-%d"))

# Make the Time variable readable 
blm2020$time<- gsub(x=blm2020$time, pattern="+00:00",replacement="",fixed=T)

# Remove the Datetime variable and create a new dataframe
blm2020 = subset(blm2020, select = -c(datetime))

# In order you want to remove attributes you don't need, use the following function with X and Y being attributes
# blm2020 = subset(blm2020, select = -c(X, Y))

# Filter on the location
# location <- c("NL", "nl", "Netherlands", "netherlands", "The Netherlands", "the netherlands", "Nederland", "nederland", "Holland", "holland", "Amsterdam", "010", "020", "Rotterdam", "Het mooie Brabant")
# blm2020_filtered <- blm2020 %>% filter(Location %in% location)

#If we need to filter on date
# bike_share_rides_past <- bike_share_rides %>%
#   filter(date <= today())

#Language detection, doesn't work for me
#install.packages("cld2")
#library("cld2")
#install.packages("cld3")

#detect_language(blm2020$Text)

dir.create('../../gen/data-preparation/temp', recursive= TRUE)

write.table(blm2020, '../../gen/data-preparation/temp/cleaned2020.csv')

#-------------------------------------------------------------------------------
# Preclean data 2021
#-------------------------------------------------------------------------------\n")

blm2021 <- read.csv('../../datasets/dataset2/BLM2021_Dataset.csv', stringsAsFactors = FALSE, sep = '\t', na.strings=c("", "NA"))

# Get a first look of the data
#View(blm2021)
count(blm2021)

# See if there are missing values 
#is.na(blm2021)
#sum(is.na(blm2021$datetime))
#sum(is.na(blm2021$tweet_id))
#sum(is.na(blm2021$location))
#which(is.na(blm2021))

blm2021$retweeted_tweet[is.na(blm2021$retweeted_tweet)] <- 0
blm2021$quoted_tweet[is.na(blm2021$quoted_tweet)] <- "No"


# Remove duplicates with the distinct function
sum(duplicated(blm2021)) 
blm2021 %>% distinct(blm2021$tweet_id)

# See the type of data of the variables
glimpse(blm2021)

# Separate the date and the time into 2 variables
blm2021$date <- sapply(strsplit(as.character(blm2021$datetime), " "), "[", 1)
blm2021$time <- sapply(strsplit(as.character(blm2021$datetime), " "), "[", 2)

#see the class of the date
class(blm2021$date)
# The data is a character and needs to be converted into a date variable

blm2021$date <- as.Date(blm2021$date, format = "%Y-%m-%d")
# Make the Time variable readable 
blm2021$time<- gsub(x=blm2021$time, pattern="+00:00",replacement="",fixed=T)

# Remove the Datetime variable and create a new dataframe
blm2021 = subset(blm2021, select = -c(datetime))

# In order you want to remove attributes you don't need, use the following function with X and Y being attributes
# blm2020 = subset(blm2020, select = -c(X, Y))

# Filter on the location
# location <- c("NL", "nl", "Netherlands", "netherlands", "The Netherlands", "the netherlands", "Nederland", "nederland", "Holland", "holland", "Amsterdam", "010", "020", "Rotterdam", "Het mooie Brabant")
# blm2020_filtered <- blm2020 %>% filter(Location %in% location)

#If we need to filter on date
# bike_share_rides_past <- bike_share_rides %>%
#   filter(date <= today())

#Language detection, doesn't work for me
#install.packages("cld2")
#library("cld2")
#install.packages("cld3")

write.table(blm2021, '../../gen/data-preparation/temp/cleaned2021.csv')
