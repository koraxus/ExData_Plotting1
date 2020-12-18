library(dplyr)
library(lubridate)

#Read and filter the data by date
df<-read.table("./household_power_consumption.txt",header=TRUE, sep=";",stringsAsFactors = FALSE)
df<-mutate(df, datetime=dmy(df$Date) + hms(df$Time))
filtered_df<-filter(df, datetime >= "2007-02-01 00:00:00" & datetime < "2007-02-03 00:00:00")

#Convert the submetering columns to numbers
filtered_df$Sub_metering_1<-as.numeric(filtered_df$Sub_metering_1)
filtered_df$Sub_metering_2<-as.numeric(filtered_df$Sub_metering_2)

#Open the png graphics device
png(filename="plot3.png", height=480, width=480)

#Make a line plot for Sub metering 1
with(filtered_df, plot(Sub_metering_1, 
                       type="l",
                       col="black",
                       ylab="Energy Sub metering"))
#Add sub metering 2 and sub metering 3
lines(filtered_df$Sub_metering_2, col="red")
lines(filtered_df$Sub_metering_3, col="blue")

#Make a legend
legend("topright",lty=1, col=c("black","red", "blue"), 
       legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

#Close the graphics device
dev.off()