
# Read the raw data
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c(rep("character", 2), rep("numeric", 7)))
# Subset data for the specific dates
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]
# Create a DateTime column by combining Date and Time
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")
# Reorganize columns: put DateTime as the first column
data <- cbind(Date_time = data$DateTime, data[, 3:9])

# Generate Plot 1
png(filename = "Plot1.png", width = 480, height = 480, units = "px")
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", breaks = 12, ylim = c(0, 1200))
dev.off()

# Clean up the data frame
rm(data)