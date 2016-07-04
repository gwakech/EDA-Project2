# Script Name: plot2.R
# Q2:Have total emissions from PM_2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
# Use the base plotting system to make a plot answering this question.

setwd("C:/Users/Family/Desktop/Coursera/4-EDA/WK4")
# Download the data
dfile = "expdata_prj2.zip"
if (!file.exists("dfile")) {dir.create("./dfile")}
{ fileUrl1 <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                        destfile = dfile, mode = "wb")
}
unzip("./expdata_prj2.zip", exdir = "./dfile")

# Step1: read  the data into R
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Step2: obtain the subsets to plot
baltimore <- subset (NEI, fips == "24510")
total.PM25yr <- tapply(baltimore$Emissions, baltimore$year, sum)

# Step3: Create plot2.png
png("plot2.png")
plot(names(total.PM25yr), total.PM25yr, type = "l", xlab="Year", ylab= expression("Total" ~ PM[2.5] ~ "Emissions (tons)"), main=expression("Total for Baltimore City" ~ PM[2.5] ~ "Emissions by Year"), col = "blue")
dev.off()     

# Step4: plot to markdown file
plot(names(total.PM25yr), total.PM25yr, type = "l", xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions (tons)"), main=expression("Total for Baltimore City" ~ PM[2.5] ~ "Emissions by Year"), col="blue")
#---------------------------------------------------------------------------------------------------------
# Q2: Have total emissions from PM_2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
#Answer: Yes
# Plot Shows:
# (i)	  Sharp decline  between 1999 and 2002.
# (ii)  Sharp increase between 2002 and 2005. 
# (iii) Sharp decline between 2005 and 2008.
