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

# Obtain a subset of the data
df <- na.omit(subset(df, posix_date >= "2006-12-21 01:00:00" & posix_date <= "2006-12-23 01:00:00" ))

# Open png device to write to png file
png(file = "plot2.png")

# Render plot without axis
with(df, plot(posix_date, as.numeric(Global_active_power), xlab = "", ylab = "Global active power (Kylowatts)",type = "l", xaxt = "n"))

#  Render axis
axis.POSIXct(1, at=seq(first(df$posix_date),last(df$posix_date), by="day"), format="%a")

# close png device
dev.off()




