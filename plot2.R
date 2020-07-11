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


#write histogram to PNG file
png(filename = "plot2.png")
#plot line graph
plot(hpc$Time, hpc$Global_active_power, type = "l", xlab = NA, ylab = "Global Active Power (kilowatts)")
#switch off graphics device
dev.off()