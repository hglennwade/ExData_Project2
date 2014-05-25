# Exploratory Data Analysis
# Project 2

# Clean upworkspace
rm(list=ls())

library("plyr")
library("ggplot2")

# Load data
NEI <- readRDS("~/Downloads/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/Downloads/exdata-data-NEI_data/Source_Classification_Code.rds")

data<-transform(NEI,type=factor(type),year=factor(year))
data2<-data[data$fips=="24510",]
vehicles<-as.data.frame(SCC[grep("vehicles",SCC$SCC.Level.Two,ignore.case=T),1])
names(vehicles)<-"SCC"
data3<-merge(vehicles,data2,by="SCC")

#Plot Data
plotdata<-ddply(data3,.(year),summarize,sum=sum(Emissions))
png("plot5.png")
gplot<-ggplot(plotdata,aes(year,sum))
gplot+geom_point(size=4)+labs(title="PM2.5 Emission from motor vehicle sources in Baltimore City",
                              y="Total PM2.5 emission each year")
dev.off()
