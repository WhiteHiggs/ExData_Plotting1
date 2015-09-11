## We first read in the first column of data from the raw text file for the simple 
## reason that we suppose to identify column numbers that correspond to data from 
## the dates 2007-02-01 and 2007-02-02 

timedata<- read.table("household_power_consumption.txt",
                      comment.char = "#",
                      header = TRUE,
                      sep = ";",
                      na.strings = "",
                      colClasses = c("factor", rep("NULL",8)))
##  Convert the Date and Time variables to Date/Time classes
## powerdata$Date<-strptime(powerdata$Date, "%d/%m/%Y")

##  Subset column number from the dates 2007-02-01 and 2007-02-02
colnum<-which(timedata$Date==c('1/2/2007') | timedata$Date==c('2/2/2007'))

## Read in the data containing column 2(Time),3(Global_active_power),4(Global_reactive_power),
## 5(Voltage),7(Sub_metering_1),8(Sub_metering_2),9(Sub_metering_3)
powerdata<- read.table("household_power_consumption.txt",
                       comment.char = "#",
                       header = TRUE,
                       sep = ";",
                       na.strings = "",
                       colClasses = c("NULL",rep("factor",4),"NULL",rep("factor",3)))


## Subset data from the dates 2007-02-01 and 2007-02-02
#  Global Active Power
GAP_factor<-powerdata$Global_active_power[colnum]
#  Voltage
V_factor<-powerdata$Voltage[colnum]
#  Sub_metering data
sub1_factor<-powerdata$Sub_metering_1[colnum]
sub2_factor<-powerdata$Sub_metering_2[colnum]
sub3_factor<-powerdata$Sub_metering_3[colnum]
#  Global Aeactive Power
GRP_factor<-powerdata$Global_reactive_power[colnum]

## Combine data of Date and Time
day_factor<-timedata$Date[colnum]
time_factor<-powerdata$Time[colnum]
timedata<-paste(day_factor,time_factor)

## Convert the Date and Time variables to Date/Time classes
day<-strptime(timedata, "%d/%m/%Y %H:%M:%S")

## Convert the data to numeric
GAP_numeric<-as.numeric(as.character(GAP_factor))

V_numeric<-as.numeric(as.character(V_factor))

sub1_numeric<-as.numeric(as.character(sub1_factor))
sub2_numeric<-as.numeric(as.character(sub2_factor))
sub3_numeric<-as.numeric(as.character(sub3_factor))

GRP_numeric<-as.numeric(as.character(GRP_factor))

## Construct plot4
#  In order to make the appropriate location of the legend in a 480*480 png file,
#  parameters like "x.intersp", "y.intersp", "cex", "inset" are specially set.

#  Subsequent figures will be drawn in an 2-by-2 array on the device by rows (mfrow), respectively 
par(mfrow = c(2,2))
#  c(1,1)
plot(day,GAP_numeric,type = "l", ylab = "Global Active Power (kilowatts)",xlab = "")
#  c(1,2)
plot(day,V_numeric,type = "l", ylab = "Voltage",xlab = "datetime")
#  c(2,1)
plot(day,sub1_numeric,type = "l", ylab = "Energy sub metering",xlab = "")
lines(day,sub2_numeric,col="red")
lines(day,sub3_numeric,col="blue")
legend("topright",lty=1,c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),x.intersp = 0.2, y.intersp = 0.2,bty = "n",
       inset =c(0.1,-0.15),cex = 0.8)
#  c(2,2)
plot(day,GRP_numeric,type = "l", ylab = "Global_reactive_power",xlab = "datetime")


## Save plot files as plot4.png
dev.copy(png, file = "plot4.png",width=480,height=480)
dev.off()