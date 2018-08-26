##Read the dataset

if(!file.exists("exdata-data-household_power_consumption.zip")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}

##Creating a wroking data frame
data <- read.table(file, header = T, sep = ";", na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

nd <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")
nd <- nd[complete.cases(nd),]
nd$Date <- as.Date(nd$Date, format = "%d/%m/%Y")
dt <- paste(nd$Date, nd$Time)
nd <- nd[,!(names(nd) %in% c("Date", "Time"))]
nd <- cbind(dt, nd)
nd$dt <- as.POSIXct(dt)
names(nd)[1] <- paste("Date&Time")

##Drawing a plot
## Plot 4

##Creating a field
par(mfcol = c(2,2))

##Creating all the plots
##1
plot(nd$`Date&Time`, nd$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
##2
plot(nd$`Date&Time`, nd$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(nd$`Date&Time`, nd$Sub_metering_2, col = "red")
lines(nd$`Date&Time`, nd$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"), bty = "n")
##3
plot(nd$`Date&Time`, nd$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
##4
plot(nd$`Date&Time`, nd$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", lwd = 1)

##Saving to PNG
#dev.copy(png, "plot4.png", width = 480, height = 480)
#dev.off()
#cat("plot4.png is in", getwd())