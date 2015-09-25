rm(list=ls())

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Take the Baltimore Data
baltimoredata <- NEI[NEI$fips == "24510",]
balttotals <- aggregate(Emissions ~ year, baltimoredata, sum)

png("plot2.png")
barplot(height = balttotals$Emissions, names.arg = balttotals$year, xlab = "Year", ylab = "PM2.5 Emissions", main = "Total PM2.5 Emissions in Baltimore")
dev.off()