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

blm2020 <-
  read.table(
    'https://www.dropbox.com/s/7ywlwmynitdb2rr/BLM2020_Dataset.csv?dl=0',
    sep = '\t',
    quote = "",
    comment.char = '',
    header = T,
    encoding = 'UTF-8',
    na.strings=c("", "NA")
  )

# this what we need to do
filenames = c('../../datasets/Dataset1/BLM2020_Dataset.csv',
              '../../datasets/Dataset2/BLM2021_Dataset.csv')


my_data = lapply(filenames,
                 function(fn) {
                   read.csv(
                     fn,
                     stringsAsFactors = FALSE,
                     sep = '\t',
                     na.strings = c("", "NA")
                   )
                 })


# Loop through all of the data
dir.create('../../gen/data-preparation/temp', recursive= TRUE)

prepared_data <- list()

for (i in seq(along=my_data)) {
    print(i)
    blmdata = my_data[[i]]
    fn = filenames[i]
    extracted_filename = rev(strsplit(fn, '/')[[1]])[1]
    
    # Get a first look of the data
    # View(blm2020)
    count(blmdata)
    
    blmdata$retweeted_tweet[is.na(blmdata$retweeted_tweet)] <- 0
    blmdata$quoted_tweet[is.na(blmdata$quoted_tweet)] <- "No"
    
    
    # Remove duplicates with the distinct function
    sum(duplicated(blmdata))
    blmdata %>% distinct(blmdata$tweet_id)
    
    # See the type of data of the variables
    glimpse(blmdata)
    
    # Separate the date and the time into 2 variables
    blmdata$date <- sapply(strsplit(as.character(blmdata$datetime), " "), "[", 1)
    blmdata$time <- sapply(strsplit(as.character(blmdata$datetime), " "), "[", 2)
    
    #see the class of the date
    class(blmdata$date)
    # The data is a character and needs to be converted into a date variable
    blmdata$date <- as.Date(blmdata$date, format = c("%Y-%m-%d"))
    
    # Make the Time variable readable 
    blmdata$time<- gsub(x=blmdata$time, pattern="+00:00",replacement="",fixed=T)
    
    # Remove the Datetime variable and create a new dataframe
    blmdata = subset(blmdata, select = -c(datetime))
    
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
    prepared_data[[i]] <- blmdata
    
    write.table(blmdata, paste0('../../gen/data-preparation/temp/', extracted_filename))
    
}

rm(blmdata)


prepared_data[[1]]
prepared_data[[2]]

