rm(list=ls())

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

# Take the Baltimore Data and Combine
baltimoredata <- NEI[NEI$fips == "24510",]
combined <- merge(baltimoredata, SCC, by = "SCC")

selectvehiclelog  <- grepl("Highway Veh", combined$Short.Name, ignore.case=TRUE)
vehonly <- combined[selectvehiclelog, ]

totals <- aggregate(Emissions ~ year, vehonly, sum)

png("plot5.png")
ggp <- ggplot(totals,aes(factor(year),Emissions)) + geom_bar(stat="identity") + theme_bw() + guides(fill=FALSE) + labs(x="Year", y=expression("Total PM2.5 Emission")) + labs(title=expression("PM2.5 Emissions From Vehicles in Baltimore"))
print(ggp)
dev.off()