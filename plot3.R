library("data.table")


power3 <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?")

power3[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]


power3[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]


power3 <- power3[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot3.png", width=480, height=480)


plot(power3[, dateTime], power3[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(power3[, dateTime], powerDT[, Sub_metering_2],col="green")
lines(power3[, dateTime], powerDT[, Sub_metering_3],col="orange")
legend("topright"
       , col=c("black","green","orange")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()