#BLM2020_filterd <- read.csv('../../gen/data-preparation/temp/tempfile1.csv', sep = '\t', na.strings=c("", "NA"))
#BLM2021_filtered <- read.csv('../../gen/data-preparation/temp/tempfile2.csv', sep = '\t', na.strings=c("", "NA"))


# make one file (first rows are 2020)
#BLM_merged <- rbind(BLM2020_filterd, BLM2021_filtered)

# overwrite to csv
#write.csv(BLM_merged, '../../gen/data-preparation/merging.csv')

BLM_merged<- rbind(blm_data)

write.csv(BLM_merged, '../../gen/data-preparation/merging.csv')
