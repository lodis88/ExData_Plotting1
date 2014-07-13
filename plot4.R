## I am put de file in this directory
setwd("C:/Users/Marcos/Desktop/dat science")

##read in the data, all variables as characters.
##skip to desired rows.
all_var <- read.table("household_power_consumption.txt", skip = 66637, nrow = 2880, 
                      sep = ";", colClasses="character",
                      col.names = colnames(read.table("household_power_consumption.txt",
                                                      nrow = 1, header = TRUE, sep=";")))
## See all variables  
##  head(all_var)
## put NA in table
all_var[all_var == "?"] = NA
##Convert the column "Date" of all_var electric power consumption to Date Type
all_var$Date <- as.Date(all_var$Date, "%d/%m/%Y")
##Select the data of the date: 2007-02-01
datasetFebrary_1_2007 <- all_var[(all_var$Date == as.Date("2007-02-01")),]
##Select the data of the date: 2007-02-02
datasetFebrary_2_2007 <- all_var[(all_var$Date == as.Date("2007-02-02")),]
##Merge the vectors datasetFebrary_1_2007 and datasetFebrary_2_2007 per Columns
datasetFebrary_1_2_2007 <- rbind(datasetFebrary_1_2007,datasetFebrary_2_2007)
# concatenate the columns: Date and Time in a new column called: Datetime
datasetFebrary_1_2_2007$Datetime <- strptime(paste(datasetFebrary_1_2_2007$Date, datasetFebrary_1_2_2007$Time), "%Y-%m-%d %H:%M:%S")
##Open png device
png(filename="plot4.png", width = 480, height = 480)
##Join 4 plots (two rows and two columns) in one device
par(mfrow = c(2, 2))
##------------------------ Plot 1 ------------------------ 
##Plot the Time Series - Global Active Power
plot(datasetFebrary_1_2_2007$Datetime, datasetFebrary_1_2_2007$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")
## ------------------------ Plot 2 ------------------------ 
##Plot the Time Series - Voltage
plot(datasetFebrary_1_2_2007$Datetime, datasetFebrary_1_2_2007$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
##------------------------ Plot 3 ------------------------ 
##Plot the black line that show the Sub_metering_1 data 
plot(datasetFebrary_1_2_2007$Datetime, datasetFebrary_1_2_2007$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", col = "black")
##Plot the red line that show the Sub_metering_2 data 
points(datasetFebrary_1_2_2007$Datetime, datasetFebrary_1_2_2007$Sub_metering_2, type = "l", xlab = "", ylab = "Sub_metering_2", col = "red")
##Plot the blue line that show the Sub_metering_3 data
points(datasetFebrary_1_2_2007$Datetime, datasetFebrary_1_2_2007$Sub_metering_3, type = "l", xlab = "", ylab = "Sub_metering_3", col = "blue")
##write the legends of the lines: Sub_metering_1, Sub_metering_2, and Sub_metering_3
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", )
## ------------------------ Plot 4 ------------------------ 
##Plot the Time Series - Global Reactive Power
plot(datasetFebrary_1_2_2007$Datetime, datasetFebrary_1_2_2007$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", ylim = c(0, 0.5))
##Close the device using dev.off
dev.off()
