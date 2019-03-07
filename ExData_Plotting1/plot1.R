rm(list = ls())

# Data file directory path
dir <- file.path("C:", "Users", "giuse", "OneDrive", "Documents", "DataScience", "Data Files")

# read data file
df <- read.table(file.path(dir, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "NA")

# Open png device
png(file = "plot1.png")

# render histogram
with(df, hist(as.numeric(Global_active_power), col = "red", xlab = "Global Active Power (Kilowats)", ylab = "Frequency", main = "Gloval Active Power"))

# close png device
dev.off()


