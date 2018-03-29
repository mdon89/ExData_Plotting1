#Read in data
Power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?",stringsAsFactors = FALSE )

#Subset for 2007-02-01 and 2007-02-02
Power1 <- Power[(Power$Date == "1/2/2007" | Power$Date == "2/2/2007"),]

#Date conversion to date format
Power1$Date <- as.Date(Power1$Date, "%d/%m/%Y")

#Add date and time column together in Dataframe
Power2 <- mutate(Power1, Date_and_Time = paste(Power1$Date, Power1$Time, sep = " "))

#Convert date and time column to POSIXlt
Power2$Date_and_Time <- ymd_hms(Power2$Date_and_Time, tz = Sys.timezone())

#Plot graph 4 in a png file name plot4.png
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
plot(Power2$Date_and_Time, Power2$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
plot(Power2$Date_and_Time, Power2$Voltage, type = "l", xlab = "Datetime", ylab = "Voltage")
with(Power2, plot(Date_and_Time, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
with(Power2, lines(Date_and_Time, Sub_metering_2, type = "l", col = "red"))
with(Power2, lines(Date_and_Time, Sub_metering_3, type = "l", col = "blue"))
with(Power2, lines(Date_and_Time, Sub_metering_1, type = "l", col = "black"))
legend("topright", pch = "-", col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
plot(Power2$Date_and_Time, Power2$Global_reactive_power, type = "l", xlab = "Datetime", ylab = "Global_reactive_power")
dev.off()