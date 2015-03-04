# plot2.R
# Plot 2 of Exploratory Data Analysis, Project 1
#
# If the file isn't already here, download it, unzpit it, read it
# and plot accordingly
#
setwd("C:\\Users\\paul\\Coursera\\Exp Data Analysis\\Project 1")
filename <- "./data/household_power_consumption.txt"
zipfilename <- "./data/exdata_data_household_power_consumption.zip"

if(!file.exists("data")) dir.create("data")
if(!file.exists(filename)) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, zipfilename, mode = "wb")
    unzip(zipfilename, exdir = "./data")
}
df <- read.table(filename,
                 sep = ";",
                 header = TRUE,
                 colClasses = "character",
                 na.strings = "?"
                 )
#subset the rows of interest
df <- df[which(df[, "Date"] == "1/2/2007" | df[, "Date"] == "2/2/2007"), ]

# add new column of Date/Time class from Date and Time columns
df$DateTime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")

png(file = "plot2.png", bg = NA)         # make background trannsparent
plot(df$DateTime,
     as.numeric(df$Global_active_power),
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     type = "l"
     )
dev.off()