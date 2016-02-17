
# Loading the data frames.
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Aggregate (sum) total emissions by year
aggTotals <- aggregate(Emissions ~ year,NEI, sum)

png("plot1.png",width=480,height=480,units="px",bg="transparent")

barplot(
  (aggTotals$Emissions)/10^6,
  names.arg=aggTotals$year,
  xlab="Year",
  ylab="PM2.5 Emissions (10^6 Tons)",
  main="Total PM2.5 Emissions From All US Sources"
)

dev.off()
