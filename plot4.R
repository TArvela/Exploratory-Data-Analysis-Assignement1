## Import and unzip Data
library(RCurl)
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(URL,destfile="file.zip", mode="wb")
unzip("file.zip")

##Read data and build table
data <- read.table("household_power_consumption.txt",sep=";",header=TRUE,dec=".",stringsAsFactors=FALSE)


##Convert to types
preciseDate <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$Time <- format(data$Time, format="%H:%M:%S")
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

data <- cbind(data, preciseDate)


##Subdata corresponding to criteria (2 days only)
data2 <- data[ which(data$Date == "2007-02-01" | data$Date == "2007-02-02"),]

##Build histogram
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
plot(data2$preciseDate,data2$Global_active_power,type="l", ylab="Global Active Power", xlab="")
plot(data2$preciseDate,data2$Voltage,type="l", ylab="Voltage", xlab="datetime")
plot(data2$preciseDate,data2$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(data2$preciseDate,data2$Sub_metering_2,type="l", col="red")
lines(data2$preciseDate,data2$Sub_metering_3,type="l",col="blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
plot(data2$preciseDate,data2$Global_reactive_power,type="l", ylab="Global_reactive_power", xlab="datetime")
dev.off()