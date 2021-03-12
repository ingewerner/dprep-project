library(data.table)
library(dplyr)
blm2020 <- read.csv('../../data/BLM2020_Dutch_elections15.csv', stringsAsFactors = FALSE, sep = ',')

blm2021 <- read.csv('../../data/BLM2021_Dutch_elections15.csv', stringsAsFactors = FALSE, sep = ',')

#View(blm2020)
#View(blm2021)

filtered_df = blm2020[blm2020$Location=='NL'&blm2020$Location=='Netherlands',]
filtered_df1 = blm2021[blm2020$Location=='NL'&blm2020$sub_region_2=='',]


#View(filtered_df)

summary(blm2020)
#summary(blm2020(NA))
sum(is.na(blm2020$Datetime))
sum(is.na(blm2020$Tweet.Id))

dir.create('../../gen/data-preparation/temp', recursive= TRUE)


write.table(filtered_df1, '../../gen/data-preparation/temp/tempfile1.csv')
