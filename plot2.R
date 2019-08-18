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

#PLOT 2

plot(t$Global_active_power~t$DateTime , ylab="Global Active Power (kilowatts)", type="l", xlab="")
dev.copy(png, "plot2.png", width=480, height=480)
dev.off()
