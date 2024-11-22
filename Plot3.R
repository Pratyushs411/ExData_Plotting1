# Read the raw data
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c(rep("character", 2), rep("numeric", 7)))

# Subset data for the specific dates
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

# Create a DateTime column by combining Date and Time
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

# Reorganize columns: put DateTime as the first column
data <- cbind(Date_time = data$DateTime, data[, 3:9])

# Generate Plot 3
png(filename = "Plot3.png", width = 480, height = 480, units = "px")
plot(data$Date_time, data$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering", xaxt = "n")
lines(data$Date_time, data$Sub_metering_2, col = "red")
lines(data$Date_time, data$Sub_metering_3, col = "blue")
axis(1, at = c(data$Date_time[1], data$Date_time[1441], data$Date_time[2880]), labels = c("Thu", "Fri", "Sat"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
dev.off()

# Clean up the data frame
rm(data)
