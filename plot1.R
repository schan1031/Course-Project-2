rm(list=ls())

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Sum totals

totals <- aggregate(Emissions ~ year, NEI, sum)

png("plot1.png")
barplot(height = totals$Emissions, names.arg = totals$year, xlab = "Year", ylab = "PM2.5 Emissions", main = "Total PM2.5 Emissions")
dev.off()