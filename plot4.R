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


#PLOT 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(t, { plot(Global_active_power~DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
          
          plot(Voltage ~ DateTime, type="l",ylab="Voltage (volt)", xlab="")
          
          plot(Sub_metering_1 ~ DateTime, type="l", ylab = "Global Active Power (kilowatts)", xlab="")
          lines(Sub_metering_2 ~ DateTime, col="red")
          lines(Sub_metering_3 ~ DateTime, col="blue")
          legend("topright",col=c("black","red","blue"),lwd=c(1,1,1),bty="n",lty=1,c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
          
        plot(Global_reactive_power ~ DateTime, type="l", ylab="Global Reactive Power (kilowatts)",  xlab="")
})
  

dev.copy(png,"plot4.png",height=480,width=480)        
dev.off()
