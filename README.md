# Are #BlackLivesMatter tweets used in the campaign for the Dutch elections?
This is the Data Preparation project of Team 9. 

We have done datacollection by scraping tweets from the Twitter website containing the hashtag or text; BLM or Black Lives Matter. 
We did this for two time periods, the first months of 2020 and the first months of 2021. In the first months of 2021, campaigns of 
political parties were running to prepare for the elections on 17-03-2021. To see the use of Black Lives Matter sentiment around
these elections, the data of the two timeperiods will be compared. 

In this folder, you will find our data preparation. The data is already collected and will now be prepared, cleaned and the first
few analysis will be conducted. 

## Workflow pipeline automation
For this folder, we made a makefile. This entails that the whole proces from data loading untill reviewing analysis can be done by 
simply running the makefile. If you don't know how to do this, we would advise you to do the following tutorial: 
https://tilburgsciencehub.com/tutorials/reproducible-research/practicing-pipeline-automation-make/overview/

## Running the makefile
The makefile can be found in the src folder. Have a look at before you run it! 

When you run the makefile, please make sure to download the following R packages on the version of R git is using. The following
packages should be installed: 
library(rtweet)
library(dplyr)
library(textclean)
library(tidyr)
library(tibble)
library(tidytext)
library(tidyverse)
library(tokenizers)
library(ggplot.multistats)
library(ggplot2)
library(forestmangr)
library(syuzhet)
library(readxl)
library(stringr) 
library(stopwords)
library(lobstr)
