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
                    col.names = colnames(read.table(filePath, nrow = 1, header = TRUE, sep= ";")))

# Make a plot in PNG file
png('./figure/plot1.png',width=480,height=480, bg="transparent")

hist(hpcData$Global_active_power, main = "Global Active Power", ylab = "Frequency", 
     xlab = "Global Active Power (kilowatts)", col = "red")

dev.off()
