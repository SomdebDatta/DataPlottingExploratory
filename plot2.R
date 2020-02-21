library("data.table")



power2 <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)


power2[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]


power2[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]


power2 <- power2[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png", width=480, height=480)


plot(x = power2[, dateTime]
     , y = power2[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()