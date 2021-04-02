dir.create('../../datasets', recursive= TRUE)

files = list(
  c(url = 'https://www.dropbox.com/s/7ywlwmynitdb2rr/BLM2020_Dataset.csv?dl=1', target =
      'BLM2020_dataset.csv'),
  c(url = 'https://www.dropbox.com/s/glpv88v6hb0u4j1/BLM2021_Dataset.csv?dl=1', target =
      'BLM2021_dataset.csv'))
  
library(data.table)

data_blm <- lapply(files, function(i) {
  print(i)
  #i['url']
  #i['target']
  
  blm_data <- read.csv(i['url'], sep = '\t', na.string = c(" ", "NA"))
  return(blm_data)
  #write.csv(blm_data, paste0('../../datasets/', i['target']), quote = TRUE, fileEncoding = "UTF-8")
  #return(nrow(blm_data))
})

save(data_blm, file = '../../datasets/datasets.RData')


# asserts
#stopifnot(all(unlist(rows)==c(30,5404)))



