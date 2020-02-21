library("data.table")


power4 <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)


power4[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]


power4[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

power4 <- power4[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

plot(power4[, dateTime], power4[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

plot(power4[, dateTime],power4[, Voltage], type="l", xlab="datetime", ylab="Voltage")

plot(power4[, dateTime], power4[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(power4[, dateTime], power4[, Sub_metering_2], col="red")
lines(power4[, dateTime], power4[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 


plot(power4[, dateTime], power4[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()