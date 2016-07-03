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
#-------------------------------------------------------------------------------------

# Script Name: plot4.R
# Across the United States, how have emissions from coal combustion-related sources changed from 1999 to 2008?

# This plot requires the following Libraries:
library(plyr)
library(ggplot2)

# Step1: read data into R
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Step2:  Coal combustion data subset 
coalcomb.scc <- subset(SCC, EI.Sector %in% c("Fuel Comb - Comm/Instutional - Coal", 
                                             "Fuel Comb - Electric Generation - Coal", "Fuel Comb - Industrial Boilers, ICEs - 
                                             Coal"))

# Step3: Compare rows 0 and 91 the data subsets. 
coalcomb.scc1 <- subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", Short.Name))

nrow(coalcomb.scc) 
#evaluate: rows 0
nrow(coalcomb.scc1)
#evaluate: rows 91

#Step4: Determine the differences 
dif1 <- setdiff(coalcomb.scc$SCC, coalcomb.scc1$SCC)
dif2 <- setdiff(coalcomb.scc1$SCC, coalcomb.scc$SCC)

length(dif1)
length(dif2)


# step5: Create the union of these sets
coalcomb.codes <- union(coalcomb.scc$SCC, coalcomb.scc1$SCC)

length(coalcomb.codes) 

# Step6: Additional subset  provide required information
coal.comb <- subset(NEI, SCC %in% coalcomb.codes)

#Step7: Obtain the PM25 values
coalcomb.pm25year <- ddply(coal.comb, .(year, type), function(x) sum(x$Emissions))

# step8:  Rename the col
colnames(coalcomb.pm25year)[3] <- "Emissions"

#Step9: Create plot4.png 
png("plot4.png")
qplot(year, Emissions, data=coalcomb.pm25year, color=type, geom="line") + stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", color = "purple", aes(shape="total"), geom="line") + geom_line(aes(size="total", shape = NA)) + ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type and Year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()

#Step10: Create the Markdown plot
qplot(year, Emissions, data=coalcomb.pm25year, color=type, geom="line") + stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", color = "purple", aes(shape="total"), geom="line") + geom_line(aes(size="total", shape = NA)) + ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type and Year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))

# Q4:Across the United States, how have emissions from coal combustion-related sources changed from 1999 to 2008?
# Answer: Yes
# Total (Purple Line) shows:
  #(i)   Slight decline between 1999 and 2002. 
  #(ii)  Marginal increase between 2002 to 2005.
  #(iii) Sharp decrease between 2005 to 2008.

# Point (Blue Line) show:
  # (i)   Slight decline between 1999 and  2002.
  # (ii)  Marginal increase between2002 and 2005. 
  # (iii) Sharp decrease between 2005 and 2008.
# It is worth noting that the trends total (blue line)  and point (purple line) are similar, 
# however the  changes in point(blue line) are steper than the changes in Total(Purple Line)

#Nonpoint (Red Line): show
 # (i)  Slight increase between 1999 and 2002, though it starts at much lower point.
 # (ii) Level steady steady state between 2002 and 2005, no noticeable changes.
 # (iii) Slight decrease between 2005 and 2008.
# It is worth noting that nonpoint line  shows a different trend from the Total and Point lines above between 1999 and 2002

