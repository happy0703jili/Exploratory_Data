# for plot 3

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

## plot 3
png(filename  = "plot3.png",width = 480, height = 480, units = "px")

with(e_power_con_2d, {
  plot(Date_Time,Sub_metering_1, type="l", xlab = "",ylab = "Energy sub metering")
  lines(Date_Time,Sub_metering_2,col = "red")
  lines(Date_Time,Sub_metering_3,col = "blue")
  legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1,col = c("black", "red","blue"))
})

dev.off()