## Course Project No 2. Exploratory Data Analysis. 
## plot4.R: Across the United States, how have emissions from coal combustion-related 
## sources changed from 1999-2008? 
## 1. Set the working directory when de data was downloaded 
## and reading the plyr, dplyr, ggplot2 and grid libraries
setwd("D:/DataScience/Exploratory Data Analisis/Project_Course_2")
library(plyr)
library(dplyr)
library(ggplot2)
## 2. Unzip the data
unzip("exdata-data-NEI_data.zip")
## 3. Read the data: a) Source_Classification_Code.rds; b) summarySCC_PM25.rds
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## 4. Filtering and subsetting the data corresponding to coal combustion-related sources
## 4.1 Searching for the rows that contain the"Coal" word from EI.Sector variable. 
## The choose for using EI.Sector instead Short.Name was define from the discussion:
## "Project 2, question 4, how to define coal combustion-related sources" one of the discussion forums of the course. 
## Thanks colleagues, especially Jaganmohan Rao Narayanam for clarify the subject.
coal_data <- grep("Coal", SCC$EI.Sector, ignore.case=T)
## 4.2 Subsetting the rows that were selected from the SCC data
coal_data<-SCC[coal_data, ]
## 4.3 Subsetting the data by matching using the operator %in%  
coal_data <- NEI[NEI$SCC %in% coal_data$SCC, ]
## 5. Aggregate and adding the emmisions by year 
coal_data_sum<-ddply(coal_data, c("year"), summarise, Emissions=sum(Emissions, na.rm=TRUE))
## 5. Generating the png file
par("mar"=c(5, 4, 4, 1))
png(filename = "plot4.png", width = 480, height = 480, units = "px")
## 6. Plotting the file.
g<-ggplot(coal_data_sum, aes(year, Emissions))
g + geom_line(col="red")+labs(title="Emissions from coal combustion-related sources in U.S. (1999 - 2008)")+
    labs(y=expression('Total PM'[2.5]*" Emission"))
dev.off()