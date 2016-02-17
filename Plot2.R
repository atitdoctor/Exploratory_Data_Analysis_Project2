# Loading the data frames.
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Subsetting the NEI data for Baltimore's.
baltimorenei <- nei[nei$fips=="24510",]

# Aggregate (Sum) the Baltimore emissions data by year
aggTotalsBaltimore <- aggregate(Emissions ~ year, baltimorenei,sum)

png("plot2.png",width=480,height=480,units="px",bg="transparent")

barplot(
  aggTotalsBaltimore$Emissions, names.arg=aggTotalsBaltimore$year, xlab="Year", ylab="PM2.5 Emissions (Tons)", main="Total PM2.5 Emissions From all Baltimore City Sources"
)

dev.off()
