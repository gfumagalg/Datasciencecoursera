# Project Assignment 2
# Exploratory Data Analysis
# Script for plot 3
# Written by: Gerardo Fumagal
# November 2020

# Read data from EPA National Emissions Invenotry web site

x <- readRDS("Source_Classification_Code.rds") # Classification
y <- readRDS("summarySCC_PM25.rds") # Data

# Q3 Of the four types of sources indicated by the type (point, nonpoint, 
# onroad, nonroad) variable, which of these four sources have seen decreases in 
# emissions from 1999–2008 for Baltimore City? Which have seen increases in 
# emissions from 1999–2008?

library("ggplot2")

c <- subset(y, fips == "24510")
t2 <- with(c, tapply(Emissions, list(type,year),sum))
# Convert matrix to data frame

library("reshape2")
dFt2 <- melt(t2)
names(dFt2) <- c("type","year","Emissions")

# Plot the data from all types of sources
png(filename = "Plot3.png")
p <- ggplot(dFt2, aes(x = year, y = Emissions, color = type)) + geom_line(lwd = 2) + geom_point(size = 3)
p + ylab("Emissions (tons)") + ggtitle("PM2.5 Emission per type in Baltimore")
dev.off()
