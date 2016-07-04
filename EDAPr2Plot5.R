# Script Name: plot5.R
# How have emissions from motor vehicle sources changed from 1999 - 2008 in Baltimore City?
setwd("C:/Users/Family/Desktop/Coursera/4-EDA/WK4")
# Download the data
dfile = "expdata_prj2.zip"
if (!file.exists("dfile")) {dir.create("./dfile")}
{ fileUrl1 <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                        destfile = dfile, mode = "wb")
}
unzip("./expdata_prj2.zip", exdir = "./dfile")

# This plot requires the following Libraries:
library(plyr)
library(ggplot2)

# Step1: read the data into R
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#Step2: Data subset
#check emission levels for each type of motor vehicles when it is are switched on..
mv.sourced <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE))

mv.sourcec <- SCC[SCC$EI.Sector %in% mv.sourced, ]["SCC"]

#Step3: Motor vhicle emission subset for NEI in Baltimore,MD

emMV.ba <- NEI[NEI$SCC %in% mv.sourcec$SCC & NEI$fips == "24510",]

# Step4: find the yearly emission levels produced by motor vehicles  in Baltimore.
balmv.pm25yr <- ddply(emMV.ba, .(year), function(x) sum(x$Emissions))
colnames(balmv.pm25yr)[2] <- "Emissions"

# Step5: create Plot.png
png("plot5.png")
qplot(year, Emissions, data=balmv.pm25yr, geom="line") + ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()

# Step6: Create markdown plot.
qplot(year, Emissions, data=balmv.pm25yr, geom="line") + ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))

# Q5:How have emissions from motor vehicle sources changed from 1999 - 2008 in Baltimore City? 
# Answer:
# The plot shows 
# (i)   Sharp decrease in PM2.5 emission between 1999 and 2002.
# (ii)  Gentle decrease-nearly steady state in PM2.5 emission flow  between 2002 and 2005
# (iii) Slight decrease in PM2.5 emission between 2005 and 2008.  The emission fell below 100.

