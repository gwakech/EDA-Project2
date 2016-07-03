setwd("C:/Users/Family/Desktop/Coursera/4-EDA/WK4")
getwd()
#if(!file.exists("data")) {dir.create("./data")}
# Download the data
dfile1 = "expdata_prj2.zip"
if (!file.exists(dfile1)) {
  fileUrl1 = download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                           destfile = dfile1, mode = "wb")
}
unzip("./expdata_prj2.zip", exdir = "./data")
#-------------------------------------------------------------------------------------
# Script Name: plot5.R
# How have emissions from motor vehicle sources changed from 1999 - 2008 in Baltimore City?


# This plot requires the following Libraries:

library(plyr)
library(ggplot2)

# Step 1: read the data into R
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#Step 2: Data subset
#check emission levels for each type of motor vehicles when it is are switched on..
mv.sourced <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE))

mv.sourcec <- SCC[SCC$EI.Sector %in% mv.sourced, ]["SCC"]

#Step 3: Motor vhicle emission subset for NEI in Baltimore,MD

emMV.ba <- NEI[NEI$SCC %in% mv.sourcec$SCC & NEI$fips == "24510",]

# Step4: find the yearly emission levels produced by motor vehicles  in Baltimore.
balmv.pm25yr <- ddply(emMV.ba, .(year), function(x) sum(x$Emissions))
colnames(balmv.pm25yr)[2] <- "Emissions"

# Step5: create Plot.png
png("plot5.png")
qplot(year, Emissions, data=balmv.pm25yr, geom="line") + ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()

## Step 6: Plot to markdown
qplot(year, Emissions, data=balmv.pm25yr, geom="line") + ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))

# Answer:
# Starting with 1999, the \(PM_{2.5}\) emissions was just below 350, the levels fell sharply until 2002. From 2002 to 2005 the levels plateaued. Finally from 2005 to 2008, the \(PM_{2.5}\) emissions drop to below 100 \(PM_{2.5}\) emissions.

