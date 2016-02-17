library(ggplot2)

# Load the NEI & SCC data frames.
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Subsetting NEI data for Baltimore.
baltimorenei <- nei[nei$fips=="24510",]

# Aggregate (sum) the Baltimore emissions data by year
aggTotalsBaltimore <- aggregate(Emissions ~ year, baltimorenei,sum)

png("plot3.png",width=480,height=480,units="px",bg="transparent")

ggp <- ggplot(baltimorenei,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity",fill="steelblue",width=0.75) +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

print(ggp)

dev.off()
