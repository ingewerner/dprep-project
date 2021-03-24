# Are #BlackLivesMatter tweets used in the campaign for the Dutch elections?

*Do the elections and their preparing campaigns have an effect on the sentiment around Black Lives Matter in the Netherlands?*

![image description](https://images.unsplash.com/photo-1590878358491-0ad62c966121?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80)

## Motivation

Black Lives Matter is a topic everyone knows about these days. It comes with a lot of sentiment and emotions. Especially regariding politics, the Black Lives Matter movement is one that political parties should have an opinion about. With more known about this topic, the national debate and the actions of political parties in the Netherlands regarding this topic, politicians can make strategies in order to strategically position their party as preparation for the Dutch elections. In order to provide an up-to-date research about this topic in combination with the sentiment of the Dutch population, we provided this data and pipeline structure. 

To research this topic, data of the first months of 2020 and 2021, before and during the Dutch Elections of 2021, regarding the #BlackLivesMatter and #BLM usage is collected. This research is composed in 2021. 

## Methods and results 

This was our research objective and the data collection as well as the data preparation and analysis are done with this objective in mind. Other research questions which need data of 2020 and 2021 to compare the Black Lives Matter sentiment can also be researched using this dataset. Besides that, we would encourage you to use this data and the process for other purposes and other objectives. 

In order to collect the data, we used python to scrape the data. More specifically, we used Jupyter notebook to write the code. We have conducted datacollection by scraping tweets from the Twitter website containing the hashtag or text; BLM, Black Lives Matter, #BLM and #BlackLivesMatter. We did this for two time periods, the first months of 2020 and the first months of 2021. In the first months of 2021, campaigns of  political parties were running to prepare for the elections on 17-03-2021. We did this with the python package sntwitter.TwitterSearchScraper. 

**summarize the results**

In this folder, you will find our data preparation. The data is already collected and will now be prepared, cleaned and the first
few analysis will be conducted. 

## Repository overview
The repository your are currently in is build with different pipelines. We made a makefile in order to automize everything and connect the pipelines. This entails that the whole proces from data loading untill reviewing analysis can be done by simply running the makefile. If you don't know how to do this, we would advise you to do the following tutorial: [https://tilburgsciencehub.com/tutorials/reproducible-research/practicing-pipeline-automation-make/overview/]

*Our repository has the following structure:*

├── README.md
├── src
│   ├── analysis
│   ├── data-preparation
└── datasets
└── gen
    ├── analysis
    ├── data-preparation

## Running instructions
The data is collected in python. The python code can be found in this repository. In order to run this, you need to be able to run the python file with any program you like. 

In order to run the whole project, the makefile can be found in the src folder. Have a look at before you run it in order to understand the structure of the pipeline! With this, the data is downloaded, precleaned, merged and analysis are made after that. Those are the steps of the pipeline. The makefile already knows the order. Run the makefile in your gitbash program by typing the command *make*. 

The data is prepared and analysed in R. When you run the makefile, please make sure to download the following R packages on the version of R gitbash is using. You can easily copy the codes below and paste this in your local R used by gitbash. The following packages should be installed: 
```
install.packages("rtweet")
install.packages("dplyr")
install.packages("textclean")
install.packages("tidyr")
install.packages"(data.table")
```
If the package are installed, you can make sure they are opened to see it with the following code:
```
library("rtweet")
library("dplyr")
library("textclean")
library("tidyr")
library("data.table")
```
## More resources 
In order to understand the whole project and see how it was set up, please visit [https://tilburgsciencehub.com/]. This is a very convenient website to get all you need to know to run this project and get to know the programs used. 

## About
This repository is made by Aithra Spandagou, Inge Werner and Marjolein Keijzer. The dataset of this research was collected for the course Online Data Collection and Management of Tilburg University. This repository, the data preparation and analysis are conduted for the course Data Preparation and Workflow Management. Both courses are part of the Marketing Analytics Master at Tilburg University. Our rock in the surf for these projects was our amazing teacher Hannes Datta. You can visit is repositories at [https://github.com/hannesdatta]. 
