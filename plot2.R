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
## Plot 2
plot(nd$`Date&Time`, nd$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

##Saving to PNG
#dev.copy(png, "plot2.png", width = 480, height = 480)
#dev.off()
#cat("plot2.png is in", getwd())
