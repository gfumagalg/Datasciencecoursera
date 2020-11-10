# Project Assignment 2
# Exploratory Data Analysis
# Script for plot 2
# Written by: Gerardo Fumagal
# November 2020

# Read data from EPA National Emissions Invenotry web site

x <- readRDS("Source_Classification_Code.rds") # Classification
y <- readRDS("summarySCC_PM25.rds") # Data

# Q2 Have total emissions from PM2.5 decreased in Baltimore City, Maryland 
# from 1999 to 2008? Using the base plotting system, make a plot showing 
# the total PM2.5 emission from all sources for each of the years
# 1999, 2002, 2005, and 2008.

b <- with(y, tapply(Emissions, list(fips,year), sum))
png(filename = "Plot2.png")
plot(colnames(b), b["24510",], xlab = "year", ylab = "Total (tons)", 
     main = "PM2.5 Emissions in Baltimore City, Maryland", xlim = c(1999,2008))
lines(colnames(b), b["24510",], xlab = "year", ylab = "Total (tons)", main = "PM2.5 Emissions
      in USA", col = "blue", lwd = 2)
dev.off()