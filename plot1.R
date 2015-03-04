# plot1.R
# Plot 1 of Exploratory Data Analysis, Project 1
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

# subset the two days of interest
df <- df[which(df[, "Date"] == "1/2/2007" | df[, "Date"] == "2/2/2007"), ]

# convert Date and Time columns to a new column of Date/Time Class
df$DateTime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")

png(file = "plot1.png", bg = "transparent")
hist(as.numeric(df$Global_active_power),
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col = "red"
     )
dev.off()