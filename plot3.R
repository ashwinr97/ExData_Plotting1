#Code to read and load data

t <- read.table("household_power_consumption.txt", header = TRUE,  sep = ';', na.strings = '?')
t$Date <- as.Date(t$Date ,"%d/%m/%Y")
t <- subset(t, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

#Combining the Date and Time Coloumn into a single vector

DateTime <- paste(t$Date,t$Time)
DateTime <- setNames(DateTime,"DateTime")

t<- t[,!(names(t)%in% c("Date","Time"))]

t<- cbind(DateTime,t)

t$DateTime <- as.POSIXct(DateTime)

#PLOT 3

with (t, plot(t$Sub_metering_1~t$DateTime, type="l",xlab="", ylab="Global Active Power (kilowatts)"))
lines(t$Sub_metering_2~t$DateTime, col="red")            
lines(t$Sub_metering_3~t$DateTime, col="blue")
legend("topright", col=c("black","red","blue"),lwd=c(1,1,1),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.copy(png,"plot3.png",height=480, width=480)
dev.off()
