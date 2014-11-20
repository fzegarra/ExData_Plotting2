## Course Project No 2. Exploratory Data Analysis. 
## plot6.R: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle 
## sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time 
## in motor vehicle emissions? 
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
## Understanding as motor vehicles sources all "ON-ROAD" types (land vehicles)
data<-subset(NEI, type=="ON-ROAD")
## 4.4 Filtering the data for Baltimore City and Los Angeles county  
data<-filter(data, fips=="24510" | fips=="06037")
## 5. Aggregate and adding the emmisions by year and fips
data_sum<-ddply(data, c("fips","year"), summarise, Emissions=sum(Emissions, na.rm=TRUE))
data_sum<-arrange(data_sum, fips)
## 6. Including the cities' name column
x<-data_sum[data_sum$fips=="06037",]
x<-mutate(x, Cities="Los Angeles")
y<-data_sum[data_sum$fips=="24510",]
y<-mutate(y, Cities="Baltimore")
data_sum2<-rbind(x,y)
## 5. Generating the png file
par("mar"=c(5, 4, 4, 1))
png(filename = "plot6.png", width = 480, height = 480)
## 6. Plotting the file.
g<-ggplot(data_sum2, aes(year, Emissions, color=Cities))
g + geom_line()+ggtitle("Comparison of total Emissions \n from motor vehicles sources: \n Baltimore City vs. Los Angeles County  \n (1999 - 2008)")+
    labs(y=expression('Total PM'[2.5]*" Emission"))
dev.off()