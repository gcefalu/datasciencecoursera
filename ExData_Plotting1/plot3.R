rm(list = ls())
library(dplyr)


# Data file directory path
dir <- file.path("C:", "Users", "giuse", "OneDrive", "Documents", "DataScience", "Data Files")

# read data file
df <- read.table(file.path(dir, "household_power_consumption.txt"), header = TRUE, sep = ";", stringsAsFactors = FALSE,  na.strings = "NA")

# Combine date and time. The result will be a char string
df <- mutate(df, dateTime = paste(df$Date,df$Time))

# Convert to POSIXct time
df <- mutate(df, posix_date = as.POSIXct(strptime(dateTime,format = "%d/%m/%Y %H:%M:%S",tz="UTC")))

# Extract a subset of the data
df <- na.omit(subset(df, posix_date >= "2006-12-21 01:00:00" & posix_date <= "2006-12-23 01:00:00" ))

# Open png device
png(file = "plot3.png")

# Render plot without axis
with(df, plot(posix_date, as.numeric(Sub_metering_1), xlab = "", ylab = "Energy sub metering",type = "l", xaxt = "n"))

# render 2 more plots on the same axis
lines(df$posix_date, as.numeric(df$Sub_metering_2), type = "l", col = "red")
lines(df$posix_date, as.numeric(df$Sub_metering_3), type = "l", col = "blue")

# Create plot legend
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.62)

#  Render axis
axis.POSIXct(1, at=seq(first(df$posix_date),last(df$posix_date), by="day"), format="%a")

# close png device
 dev.off()
