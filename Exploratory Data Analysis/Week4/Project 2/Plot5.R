# Project Assignment 2
# Exploratory Data Analysis
# Script for plot 5
# Written by: Gerardo Fumagal
# November 2020

# Read data from EPA National Emissions Invenotry web site

x <- readRDS("Source_Classification_Code.rds") # Classification
y <- readRDS("summarySCC_PM25.rds") # Data

# Q5 How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# Get motor vehicle sources label and SCC

xindex_vehicles <- with( x, which(
  EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles" | 
    EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles" | 
    EI.Sector  == "Mobile - On-Road Diesel Light Duty Vehicles" | 
    EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles"))

list_SCC <- x$SCC[xindex_vehicles]

yindex_vehicles <- with(y, which(SCC %in% list_SCC))

vehicles_sources <- y[yindex_vehicles,]

vehicles_sources_Bal <- subset(vehicles_sources, fips == "24510")

vehicles_emissions_Bal <- with(vehicles_sources_Bal, tapply(Emissions, year, sum, na.rm = TRUE))

png(filename = "Plot5.png")
plot(names(vehicles_emissions_Bal), vehicles_emissions_Bal, xlab = "year", ylab = "Total (tons)", main = "PM2.5 Emissions
     by vehicles sources in Baltimore", xlim = c(1999,2008))
lines(names(vehicles_emissions_Bal), vehicles_emissions_Bal, xlab = "year", ylab = "Total (tons)", main = "PM2.5 Emissions
     by vehicles sources in Baltimore", xlim = c(1999,2008), col = "blue")
dev.off()
