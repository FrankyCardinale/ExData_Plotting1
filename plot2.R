# Download and unzip data file
if (!file.exists("./data/household_power_consumption.txt")) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, "./data/power_data.zip", method = "wget")
  unzip("./data/power_data.zip", overwrite = T, exdir = "./data")
}

# Read the data into a data table 
# from just the dates 2007-02-01 and 2007-02-02 
filePath <- "./data/household_power_consumption.txt"

rowtoRead <- grep("^[1,2]/2/2007", readLines(filePath))

hpcData<-read.table(filePath,header = FALSE, sep= ";",na.strings = "?",
                    skip = rowtoRead[1]-1, nrows = length(rowtoRead),
                    col.names = colnames(read.table(filePath, nrow = 1, header = TRUE, sep= ";")))


# Perform some conversions on the date and time values
hpcData$Datetime <- strptime(paste(hpcData$Date, hpcData$Time), "%d/%m/%Y %H:%M:%S")

# Make a plot in PNG file
png('plot2.png',width=480,height=480, bg="transparent")

plot(hpcData$Datetime, hpcData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()
