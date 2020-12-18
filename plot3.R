library(dplyr)
library(lubridate)

df<-read.table("./household_power_consumption.txt",header=TRUE, sep=";",stringsAsFactors = FALSE)
df<-mutate(df, datetime=dmy(df$Date) + hms(df$Time))
filtered_df<-filter(df, datetime >= "2007-02-01 00:00:00" & datetime < "2007-02-03 00:00:00")
filtered_df$Sub_metering_1<-as.numeric(filtered_df$Sub_metering_1)
filtered_df$Sub_metering_2<-as.numeric(filtered_df$Sub_metering_2)
with(filtered_df, plot(Sub_metering_1, 
                       type="l",
                       col="black",
                       ylab="Energy Sub metering"))
lines(filtered_df$Sub_metering_2, col="red")
lines(filtered_df$Sub_metering_3, col="blue")
legend("topright",lty=1, col=c("black","red", "blue"), 
       legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))