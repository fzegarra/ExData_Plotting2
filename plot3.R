## Course Project No 3. Exploratory Data Analysis. 
## plot3.R: Of the four types of sources indicated by the type (point, nonpoint,
## onroad, nonroad) variable, which of these four sources have seen decreases in
## emissions from 1999-2008 for Baltimore City? 
## Which have seen increases in emissions from 1999-2008? 
## Use the ggplot2 plotting system to make a plot answer this question.
## 1. Set the working directory when de data was downloaded 
## and reading the plyr, dplyr, ggplot2 and grid libraries
setwd("D:/DataScience/Exploratory Data Analisis/Project_Course_2")
library(plyr)
library(dplyr)
library(ggplot2)
library(grid)
## 2. Unzip the data
unzip("exdata-data-NEI_data.zip")
## 3. Read the data: a) Source_Classification_Code.rds; b) summarySCC_PM25.rds
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## 4. Filtering the data corresponding to Baltimore ("fips=24510")
data<-filter(NEI, fips=="24510")
## 4. Aggregate and arrange the data by type
data_by_type<-ddply(data, c("year", "type"), summarise, Emissions=sum(Emissions, na.rm=TRUE))
data_by_type<-arrange(data_by_type, type)
## 5. Generating the png file
par("mar"=c(5, 4, 4, 1))
png(filename = "plot3.png", width = 480, height = 480, units = "px")
## 6. Plotting the file.
g<-ggplot(data_by_type, aes(year, Emissions, color=type))
g + geom_line()+facet_grid(.~type)+geom_smooth(method="lm",se=FALSE, col="gray")+
    theme(axis.text.x=element_text(colour="blue", angle=45))+labs(title="Total Emissions in Baltimore City by source (1999 - 2008)")+
    labs(y=expression('Total PM'[2.5]*" Emission"))
dev.off()