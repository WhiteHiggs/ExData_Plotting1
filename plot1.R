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

## Read in the data containing column 3 which represents Global_active_power
powerdata<- read.table("household_power_consumption.txt",
                       comment.char = "#",
                       header = TRUE,
                       sep = ";",
                       na.strings = "",
                       colClasses = c("NULL", "NULL","factor",rep("NULL",6)))

## Subset Global_active_power data from the dates 2007-02-01 and 2007-02-02
GAP_factor<-powerdata$Global_active_power[colnum]

## Convert the Global_Active_Power data to numeric
GAP_numeric<-as.numeric(as.character(GAP_factor))

## Construct the histogram plot with red color, title and xlabel
hist(GAP_numeric,col = "red",main = "Global Active Power",xlab = "Global Active Power (kilowatts)")

## Save plot files as plot1.png
dev.copy(png, file = "plot1.png" ,width=480,height=480)
dev.off()