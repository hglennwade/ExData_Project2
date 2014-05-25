# Exploratory Data Analysis
# Project 2

# Clean upworkspace
rm(list=ls())

library("plyr")

# Load data
NEI <- readRDS("~/Downloads/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/Downloads/exdata-data-NEI_data/Source_Classification_Code.rds")

data<-transform(NEI,year=factor(year))

#Plot Data
plotdata<-ddply(data,.(year),summarize,sum=sum(Emissions))
png("plot1.png")
plot(plotdata$year,plotdata$sum,type="n",xlab="year",ylab="total PM2.5 Emission",boxwex=0.05)
lines(plotdata$year,plotdata$sum)
dev.off()
