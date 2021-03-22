#-------------------------------------------------------------------------------
# Preclean data 2020
#-------------------------------------------------------------------------------

# Make current directory the working directory
# setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Load packages
#install.packages('textclean')
library(data.table)
library(dplyr)
library(tidyr)
library(textclean)
# install.packages(pandas)
# library(pandas)

# download data 


filenames = c('../../datasets/BLM2020_dataset.csv',
              '../../datasets/BLM2021_dataset.csv')


data_blm = lapply(filenames,
                  function(fn) {
                      read.csv(
                          fn, sep = ',' , na.string = c(" ", "NA")
                      )
                  })

# Loop through all of the data
dir.create('../../gen/data-preparation/temp', recursive= TRUE)

prepared_data <- list()

for (i in seq(along=data_blm)) {
    print(i)
    blmdata = data_blm[[i]]
    fn = filenames[i]
    extracted_filename = rev(strsplit(fn, '/')[[1]])[1]
    
    # Set the NA's right
    blmdata$retweeted_tweet[is.na(blmdata$retweeted_tweet)] <- 0
    blmdata$quoted_tweet[is.na(blmdata$quoted_tweet)] <- "No"
    blmdata$location <- replace(blmdata$location, blmdata$location == "", NA)
    blmdata$user_description <- replace(blmdata$user_description, blmdata$user_description == "", NA)
    blmdata$quoted_tweet <- replace(blmdata$quoted_tweet, blmdata$quoted_tweet == "", NA)
    
    
    # Remove duplicates with the distinct function
    sum(duplicated(blmdata))
    blmdata %>% distinct(blmdata$tweet_id)
    
    # See the type of data of the variables
    glimpse(blmdata)
    
    # TO DO: and also can you look at the rendered_tweet and removing the weird characters?
    
    # Separate the date and the time into 2 variables
    blmdata$date <- sapply(strsplit(as.character(blmdata$datetime), " "), "[", 1)
    blmdata$time <- sapply(strsplit(as.character(blmdata$datetime), " "), "[", 2)
    #see the class of the date
    class(blmdata$date)
    # The data is a character and needs to be converted into a date variable
    blmdata$date <- as.Date(blmdata$date, format = c("%Y-%m-%d"))
    blmdata$time <- gsub(x=blmdata$time, pattern="+00:00",replacement="",fixed=T)
    # Extract the year and make a variable
    blmdata$year_tweeted <- substring(blmdata$date,1,4)
    
    # Separate the date and the time of user creation into 2 variables
    blmdata$user_created_date <- sapply(strsplit(as.character(blmdata$user_created), " "), "[", 1)
    blmdata$user_created_time <- sapply(strsplit(as.character(blmdata$user_created), " "), "[", 2)
    # The data is a character and needs to be converted into a date variable
    blmdata$user_created_date <- as.Date(blmdata$user_created_date, format = c("%Y-%m-%d"))
    # Make the time of user creation readable 
    blmdata$user_created_time <- gsub(x=blmdata$user_created_time, pattern="+00:00",replacement="",fixed=T)
    # Extract the year and make it into a variable
    blmdata$year_created <- substring(blmdata$user_created_date,1,4)
    
    # Remove the Datetime variable and create a new dataframe
    blmdata = subset(blmdata, select = -c(datetime, user_created))
    
    # Make sure that the other variables are measured correctly
    blmdata$retweeted_tweet <- as.integer(blmdata$retweeted_tweet)

    # remove weird characters (rendered) content tweet and user description 
    blmdata$text <- gsub(x=blmdata$text, pattern= "\r\n",replacement="", fixed = T)
    blmdata$text <- gsub(x=blmdata$text, pattern="Ã¢â¬Â¢",replacement="", fixed = T)
    blmdata$text <- gsub(x=blmdata$text, pattern = "Ã¢Ëâ¦ ", replacement = "", fixed = T)
    blmdata$text <- gsub(x=blmdata$text, pattern = "Ã°Å¸", replacement = "", fixed = T)
    blmdata$text <- gsub(x=blmdata$text, pattern = "Ã°Å¸Â¤", replacement = "", fixed = T)
    blmdata$text <- gsub(x=blmdata$text, pattern = "Ã", replacement = "", fixed = T)
    blmdata$text <- gsub(x=blmdata$text, pattern = "Â©", replacement = "", fixed = T)
    blmdata$text <- gsub(x=blmdata$text, pattern = "HÃÂ©", replacement = "", fixed = T)
    blmdata$text <- gsub(x=blmdata$text, pattern = "Ëâ°", replacement = "", fixed = T)
    blmdata$text <- gsub(x=blmdata$text, pattern = "Â¤âËâÂ¤Â£âÅ", replacement = "", fixed = T)
    blmdata$text <- gsub(x=blmdata$text, pattern = "Ã¢â¬â¢", replacement = "", fixed = T)
    #blmdata$rendered_content <- gsub(x=blmdata$rendered_content, pattern="\r\n",replacement="", fixed = T)
    #blmdata$rendered_content <- gsub(x=blmdata$rendered_content, pattern="Ã¢â‚¬Â¢",replacement="", fixed = T)
    #blmdata$rendered_content <- gsub(x=blmdata$rendered_content, pattern= "Ã¢Ëœâ€¦ ", replacement = "", fixed = T)
    #blmdata$rendered_content <- gsub(x=blmdata$rendered_Content, pattern= "Ã°Å¸", replacement = "", fixed = T)
    #blmdata$rendered_content <- gsub(x=blmdata$rendered_Content, pattern= "Â¤", replacement = "", fixed = T)
    #blmdata$rendered_content <- gsub(x=blmdata$rendered_Content, pattern= "HÃƒÂ©", replacement = "", fixed = T)
    #blmdata$rendered_content <- gsub(x=blmdata$rendered_Content, pattern= "Ãƒ", replacement = "", fixed = T)
    #blmdata$rendered_content <- gsub(x=blmdata$rendered_Content, pattern= "Â©", replacement = "", fixed = T)
    blmdata$user_description <- gsub(x=blmdata$user_description, pattern="\r\n",replacement="", fixed = T)
    blmdata$user_description <- gsub(x=blmdata$user_description, pattern="Ã¢â¬Â¢",replacement="", fixed = T)
    blmdata$user_description<- gsub(x=blmdata$user_description, pattern= "Ã¢Ëâ¦ ", replacement = "", fixed = T)
    blmdata$user_description <- gsub(x=blmdata$user_description, pattern= "Ã°Å¸", replacement = "", fixed = T)
    blmdata$user_description <- gsub(x=blmdata$user_description, pattern= "Ã°Å¸Â¤", replacement = "", fixed = T)
    blmdata$user_description <- gsub(x=blmdata$user_description, pattern= "Ã", replacement = "", fixed = T)
    blmdata$user_description <- gsub(x=blmdata$user_description, pattern= "Â©", replacement = "", fixed = T)
    blmdata$user_description <- gsub(x=blmdata$user_description, pattern= "Ã¢", replacement = "", fixed = T)
    blmdata$user_description <- gsub(x=blmdata$user_description, pattern= "â¢", replacement = "", fixed = T)
    blmdata$user_description <- gsub(x=blmdata$user_description, pattern= "Å", replacement = "", fixed = T)
    
    
    # clean source attribute to useful
    html_tags <- c(
        "<bold>Random</bold> text with symbols: &nbsp; &lt; &gt; &amp; &quot; &apos;",
        "<p>More text</p> &cent; &pound; &yen; &euro; &copy; &reg;"
    )
    
    blmdata$source_tweet<- replace_html(blmdata$source_tweet)
    
    prepared_data[[i]] <- blmdata
    
    write.table(blmdata, paste0('../../gen/data-preparation/temp/', extracted_filename))
    
}


rm(blmdata)

prepared_data[[1]]
prepared_data[[2]]
