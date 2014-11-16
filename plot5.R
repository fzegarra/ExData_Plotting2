## Course Project No 2. Exploratory Data Analysis. 
## plot5.R: How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 
## 1. Set the working directory when de data was downloaded 
## and reading the plyr, dplyr and ggplot2 libraries
setwd("D:/DataScience/Exploratory Data Analisis/Project_Course_2")
library(plyr)
library(dplyr)
library(ggplot2)
## 2. Unzip the data
unzip("exdata-data-NEI_data.zip")
## 3. Read the data: a) Source_Classification_Code.rds; b) summarySCC_PM25.rds
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## 4. Filtering and subsetting the data corresponding to motor vehicles sources
## Understanding as motor vehicles sources all on-road types (land vehicles)
data<-subset(NEI, type=="ON-ROAD")
## 4.4 Filtering the data for Baltimore City data analysis 
data<-filter(data, fips=="24510")
## 5. Aggregate and adding the emmisions by year 
data_sum<-ddply(data, c("year"), summarise, Emissions=sum(Emissions, na.rm=TRUE))
## 5. Generating the png file
png(filename = "plot5.png", width = 480, height = 480, units = "px")
## 6. Plotting the file.
g<-ggplot(data_sum, aes(year, Emissions))
g + geom_line(color="blue")+labs(title="Emissions from motor vehicles sources in Baltimore City (1999 - 2008)")+
    labs(y=expression('Total PM'[2.5]*" Emission"))
dev.off()