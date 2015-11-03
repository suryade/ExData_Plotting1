## Script file to generate histogram and write to a png
library(data.table)
library(dplyr)

# setwd("coursera/exploratory_data_analysis/Course_Proj_1/ExData_Plotting1/")
data <-
  fread(
    "household_power_consumption.txt", sep = ";", na.strings = c("?"), colClasses = c(
      "Date","Time", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"
    )
  )
sub_data1 <- filter(data, Date == "1/2/2007")
sub_data2 <- filter(data, Date == "2/2/2007")

final_data <- rbindlist(list(sub_data1, sub_data2))

## Generate histogram
hist(
  final_data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power"
)

## Generate png and write it out
dev.copy(png, file = "plot1.png")
dev.off()

## Clean up after itself
rm(final_data, data, sub_data1, sub_data2)