# Read the raw data
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c(rep("character", 2), rep("numeric", 7)))

# Subset data for the specific dates
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

# Create a DateTime column by combining Date and Time
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

# Reorganize columns: put DateTime as the first column
data <- cbind(Date_time = data$DateTime, data[, 3:9])

# Generate Plot 4
png(filename = "Plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2))

# Top - Left
plot(data$Date_time, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", xaxt = "n")
axis(side = 1, at = c(data$Date_time[1], data$Date_time[1441], data$Date_time[2880]), labels = c("Thu", "Fri", "Sat"))

# Top - Right
plot(data$Date_time, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", xaxt = "n")
axis(side = 1, at = c(data$Date_time[1], data$Date_time[1441], data$Date_time[2880]), labels = c("Thu", "Fri", "Sat"))

# Bottom - Left
plot(data$Date_time, data$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering", xaxt = "n")
lines(data$Date_time, data$Sub_metering_2, col = "red")
lines(data$Date_time, data$Sub_metering_3, col = "blue")
legend("topright", bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)
axis(side = 1, at = c(data$Date_time[1], data$Date_time[1441], data$Date_time[2880]), labels = c("Thu", "Fri", "Sat"))

# Bottom - Right
plot(data$Date_time, data$Global_reactive_power, type = "l", col = "black", xlab = "datetime", ylab = "Global Reactive Power", xaxt = "n")
axis(side = 1, at = c(data$Date_time[1], data$Date_time[1441], data$Date_time[2880]), labels = c("Thu", "Fri", "Sat"))

dev.off()

# Clean up the data frame
rm(data)
