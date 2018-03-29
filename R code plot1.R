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

#Plot graph 1 in a png file name plot1.png
png(filename = "plot1.png", width = 480, height = 480)
Plot1 <- hist(Power1$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()