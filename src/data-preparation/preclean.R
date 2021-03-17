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

blm2020 <- read.csv('../../datasets/dataset1/BLM2020_Dutch_elections16.csv', stringsAsFactors = FALSE, sep = ',', na.strings=c("", "NA"))

# Get a first look of the data
View(blm2020)
count(blm2020)

# See if there are missing values 
is.na(blm2020)
sum(is.na(blm2020$Datetime))
sum(is.na(blm2020$Tweet.Id))
sum(is.na(blm2020$Location))
which(is.na(blm2020))

blm2020<- na.omit(blm2020) 

# Remove duplicates with the distinct function
sum(duplicated(blm2020))
blm2020 %>% distinct(blm2020$Tweet.Id)

# See the type of data of the variables
glimpse(blm2020)
as.Date(blm2020$Datetime)

# Separate the date and the time into 2 variables
blm2020$Date <- sapply(strsplit(as.character(blm2020$Datetime), " "), "[", 1)
blm2020$Time <- sapply(strsplit(as.character(blm2020$Datetime), " "), "[", 2)

#see the class of the date
class(blm2020$Date)
# The data is a character and needs to be converted into a date variable
blm2020$Date <- as.Date(blm2020$Date)

# Make the Time variable readable 
blm2020$Time<- gsub(x=blm2020$Time, pattern="+00:00",replacement="",fixed=T)

# Remove the Datetime variable and create a new dataframe
blm2020 = subset(blm2020, select = -c(Datetime))

# Remove attributes you don't need
# blm2020 = subset(blm2020, select = -c(X, Y))

# Filter on the location
# location <- c("NL", "nl", "Netherlands", "netherlands", "The Netherlands", "the netherlands", "Nederland", "nederland", "Holland", "holland", "Amsterdam", "010", "020", "Rotterdam", "Het mooie Brabant")
# blm2020_filtered <- blm2020 %>% filter(Location %in% location)

# View(blm2020_filtered)
# Try group_by

#If we need to filter on date
# bike_share_rides_past <- bike_share_rides %>%
#   filter(date <= today())

#Language detection, doesn't work for me
#install.packages("cld2")
#library("cld2")
#install.packages("cld3")

#detect_language(blm2020$Text)

dir.create('../../gen/data-preparation/temp', recursive= TRUE)


write.table(blm2020_filtered, '../../gen/data-preparation/temp/tempfile1.csv')

#-------------------------------------------------------------------------------
# Preclean data 2021
#-------------------------------------------------------------------------------\n")

blm2021 <- read.csv('../../datasets/dataset2/BLM2021_Dutch_elections15.csv', stringsAsFactors = FALSE, sep = ',', na.strings=c("", "NA"))

# Get a first look of the data
View(blm2021)
count(blm2021)

# See if there are missing values 
is.na(blm2021)
sum(is.na(blm2021$Datetime))
sum(is.na(blm2021$Tweet.Id))
sum(is.na(blm2021$Location))
which(is.na(blm2021))

blm2021<- na.omit(blm2021) 

# Remove duplicates with the distinct function
sum(duplicated(blm2021))
blm2021 %>% distinct(blm2021$Tweet.Id)

# See the type of data of the variables
glimpse(blm2021)
as.Date(blm2021$Datetime)

# Separate the date and the time into 2 variables
blm2021$Date <- sapply(strsplit(as.character(blm2021$Datetime), " "), "[", 1)
blm2021$Time <- sapply(strsplit(as.character(blm2021$Datetime), " "), "[", 2)

#see the class of the date
class(blm2021$Date)
# The data is a character and needs to be converted into a date variable
blm2021$Date <- as.Date(blm2021$Date)
# Make the Time variable readable 
blm2021$Time<- gsub(x=blm2021$Time, pattern="+00:00",replacement="",fixed=T)

# Remove the Datetime variable and create a new dataframe
blm2021 = subset(blm2021, select = -c(Datetime))

# Remove attributes you don't need
# blm2020 = subset(blm2020, select = -c(X, Y))

# Filter on the location
# location <- c("NL", "nl", "Netherlands", "netherlands", "The Netherlands", "the netherlands", "Nederland", "nederland", "Holland", "holland", "Amsterdam", "010", "020", "Rotterdam", "Het mooie Brabant")
# blm2020_filtered <- blm2020 %>% filter(Location %in% location)

# View(blm2020_filtered)
# Try group_by

#If we need to filter on date
# bike_share_rides_past <- bike_share_rides %>%
#   filter(date <= today())

#Language detection, doesn't work for me
#install.packages("cld2")
#library("cld2")
#install.packages("cld3")

#detect_language(blm2020$Text)

dir.create('../../gen/data-preparation/temp', recursive= TRUE)


write.table(blm2020_filtered, '../../gen/data-preparation/temp/tempfile2.csv')
