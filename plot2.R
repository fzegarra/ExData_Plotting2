## Course Project No 2. Exploratory Data Analysis. 
## plot2.R: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
## from 1999 to 2008? Using the base plotting system, make a plot showing the total
## PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
## 1. Set the working directory when de data was downloaded 
## and reading the plyr and dplyr libraries
setwd("D:/DataScience/Exploratory Data Analisis/Project_Course_2")
library(plyr)
library(dplyr)
## 2. Unzip the data
unzip("exdata-data-NEI_data.zip")
## 3. Read the data: a) Source_Classification_Code.rds; b) summarySCC_PM25.rds
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## 4. Filtering the data corresponding to Baltimore ("fips=24510")
data<-filter(NEI, fips=="24510", Emissions, year)
## 4. Aggregate the data by years
data_by_years<-ddply(data, c("year"), summarise, Emissions=sum(Emissions, na.rm=TRUE))
## 5. Generating the png file
par("mar"=c(5, 4, 4, 1))
png(filename = "plot2.png", width = 480, height = 480, units = "px")
## 6. Plotting the file.
plot(data_by_years, type = "l", col="red", xlab = "Year", 
     main = "Total Emissions in Baltimore City (from 1999 to 2008)", 
     ylab = expression('Total PM'[2.5]*" Emission"))
dev.off()