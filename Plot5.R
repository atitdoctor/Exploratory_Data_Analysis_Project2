library(ggplot2)

# Loading the data frames.
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Subsetting of the NEI data for vehicles
vehicles <- grepl("vehicle", scc$scc.Level.Two, ignore.case=TRUE)
vehiclesscc <- scc[vehicles,]$scc
vehiclesnei <- nei[nei$scc %in% vehiclesscc,]

# Subsetting the vehicles NEI data for Baltimore.
baltimoreVehiclesnei <- vehiclesnei[vehiclesnei$fips=="24510",]

png("plot5.png",width=480,height=480,units="px",bg="transparent")

ggp <- ggplot(baltimoreVehiclesnei,aes(factor(year),Emissions)) +
  geom_bar(stat="identity",fill="steelblue",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

print(ggp)

dev.off()
