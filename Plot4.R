library(ggplot2)

# Loading thedata frames.
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Subsetting the coal combustion related to NEI data
combustionRelated <- grepl("comb", scc$scc.Level.One, ignore.case=TRUE)
coalRelated <- grepl("coal", scc$scc.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustionRelated & coalRelated)
combustionscc <- scc[coalCombustion,]$scc
combustionnei <- nei[nei$scc %in% combustionscc,]

png("plot4.png",width=480,height=480,units="px",bg="transparent")

ggp <- ggplot(combustionnei,aes(factor(year),Emissions/10^5)) +
  geom_bar(stat="identity",fill="steelblue",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

print(ggp)

dev.off()
