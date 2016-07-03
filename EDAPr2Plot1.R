setwd("C:/Users/Family/Desktop/Coursera/4-EDA/WK4")
getwd()
if(!file.exists("data")) {dir.create("./data")}
 Download the data
dfile1 = "expdata_prj2.zip"
if (!file.exists(dfile1)) {
fileUrl1 = download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                         destfile = dfile1, mode = "wb")
}
unzip("./expdata_prj2.zip", exdir = "./data")

#---------------------------------------------------------------------------------
# Script Name: plot1.R
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system,make a plot showing the total PM2.5 emission from all sources for each of the years 1999,
# 2002, 2005, and 2008.

# Step1: read data into R
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

length(NEI$Emissions)
length(NEI$year)
tot.PM25yr <- tapply(NEI$Emissions, NEI$year, sum)

# Step2: Create plot1.png
  png("plot1.png")
  plot(names(tot.PM25yr), tot.PM25yr, type="l", xlab = "Year", ylab = expression
 ("Total" ~ PM[2.5] ~"Emissions (tons)"), main = expression("Total US" ~ PM[2.5] ~ "Emissions by Year"), col="Purple")
                                                     
dev.off()

#Step3: prepare to plot to the markdown file
plot(names(tot.PM25yr), tot.PM25yr, type="l", xlab = "Year", ylab = expression ("Total" ~ PM[2.5] ~"Emissions (tons)"), main = expression("Total US" ~ PM[2.5] ~ "Emissions by Year"), col="Purple")
#-----------------------------------------------------------------------------------------------------
 #Q1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
 # Answer: Yes
 # Plot Shows:
 # (i)	 Sharp decline between 1999 and 2002.
 # (ii)	 Gentle decline between 2002 and 2005. 
 # (iii) Sharp decline between 2005 and 2008.

