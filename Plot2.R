library(dplyr)
library(lubridate)

df<-read.table("./household_power_consumption.txt",header=TRUE, sep=";",stringsAsFactors = FALSE)
df<-mutate(df, datetime=dmy(df$Date) + hms(df$Time))
filtered_df<-filter(df, datetime >= "2007-02-01 00:00:00" & datetime < "2007-02-03 0:00:00")
filtered_df$Global_active_power<-as.numeric(filtered_df$Global_active_power)
with(filtered_df, plot(Global_active_power, 
                       type="l",
                       ylab="Global Active Power (Kilowatts)"))