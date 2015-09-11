## We first read in the first column of data from the raw text file for the simple 
## reason that we suppose to identify column numbers that correspond to data from 
## the dates 2007-02-01 and 2007-02-02 

timedata<- read.table("household_power_consumption.txt",
                      comment.char = "#",
                      header = TRUE,
                      sep = ";",
                      na.strings = "",
                      colClasses = c("factor", rep("NULL",8)))

##  Subset column number from the dates 2007-02-01 and 2007-02-02
colnum<-which(timedata$Date==c('1/2/2007') | timedata$Date==c('2/2/2007'))

## Read in the data containing column 2(Time) and 3(Global_active_power)
powerdata<- read.table("household_power_consumption.txt",
                       comment.char = "#",
                       header = TRUE,
                       sep = ";",
                       na.strings = "",
                       colClasses = c("NULL", "factor","factor",rep("NULL",6)))

## Subset Global_active_power data from the dates 2007-02-01 and 2007-02-02
GAP_factor<-powerdata$Global_active_power[colnum]

## Combine data of Date and Time
day_factor<-timedata$Date[colnum]
time_factor<-powerdata$Time[colnum]
timedata<-paste(day_factor,time_factor)
##  Convert the Date and Time variables to Date/Time classes
day<-strptime(timedata, "%d/%m/%Y %H:%M:%S")
 
## Convert the Global_Active_Power data to numeric
GAP_numeric<-as.numeric(as.character(GAP_factor))

## Construct plot2
plot(day,GAP_numeric,type = "l", ylab = "Global Active Power (kilowatts)",xlab = "")
## Save plot files as plot2.png
dev.copy(png, file = "plot2.png" ,width=480,height=480)
dev.off()