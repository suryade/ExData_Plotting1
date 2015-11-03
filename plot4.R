## Script file to generate plot and write to a png
library(data.table)
library(dplyr)

data <-
  fread(
    "household_power_consumption.txt", sep = ";", na.strings = c("?"), colClasses = c(
      "Date","Time", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"
    )
  )
sub_data1 <- filter(data, Date == "1/2/2007")
sub_data2 <- filter(data, Date == "2/2/2007")

final_data <- rbindlist(list(sub_data1, sub_data2))

## PNG device
png(filename = "plot4.png", width = 540, height = 540)

## Preparing the x axis of the plot
timeslice <-
  strptime(paste(final_data$Date, final_data$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")

## Set up the colors of the plot since there will be multiple lines representing
## the 3 Sub_metering data
colors <- c("black", "red", "blue")

## Configure the device for the plots
par(mfrow = c(2, 2))

## Generate plots
plot(
  x = timeslice, y = final_data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""
)

plot(
  x = timeslice, y = final_data$Voltage, type = "l", ylab = "Voltage", xlab = "datetime", col = colors[1]
)

## Generate plot for Sub_metering_1
plot(
  x = timeslice, y = final_data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", col = colors[1]
)

## Now add Sub_metering_2 to the existing plot
lines(
  x = timeslice, y = final_data$Sub_metering_2, type = "l", col = colors[2]
)

## Now add Sub_metering_3 to the existing plot
lines(
  x = timeslice, y = final_data$Sub_metering_3, type = "l", col = colors[3]
)

## Add the legend of the graph to the top right
legend(
  'topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = colors, cex = 0.8, lwd = 2
)

plot(
  x = timeslice, y = final_data$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime", col = colors[1]
)


## Write it out
dev.off()

## Clean up after itself
rm(final_data, data, sub_data1, sub_data2, colors, timeslice)