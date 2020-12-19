library(dplyr)
library(lubridate)

#Read and filter the data by dates of interest
df<-read.table("./household_power_consumption.txt",header=TRUE, sep=";",stringsAsFactors = FALSE)
df<-mutate(df, datetime=dmy(df$Date) + hms(df$Time))
filtered_df<-df[which(df$Date == "1/2/2007" | df$Date == "2/2/2007"),]
# Convert Global active power to a number
filtered_df$Global_active_power<-as.numeric(filtered_df$Global_active_power)

#Open the png graphics device
png(filename="plot2.png", height=480, width=480)


#Make a line plot of Global Active Power
with(filtered_df, plot(x=datetime, y=Global_active_power, 
                       type="l",
                       ylab="Global Active Power (Kilowatts)"))

#Close the graphics device
dev.off()