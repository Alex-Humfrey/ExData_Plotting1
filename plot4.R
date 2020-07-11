library(lubridate)
library(date)

#read in text file
hpc <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
#change class of "Date" column to Date
hpc$Date <- as_date(as.character(hpc$Date), format = "%d/%m/%Y")

#subset for observations between 01/02/2007 and 02/02/2007
hpc <- hpc[hpc$Date >= "2007-02-01" & hpc$Date <= "2007-02-02",]

#change class of "Global Active Power" column to numeric
hpc$Global_active_power <- as.numeric(as.character(hpc$Global_active_power))

#change class of "Time" column to POSIXlt
#hpc$Time <- strptime(as.character(hpc$Time),format = "%H:%M:%S")
a <- as.character(hpc$Date)
b <- as.character(hpc$Time)
a <- cbind(a,b)
a  <- paste0(a[,1], sep = " ", a[,2])
hpc$Time <- strptime(a, format = "%Y-%m-%d %H:%M:%S")

#change sub metering class to numeric
hpc$Sub_metering_1 <- as.numeric(as.character(hpc$Sub_metering_1))
hpc$Sub_metering_2 <- as.numeric(as.character(hpc$Sub_metering_2))


#write histogram to PNG file
png(filename = "plot4.png")

#set-up environment to show 4 plots
par(mfcol= c(2,2))

#plot line graph 2
plot(hpc$Time, hpc$Global_active_power, type = "l", xlab = NA, ylab = "Global Active Power (kilowatts)")

#plot line graph 3
plot(hpc$Time, hpc$Sub_metering_1, type = "l", xlab = NA, ylab = "Energy sub metering")
lines(hpc$Time, hpc$Sub_metering_2, col = "red")
lines(hpc$Time, hpc$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"), lty =1:1)

#plot line graph 4
hpc$Voltage <- as.numeric(as.character(hpc$Voltage))
plot(hpc$Time, hpc$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

#plot line graph 5
hpc$Global_reactive_power <- as.numeric(as.character(hpc$Global_reactive_power))
plot(hpc$Time, hpc$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

#switch off graphics device
dev.off()