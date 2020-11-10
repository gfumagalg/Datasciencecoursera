# Project Assignment 2
# Exploratory Data Analysis
# Script for plot 6
# Written by: Gerardo Fumagal
# November 2020

# Read data from EPA National Emissions Invenotry web site
library("reshape2")
library("ggplot2")
library("stringr")

x <- readRDS("Source_Classification_Code.rds") # Classification
y <- readRDS("summarySCC_PM25.rds") # Data

# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California 
# (fips == "06037"). Which city has seen greater changes over time in motor 
# vehicle emissions?

xindex_vehicles <- with( x, which(
  EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles" | 
    EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles" | 
    EI.Sector  == "Mobile - On-Road Diesel Light Duty Vehicles" | 
    EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles"))

list_SCC <- x$SCC[xindex_vehicles]

yindex_vehicles <- with(y, which(SCC %in% list_SCC))

vehicles_sources <- y[yindex_vehicles,]

vehicles_emission_Bal_LA <- subset(vehicles_sources, fips %in% c("24510","06037"))

d <- with(vehicles_emission_Bal_LA, tapply(Emissions, list(fips,year), sum, na.rm = TRUE))

dFd <- melt(d)
names(dFd) <- c("fips","year","Emissions")

dFd$fips <- str_replace_all(dFd$fips, "24510", "Baltimore")
dFd$fips <- str_replace_all(dFd$fips, "6037", "Los Angeles")

png(filename="Plot6.png")
p <- ggplot(dFd, aes(x = year, y = Emissions, color = fips)) + geom_line(lwd = 2) + geom_point(size = 3)
print(p + ylab("Emissions (tons)") + ggtitle("PM2.5 Emission by vehicles sources in Baltimore and Los Angeles"))
dev.off()



