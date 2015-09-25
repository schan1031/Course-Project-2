rm(list=ls())

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

# Take the Baltimore and California Data and Combine
balticalidata <- NEI[NEI$fips == "24510"|NEI$fips == "06037",]

combined <- merge(balticalidata, SCC, by = "SCC")

selectvehiclelog  <- grepl("Highway Veh", combined$Short.Name, ignore.case=TRUE)
vehonly <- combined[selectvehiclelog, ]

totals <- aggregate(Emissions ~ year + fips, vehonly, sum)
totals$CITY[totals$fips == "24510"] <- "Baltimore"
totals$CITY[totals$fips == "06037"] <- "Los Angeles"

png("plot6.png")

ggp <- ggplot(totals,aes(factor(year), Emissions, fill = CITY)) + geom_bar(stat="identity") + theme_bw() + guides(fill=FALSE) + labs(x="Year", y=expression("Total PM2.5 Emission")) + labs(title=expression("PM2.5 Emissions From Vehicles in Baltimore vs. Los Angeles"))
ggp <- ggp + theme(legend.title = element_text(colour="chocolate", size=16, face="bold"))

print(ggp)
dev.off()