library(ggplot2)
 
# Loading the data frames.
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Subsetting of the NEI data for vehicles
vehicles <- grepl("vehicle", scc$scc.Level.Two, ignore.case=TRUE)
vehiclesscc <- scc[vehicles,]$scc
vehiclesnei <- nei[nei$scc %in% vehiclesscc,]

# Subset the vehicles NEI data by each city's fip and add city name.
vehiclesBaltimorenei <- vehiclesnei[vehiclesnei$fips=="24510",]
vehiclesBaltimorenei$city <- "Baltimore City"

vehiclesLAnei <- vehiclesnei[vehiclesnei$fips=="06037",]
vehiclesLAnei$city <- "Los Angeles County"

# Combine the two subsets with city name into one data frame
bothnei <- rbind(vehiclesBaltimorenei,vehiclesLAnei)

png("plot6.png",width=480,height=480,units="px",bg="transparent")

ggp <- ggplot(bothnei, aes(x=factor(year), y=Emissions, fill=city)) +
 geom_bar(aes(fill=year),stat="identity") +
 facet_grid(scales="free", space="free", .~city) +
 guides(fill=FALSE) + theme_bw() +
 labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
 labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))
 
print(ggp)

dev.off()
