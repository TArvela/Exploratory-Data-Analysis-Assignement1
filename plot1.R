## Import and unzip Data
library(RCurl)
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(URL,destfile="file.zip", mode="wb")
unzip("file.zip")

##Read data and build table
data <- read.table("household_power_consumption.txt",sep=";",header=TRUE,dec=".",stringsAsFactors=FALSE)

##Convert to types
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$Time <- format(data$Time, format="%H:%M:%S")
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

##Subdata corresponding to criteria (2 days only)
data2 <- data[ which(data$Date == "2007-02-01" | data$Date == "2007-02-02"),]

##Build histogram
png("plot1.png", width=480, height=480)
hist(data2$Global_active_power,col="red",  breaks=15, main ="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()