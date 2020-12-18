library(dplyr)
library(lubridate)

df<-read.table("./household_power_consumption.txt",header=TRUE, sep=";",stringsAsFactors = FALSE)
df<-mutate(df, datetime=dmy(df$Date) + hms(df$Time))
filtered_df<-filter(df, datetime >= "2007-02-01 00:00:00" & datetime <= "2007-02-02 23:59:59")
filtered_df$Global_active_power<-as.numeric(filtered_df$Global_active_power)
hist(filtered_df$Global_active_power, 
     col="red", 
     main="Global Active Power",
     xlab="Global Active Power (Kilowatts)", breaks=20)