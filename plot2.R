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

##put Global_active_power as numeric  
all_var$Global_active_power = as.numeric(as.character(all_var$Global_active_power))

##Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.  
png(file="plot2.png",width=480,height=480)  

##Combine DateTime
all_var$DateTime = (paste(all_var$Date, all_var$Time))
all_var$DateTime = strptime(all_var$DateTime, format = "%d/%m/%Y %H:%M:%S")


##plot the second plot2 with variable Global_active_power
plot(all_var$DateTime, all_var$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

##turn off device
dev.off()
