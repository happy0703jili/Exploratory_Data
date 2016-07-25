library("dplyr")
# import the dataset
e_power_con <- read.delim("E:/MOOC/exploratory data analysis/household_power_consumption.txt", header = T,sep = ";", stringsAsFactors = F)

# data manipulation
e_power_con_2d <- e_power_con %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  mutate(Date_Time = paste(Date,Time)) %>%
  mutate(Date = as.Date(Date,"%d/%m/%Y")) 
  
e_power_con_2d$Date_Time <- as.POSIXct(e_power_con_2d$Date_Time, format="%d/%m/%Y %H:%M:%S")
e_power_con_2d$Time <- as.POSIXct(e_power_con_2d$Time, format="%d/%m/%Y %H:%M:%S")

# change the type of the data in row 3 to 9
for (i in 3:9) {
  e_power_con_2d[,i] <- as.numeric(e_power_con_2d[,i])
} 

# graph 1
png(filename  = "plot1.png",width = 480, height = 480, units = "px")

hist(e_power_con_2d$Global_active_power, col = "red",main ="Globa Active Power", xlab = "Globa Active Power (kilowastts)", ylab = "Frequency")
dev.off()

# graph 2
png(filename  = "plot2.png",width = 480, height = 480, units = "px")

with(e_power_con_2d,plot(Date_Time,Global_active_power, type="l", xlab = "",ylab = "Globa Active Power (kilowastts)"))

dev.off()

# graph 3
png(filename  = "plot3.png",width = 480, height = 480, units = "px")

with(e_power_con_2d, {
  plot(Date_Time,Sub_metering_1, type="l", xlab = "",ylab = "Energy sub metering")
  lines(Date_Time,Sub_metering_2,col = "red")
  lines(Date_Time,Sub_metering_3,col = "blue")
  legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1,col = c("black", "red","blue"))
})

dev.off()

# graph 4
png(filename  = "plot4.png",width = 480, height = 480, units = "px")

par(mfrow = c(2,2))
with(e_power_con_2d, {
  plot(Date_Time, Global_active_power, type = "l", ylab = "Globa Active Power (kilowastts)")
  plot(Date_Time, Voltage, type = "l", xlab =  "datetime", ylab = "Voltage")})
  with(e_power_con_2d, {
    plot(Date_Time,Sub_metering_1, type="l", xlab = "",ylab = "Energy sub metering")
    lines(Date_Time,Sub_metering_2,col = "red")
    lines(Date_Time,Sub_metering_3,col = "blue")
    legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty ="n", lty = c(1,1,1),col = c("black", "red","blue"))
  })
    
with(e_power_con_2d,plot(Date_Time, Global_reactive_power, type = "l", xlab = "datetime"))

dev.off()
