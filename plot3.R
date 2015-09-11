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

## Read in the data containing column 2(Time), 7(Sub_metering_1), 8(Sub_metering_2), 9(Sub_metering_3)
powerdata<- read.table("household_power_consumption.txt",
                       comment.char = "#",
                       header = TRUE,
                       sep = ";",
                       na.strings = "",
                       colClasses = c("NULL", "factor",rep("NULL",4),"factor","factor","factor"))

## Subset Sub_metering data from the dates 2007-02-01 and 2007-02-02
sub1_factor<-powerdata$Sub_metering_1[colnum]
sub2_factor<-powerdata$Sub_metering_2[colnum]
sub3_factor<-powerdata$Sub_metering_3[colnum]

## Combine data of Date and Time
day_factor<-timedata$Date[colnum]
time_factor<-powerdata$Time[colnum]
timedata<-paste(day_factor,time_factor)
##  Convert the Date and Time variables to Date/Time classes
day<-strptime(timedata, "%d/%m/%Y %H:%M:%S")


## Convert the Sub_metering data data to numeric
sub1_numeric<-as.numeric(as.character(sub1_factor))
sub2_numeric<-as.numeric(as.character(sub2_factor))
sub3_numeric<-as.numeric(as.character(sub3_factor))

## Construct plot3
## In order to make the appropriate location of the legend in a 480*480 png file,
## parameters like "adj", "x.intersp", "y.intersp" are specially set.
plot(day,sub1_numeric,type = "l", ylab = "Energy sub metering",xlab = "")
lines(day,sub2_numeric,col="red")
lines(day,sub3_numeric,col="blue")
legend("topright",lty=1,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),adj = c(0.2,0.4),
       x.intersp = 3,y.intersp = 0.5)

## Save plot files as plot3.png
dev.copy(png, file = "plot3.png",width=480,height=480)
dev.off()
