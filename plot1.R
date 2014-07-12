## I am put the file in this directory
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
  png(file="plot1.png",width=480,height=480)  
  
##Create a Plot1 ( histograph)
  hist(all_var$Global_active_power, col = "red", ylab = "Frequency", 
       xlab = "Global Active Power (kilowatts)", main = "Global Active Power ")
  
##turn off device
  dev.off()
  
