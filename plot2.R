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

## Preparing the x axis of the plot
timeslice <-
  strptime(paste(final_data$Date, final_data$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")

## Generate plot
plot(
  x = timeslice, y = final_data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""
)

## Generate png and write it out
dev.copy(png, file = "plot2.png")
dev.off()

## Clean up after itself
rm(final_data, data, sub_data1, sub_data2, timeslice)