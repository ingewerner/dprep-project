BLM2020 <- read.csv('BLM2020_Dataset.csv', sep = '\t', na.strings=c("", "NA"))
BLM2021 <- read.csv('BLM2021_Dataset.csv', sep = '\t', na.strings=c("", "NA"))


# make one file (first rows are 2020)
BLM_merged <- rbind(BLM2020, BLM2021)

