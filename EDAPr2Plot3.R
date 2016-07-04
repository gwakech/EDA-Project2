 Script Name: plot3.R
# Q3: Of the four types of sources indicated by the type - point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999 to 2008 for Baltimore City? 
# Which have seen increases in emissions from 1999 to 2008? 
# Use the ggplot2 plotting system to make a plot to answer this question.

setwd("C:/Users/Family/Desktop/Coursera/4-EDA/WK4")
# Download the data
dfile = "expdata_prj2.zip"
if (!file.exists("dfile")) {dir.create("./dfile")}
{ fileUrl1 <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                        destfile = dfile, mode = "wb")
}
unzip("./expdata_prj2.zip", exdir = "./dfile")

## This requires the following libraries:
library(ggplot2)
library(plyr)

## Step1: read the data into R
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#Step2: subset the data
baltimore <- subset (NEI, fips == "24510")
typePM25.year <- ddply(baltimore, .(year, type), function(x) sum(x$Emissions))

# Step3: Rename the col: Emissions
colnames(typePM25.year)[3] <- "Emissions"

# Step4: Create plot3.png
png("plot3.png") 
qplot(year, Emissions, data=typePM25.year, color=type, geom ="line") + ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emmission by source, type and year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (in tons)"))
dev.off()

# Step5: Use qplot to create the markdown plot
qplot(year, Emissions, data=typePM25.year, color=type, geom ="line") + ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emmission by source, type and year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (in tons)")) 

# -------------------------------------------------------------------------------------------------------
# Answers:
# Point (purple line) Shows: 
  # (i)   Slight increase between  1999 and 2002.
  # (ii)  Sharp increase in PM2.5 emissions between 2002 and 2005.
  # (iii) Decrease in PM2.5 emissions between 2005 and 2008.

# Nonpoint (green line) Shows: 
  # (i)   sharp decrease in PM2.5 emissions between  1999 and 2002. 
  # (ii)  Steady flow of PM2.5 emissions between 2002 and 2005 
  # (iii) Slight decrease in PM2.5 emission between 2005 and 2008 

# Onroad (blue line) Shows: 
  # (i)   slight decrease in PM2.5 emission between 1999 and 2002.
  # (ii)  Steady flow in PM2.5 emission between 2002 and 2005 
  # (iii) Continued steady flow of PM2.5 emission between 2005 and 2008. 

# Nonroad (red line) shows:
  # (i)   Slightly decrease in PM2.5 emission between 1999 and 2002.
  # (ii)  Approximately steady flow between 2002 and 2005 
  # (iii) continued steady flow of PM2.5 between 2005 and 2008.

# It is worth noting that the emission values for Nonroad are higher than those of Onroad.
