#-------------------------------------------------------------------------------
# Preclean data 2020
#-------------------------------------------------------------------------------

# Make current directory the working directory
# setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Load packages
library(data.table)
library(dplyr)
library(tidyr)
library(textclean)

# 
load('../../datasets/datasets.RData')


stopifnot(all(unlist(lapply(data_blm, nrow))==c(30,5404)))


# Loop through all of the data
dir.create('../../gen/data-preparation/temp', recursive= TRUE)

prepared_data <- list()

for (i in seq(along=data_blm)) {
    print(i)
    blmdata = data_blm[[i]]
    
    if (i==1) extracted_filename = 'BLM2020_dataset.csv'
    if (i==2) extracted_filename = 'BLM2021_dataset.csv'
    
    
    # Set the NA's right
    blmdata$retweeted_tweet[is.na(blmdata$retweeted_tweet)] <- 0
    blmdata$quoted_tweet[is.na(blmdata$quoted_tweet)] <- "No"
    blmdata$location <- replace(blmdata$location, blmdata$location == "", NA)
    blmdata$user_description <- replace(blmdata$user_description, blmdata$user_description == "", NA)
    blmdata$quoted_tweet <- replace(blmdata$quoted_tweet, blmdata$quoted_tweet == "", NA)
    
    # Remove duplicates with the distinct function
    blmdata %>% distinct(blmdata$tweet_id)
           
    # The data is a character and needs to be converted into a date variable
    blmdata$tweet_date <- sapply(strsplit(as.character(blmdata$datetime), " "), "[", 1)
    blmdata$tweet_time <- sapply(strsplit(as.character(blmdata$datetime), " "), "[", 2)
    blmdata$tweet_date <- as.Date.character(blmdata$tweet_date, format = c("%Y-%m-%d"))
    blmdata$tweet_time <- gsub(blmdata$tweet_time, pattern="+00:00",replacement="",fixed=T)
   
    # The data is a character and needs to be converted into a date variable
    blmdata$user_created_date <- sapply(strsplit(as.character(blmdata$user_created), " "), "[", 1)
    blmdata$user_created_time <- sapply(strsplit(as.character(blmdata$user_created), " "), "[", 2)
    blmdata$user_created_date <- as.Date.character(blmdata$user_created_date, format = c("%Y-%m-%d"))
    blmdata$user_created_time <- gsub(x=blmdata$user_created_time, pattern="+00:00",replacement="",fixed=T)
        
    # remove extra variables
    blmdata <- subset(blmdata, select = -datetime)
    blmdata <- subset(blmdata, select = -user_created)
    #blmdata <- subset(blmdata, select = -X)
    
    # Make sure that the other variables are measured correctly
    blmdata$retweeted_tweet <- as.integer(blmdata$retweeted_tweet)

    
    
    # remove weird characters (rendered) content tweet and user description 
    replace_characters <- scan('weird_characters.txt',what='character')
    replace_characters <- gsub('\\\\', '\\',replace_characters)
    replace_characters <- gsub('^rn$', '\r\n',replace_characters)
    
    
#' Strip your text variables from uselass characters
#'
#' @param x Input character vector
#'
#' @return
#' @export
#'
#' @examples
    cleaning_fkt <- function(x) {
        ret=x
        for (char in replace_characters) ret=gsub(ret, pattern = char, replacement= "", fixed = T)
        return(ret)
    }
    
    
    blmdata$text <- cleaning_fkt(blmdata$text)
    
    blmdata$rendered_content <- cleaning_fkt(blmdata$rendered_content)
    
    blmdata$user_description <- cleaning_fkt(blmdata$user_description)
    
    #replace data that is retreived the wrong way
    replace_contraction(blmdata$rendered_content)
    replace_emoticon(blmdata$redered_content)
    replace_incomplete(blmdata, ".")
    
    # Transform the tweet_id and user_id into fully written numbers
    blmdata$tweet_id_full <- format(blmdata$tweet_id, scientific = FALSE)
    blmdata$user_id_full <- format(blmdata$tweet_id, scientific = FALSE)
    
    # clean source attribute to useful
    html_tags <- c(
        "<bold>Random</bold> text with symbols: &nbsp; &lt; &gt; &amp; &quot; &apos;",
        "<p>More text</p> &cent; &pound; &yen; &euro; &copy; &reg;"
    )
    
    blmdata$source_tweet<- replace_html(blmdata$source_tweet)
    
    prepared_data[[i]] <- blmdata  
    
    write.table(blmdata, paste0('../../gen/data-preparation/temp/', extracted_filename))
    
}

stopifnot(all(unlist(lapply(prepared_data, nrow))==c(30,5404)))

