library(dplyr)
library(lubridate)

#Read and filter the data
df<-read.table("./household_power_consumption.txt",header=TRUE, sep=";",stringsAsFactors = FALSE)
df<-mutate(df, datetime=dmy(df$Date) + hms(df$Time))
filtered_df<-filter(df, datetime >= "2007-02-01 00:00:00" & datetime < "2007-02-03 00:00:00")

#Convert the appropriate columns to numbers
filtered_df$Global_active_power<-as.numeric(filtered_df$Global_active_power)
filtered_df$Global_reactive_power<-as.numeric(filtered_df$Global_reactive_power)
filtered_df$Sub_metering_1<-as.numeric(filtered_df$Sub_metering_1)
filtered_df$Sub_metering_2<-as.numeric(filtered_df$Sub_metering_2)

#Open the png graphics device
png(filename="plot4.png", height=480, width=480)

# Create a 2 X 2 plot frame
par(mfrow=c(2,2))

#Write the plots
with(filtered_df, {
  #Line plot of the Global Active Power
  plot(Global_active_power, 
       type="l",
       ylab="Global Active Power (Kilowatts)")
  #Voltage Line plot
  plot(Voltage, type="l", ylab="Voltage", xlab="datetime")
  #Submetering plots with legend
  plot(Sub_metering_1, 
       type="l",
       col="black",
       ylab="Energy Sub metering")
  lines(filtered_df$Sub_metering_2, col="red")
  lines(filtered_df$Sub_metering_3, col="blue")
  legend("topright",lty=1, col=c("black","red", "blue"), 
       legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
  #Global reactive power with label
  plot(Global_reactive_power, type="l", xlab="datetime")
})

#Close the graphics device
dev.off()

