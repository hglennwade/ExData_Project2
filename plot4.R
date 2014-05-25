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
combustion<-as.data.frame(SCC[grep("combustion",SCC$SCC.Level.One,ignore.case=T) & 
                             grep("coal",SCC$SCC.Level.Three,ignore.case=T),1])
names(combustion)<-"SCC"
data2<-merge(combustion,data,by="SCC")

#Plot Data
plotdata<-ddply(data2,.(year),summarize,sum=sum(Emissions))
png("plot4.png")
gplot<-ggplot(plotdata,aes(year,sum))
gplot+geom_point(size=4)+labs(title="PM2.5 Emission from coal combustion-related sources ",
                              y="Total PM2.5 emission each year")
dev.off()
