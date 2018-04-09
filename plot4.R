zipfile <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", zipfile)
unzip(zipfile)
hpc <- read.table(file = 'household_power_consumption.txt', sep = ";", stringsAsFactors = FALSE, header = TRUE)
install.packages("lubridate")
install.packages("dplyr")
library(lubridate)
library(dplyr)
hpc$DateTime <- paste(hpc$Date, hpc$Time)
hpc$Date <- dmy(hpc$Date)
hpc_set <- hpc %>% filter(Date == '2007-02-01' | Date == "2007-02-02")
hpc_set$DateTime <- dmy_hms(hpc_set$DateTime)
hpc_set$Global_active_power <- as.numeric(hpc_set$Global_active_power)
hpc_set$Sub_metering_1 <- as.numeric(hpc_set$Sub_metering_1)
hpc_set$Sub_metering_2 <- as.numeric(hpc_set$Sub_metering_2)
hpc_set$Sub_metering_3 <- as.numeric(hpc_set$Sub_metering_3)

png(file = "plot4.png")
par(mfrow = c(2,2))

# 1st plot
with(hpc_set, plot(DateTime, Global_active_power, ylab = "Global Active Power", xlab = "", type = "l"))

# 2nd plot
with(hpc_set, plot(DateTime, Voltage, ylab = "Voltage", xlab = "datetime", type = "l"))

# 3rd plot
plot(hpc_set$DateTime, hpc_set$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
points(hpc_set$DateTime, hpc_set$Sub_metering_1, type = "l")
points(hpc_set$DateTime, hpc_set$Sub_metering_2, type = "l", col = "red")
points(hpc_set$DateTime, hpc_set$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# 4th plot
with(hpc_set, plot(DateTime, Global_reactive_power, xlab = "datetime", type = "l"))

dev.off()
