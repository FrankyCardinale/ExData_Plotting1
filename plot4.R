# Download and unzip data file, if not exists
filePath <- "./data/household_power_consumption.txt"

if (!file.exists(filePath)) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  dir.create("./data")
  download.file(fileURL, "./data/power_data.zip")
  unzip("./data/power_data.zip", overwrite = T, exdir = "./data")
}


# Read the data into a data table 
# from just the dates 2007-02-01 and 2007-02-02 
rowtoRead <- grep("^[1,2]/2/2007", readLines(filePath))

hpcData<-read.table(filePath,header = FALSE, sep= ";",na.strings = "?",
                    skip = rowtoRead[1]-1, nrows = length(rowtoRead),
                    col.names = colnames(read.table(filePath, nrow = 1, header = TRUE, sep= ";")), comment.char = "")

# Perform some conversions on the date and time values
hpcData$Datetime <- strptime(paste(hpcData$Date, hpcData$Time), "%d/%m/%Y %H:%M:%S")

# Make a plot in PNG file
png('plot4.png',width=480,height=480, bg="transparent")

par(mfrow = c(2, 2))

# plot 1 (NW)
plot(hpcData$Datetime, hpcData$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

# plot 2 (NE)
plot(hpcData$Datetime, hpcData$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

# plot 3 (SW)
plot(hpcData$Datetime, hpcData$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", col = "black")
points(hpcData$Datetime, hpcData$Sub_metering_2, type = "l", xlab = "", ylab = "Sub_metering_2", col = "red")
points(hpcData$Datetime, hpcData$Sub_metering_3, type = "l", xlab = "", ylab = "Sub_metering_3", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

# plot 4 (SE)
plot(hpcData$Datetime, hpcData$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", ylim = c(0, 0.5))

dev.off()