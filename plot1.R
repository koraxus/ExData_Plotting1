library(dplyr)
library(lubridate)

#Read data file
df<-read.table("./household_power_consumption.txt",header=TRUE, sep=";",stringsAsFactors = FALSE)
#Create a datetime column for filtering
df<-mutate(df, datetime=dmy(df$Date) + hms(df$Time))
#Filter the data by date
filtered_df<-filter(df, datetime >= "2007-02-01 00:00:00" & datetime <= "2007-02-02 23:59:59")

#Convert Global Active Power to a number
filtered_df$Global_active_power<-as.numeric(filtered_df$Global_active_power)

#Open the png graphics device
png(filename="plot1.png", height=480, width=480)

#Write the histogram
hist(filtered_df$Global_active_power, 
     col="red", 
     main="Global Active Power",
     xlab="Global Active Power (Kilowatts)", breaks=20)

#Close the graphics device
dev.off()