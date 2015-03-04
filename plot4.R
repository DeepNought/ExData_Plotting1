# plot4.R
# Plot 4 of Exploratory Data Analysis, Project 1
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

png(file = "plot4.png", bg = "transparent")
par(mfrow = c(2, 2), mar = c(4, 4, 2, 2), oma = c(0, 0, 0, 0))
with(df, {    
    plot(DateTime,
         as.numeric(Global_active_power),
         xlab = "",
         ylab = "Global Active Power",
         type = "l"
         )
    plot(DateTime,
         as.numeric(Voltage),
         xlab = "datetime",
         ylab = "Voltage",
         type = "l"
         )
    plot(DateTime,
         as.numeric(Sub_metering_1),
         xlab = "",
         ylab = "Energy sub metering",
         type = "l"
         )
    lines(DateTime, as.numeric(Sub_metering_2), col = "red")
    lines(DateTime, as.numeric(Sub_metering_3), col = "blue")
    leg.txt <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
    leg.col <- c("black", "red", "blue")
    legend("topright",
           legend = leg.txt,
           pch = NA,
           col = leg.col,
           lwd = 1,
           cex = 0.95,       # make the legend text smaller
           bty = "n"         # no legend box
           )
    plot(DateTime,
         as.numeric(Global_reactive_power),
         ylab = "Global_reactive_power",
         xlab = "datetime",
         type = "l"
         )
    })
dev.off()