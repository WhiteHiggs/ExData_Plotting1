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

## Read in the data only contain column 3 which represents Global_active_power
powerdata<- read.table("household_power_consumption.txt",
                       comment.char = "#",
                       header = TRUE,
                       sep = ";",
                       na.strings = "",
                       colClasses = c("NULL", rep("factor",4),"NULL",rep("factor",3)))

## Subset Global_active_power data from the dates 2007-02-01 and 2007-02-02
sub1_factor<-powerdata$Sub_metering_1[colnum]
sub2_factor<-powerdata$Sub_metering_2[colnum]
sub3_factor<-powerdata$Sub_metering_3[colnum]
GAP_factor<-powerdata$Global_active_power[colnum]
V_factor<-powerdata$Voltage[colnum]
GRP_factor<-powerdata$Global_reactive_power[colnum]


day_factor<-timedata$Date[colnum]
time_factor<-powerdata$Time[colnum]
timedata<-paste(day_factor,time_factor)

## Convert the Global_Active_Power data to numeric
sub1_numeric<-as.numeric(as.character(sub1_factor))
sub2_numeric<-as.numeric(as.character(sub2_factor))
sub3_numeric<-as.numeric(as.character(sub3_factor))

V_numeric<-as.numeric(as.character(V_factor))

GRP_numeric<-as.numeric(as.character(GRP_factor))
GAP_numeric<-as.numeric(as.character(GAP_factor))

par(mfrow=c(2,2))
plot(day,GAP_numeric,type = "l", ylab = "Global Active Power (kilowatts)",xlab = "")
plot(day,V_numeric,type = "l", ylab = "Voltage",xlab = "datetime")

plot(day,sub1_numeric,type = "l", ylab = "Energy sub metering",xlab = "")
lines(day,sub2_numeric,col="red")
lines(day,sub3_numeric,col="blue")
legend("topright",lty=1, c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),bty="n")

plot(day,GRP_numeric,type = "l", ylab = "Global_reactive_power",xlab = "datetime")