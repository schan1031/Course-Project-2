rm(list=ls())

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

combined <- merge(NEI, SCC, by = "SCC")

selectcoallog  <- grepl("coal", combined$Short.Name, ignore.case=TRUE)
coalonly <- combined[selectcoallog, ]

totals <- aggregate(Emissions ~ year, coalonly, sum)

png("plot4.png")
ggp <- ggplot(totals,aes(factor(year),Emissions)) + geom_bar(stat="identity") + theme_bw() + guides(fill=FALSE) + labs(x="Year", y=expression("Total PM2.5 Emission")) + labs(title=expression("PM2.5 Emissions From Coal"))
print(ggp)
dev.off()