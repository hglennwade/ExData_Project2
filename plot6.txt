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
twocity<-data[data$fips=="24510"|data$fips=="06037",]
vehicles<-as.data.frame(SCC[grep("vehicles",SCC$SCC.Level.Two,ignore.case=T),1])
names(vehicles)<-"SCC"
data2<-merge(vehicles,twocity,by="SCC")
data2$city[data2$fips=="24510"]<-"Baltimore"
data2$city[data2$fips=="06037"]<-"LA"

#Plot Data
plotdata<-ddply(data2,.(year,city),summarize,sum=sum(Emissions))
png("plot6.png")
gplot<-ggplot(plotdata,aes(year,sum))
gplot+geom_point(aes(color=city),size=4)+labs(title="PM2.5 Emission from motor vehicle sources",
                                              y="total PM2.5 emission each year")
dev.off()
