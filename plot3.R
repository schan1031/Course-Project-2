rm(list=ls())

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

# Take the Baltimore Data
baltimoredata <- NEI[NEI$fips == "24510",]
balttotals <- aggregate(Emissions ~ year, baltimoredata, sum)

png("plot3.png")

ggp <- ggplot(baltimoredata,aes(factor(year),Emissions,fill=type)) + geom_bar(stat="identity") + theme_bw() + guides(fill=FALSE)+facet_grid(.~type,scales = "free",space="free") + labs(x="Year", y=expression("Total PM2.5 Emission")) + labs(title=expression("PM2.5 Emissions of Baltimore City by Type"))

print(ggp)
dev.off()