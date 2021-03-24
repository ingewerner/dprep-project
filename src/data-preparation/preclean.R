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

# Download the data 
filenames = c('../../datasets/BLM2020_dataset.csv',
              '../../datasets/BLM2021_dataset.csv')


data_blm = lapply(filenames,
                  function(fn) {
                      read.csv(
                          fn, sep = ',' , na.string = c(" ", "NA"),
                          encoding = 'UTF-8'
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
    blmdata %>% distinct(blmdata$tweet_id)
    
    # The data is a character and needs to be converted into a date variable
    blmdata$tweet_date <- sapply(strsplit(as.character(blmdata$datetime), " "), "[", 1)
    blmdata$tweet_time <- sapply(strsplit(as.character(blmdata$datetime), " "), "[", 2)
    blmdata$tweet_date <- as.Date(blmdata$tweet_date, format = c("%Y-%m-%d"))
    blmdata$tweet_time <- gsub(blmdata$tweet_time, pattern="+00:00",replacement="",fixed=T)
   
    # The data is a character and needs to be converted into a date variable
    blmdata$user_created_date <- sapply(strsplit(as.character(blmdata$user_created), " "), "[", 1)
    blmdata$user_created_time <- sapply(strsplit(as.character(blmdata$user_created), " "), "[", 2)
    blmdata$user_created_date <- as.Date(blmdata$user_created_date, format = c("%Y-%m-%d"))
    blmdata$user_created_time <- gsub(x=blmdata$user_created_time, pattern="+00:00",replacement="",fixed=T)
        
    # remove extra variables
    blmdata <- subset(blmdata, select = -datetime)
    blmdata <- subset(blmdata, select = -user_created)
    blmdata <- subset(blmdata, select = -X)
    
    # Make sure that the other variables are measured correctly
    blmdata$retweeted_tweet <- as.integer(blmdata$retweeted_tweet)

    # remove weird characters (rendered) content tweet and user description 
    blmdata$text <- gsub(blmdata$text, pattern = "\r\n",replacement= "", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "©", replacement= "", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "¦", replacement= "", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "Ã", replacement = "", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "f", replacement = "", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "ð", replacement = "", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "Y", replacement = "", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "~", replacement = "", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "¯", replacement = "", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "ª", replacement = "", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "¸", replacement = "", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "&gt;", replacement = "", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "â", replacement = "", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "¤;", replacement = "", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "ï", replacement = "", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "T", replacement = "", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "", replacement = "", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "«", replacement = "", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "¨", replacement = "", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "'ª", replacement = "&", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "¢", replacement = "&", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "o;", replacement = "&", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "®", replacement = "&", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "â", replacement = "&", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "Y", replacement = "&", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "~", replacement = "&", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "o", replacement = "&", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "½", replacement = "&", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "T", replacement = "&", fixed = T)
    blmdata$text <- gsub(blmdata$text, pattern = "^", replacement = "&", fixed = T)
    
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "\r\n", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "©", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "¦", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "Ã", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "f", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "ð", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "Y", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "~", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "¯", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "ª", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "¸", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "&gt;", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "â", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "¤", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "ï", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "T", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "«", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "¨", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "&amp;", replacement = "&", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "¢", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "'ª", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "o", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "®", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "â", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "Y", replacement = "&", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "~", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "o", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "½", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "T", replacement = "", fixed = T)
    blmdata$rendered_content <- gsub(blmdata$rendered_content, pattern = "^", replacement = "", fixed = T)
    
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "\r\n", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "©", replacement= "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "¦", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "Ã", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "f", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "ð", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "Y", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "~", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "¯", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "ª", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "¸", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "&gt;", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "â", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "¤", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "ï", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "T", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "«", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "¨", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "&amp;", replacement = "&", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "¢", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "'ª", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "o", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "®", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "â", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "Y", replacement = "&", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "~", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "o", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "½", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "T", replacement = "", fixed = T)
    blmdata$user_description <- gsub(blmdata$user_description, pattern = "^", replacement = "", fixed = T)
       
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

rm(blmdata)
