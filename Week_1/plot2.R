# for plot 2

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

## plot 2
png(filename  = "plot2.png",width = 480, height = 480, units = "px")

with(e_power_con_2d,plot(Date_Time,Global_active_power, type="l", xlab = "",ylab = "Globa Active Power (kilowastts)"))

dev.off()