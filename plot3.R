# Download Data File Archive
fileName <- "household_power_consumption.zip"
if(! file.exists(fileName)) {
  message("Downloading the data set archive...")
  fileURL="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url=fileURL,destfile=fileName)
}

# Extract Data File
if(! file.exists("household_power_consumption.txt")) {
  message("Extracting the data set files from the archive...")
  unzip(zipfile=fileName)
}

## Getting full dataset
data_full <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

## Subsetting the data
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full)

## Converting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)


## Plot 3
png("plot3.png", width=480, height=480)
with(data, {
  plot(Sub_metering_1~Datetime, type="l", ylab="Energy Submetering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})
dev.off()