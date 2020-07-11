library(lubridate)
library(date)

#read in text file
hpc <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
#change class of "Date" column to Date
hpc$Date <- as_date(as.character(hpc$Date), format = "%d/%m/%Y")

#subset for observations between 01/02/2007 and 02/02/2007
hpc <- hpc[hpc$Date >= "2007-02-01" & hpc$Date <= "2007-02-02",]

#change class of "Time" column to POSIXlt
hpc$Time <- strptime(as.character(hpc$Time),format = "%H:%M:%S")

#change class of "Global Active Power" column to numeric
hpc$Global_active_power <- as.numeric(as.character(hpc$Global_active_power))

#write histogram to PNG file
png(filename = "plot1.png")
#plot histogram
hist(hpc$Global_active_power, col = "red", main = paste("Global Active Power"), xlab = "Global Active Power (kilowatts)")
#switch off graphics device
dev.off()