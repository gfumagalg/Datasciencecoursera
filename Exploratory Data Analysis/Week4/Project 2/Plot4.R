# Project Assignment 2
# Exploratory Data Analysis
# Script for plot 4
# Written by: Gerardo Fumagal
# November 2020

# Read data from EPA National Emissions Invenotry web site

x <- readRDS("Source_Classification_Code.rds") # Classification
y <- readRDS("summarySCC_PM25.rds") # Data

# Q4 Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

list_coal <- with( x, which(EI.Sector == "Fuel Comb - Electric Generation - Coal" | EI.Sector
                            == "Fuel Comb - Industrial Boilers, ICEs - Coal" | EI.Sector ==
                              "Fuel Comb - Comm/Institutional - Coal"))

list_SCC <- x$SCC[list_coal]

coal_indexes <- with(y, which(SCC %in% list_SCC))
coal_sources <- y[coal_indexes,]
coal_emissions <- with(coal_sources, tapply(Emissions, year, sum))

png(filename = "Plot4.png")
plot(names(coal_emissions), coal_emissions, xlab = "year", ylab = "Total (tons)", main = "PM2.5 Emissions
     by coal-combustion related sources in USA", xlim = c(1999,2008))
lines(names(coal_emissions), coal_emissions, xlab = "year", ylab = "Total (tons)", main = "PM2.5 Emissions
     by coal-combustion related sources in USA", xlim = c(1999,2008), col = "blue")
dev.off()
