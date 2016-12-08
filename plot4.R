#Loading the data
temp<-tempfile()
fileName<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileName,temp, mode="wb")
unzip(temp, "household_power_consumption.txt")
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
unlink(temp)

#Convert the Date column to Date format
data$Date<-as.Date(data$Date,format='%d/%m/%Y')

#Create a DateTime column
data$DateTime<-paste(data$Date, data$Time)
data$DateTime<-strptime(data$DateTime,format = "%Y-%m-%d %H:%M:%S")


#Extract the data for the dates 2007-02-01 and 2007-02-02
dataExtract<-subset(data, (data$Date == "2007-02-01")|(data$Date == "2007-02-02"))

#Convert the Sub_metering variables to numeric format for plotting
dataExtract$Sub_metering_1<-as.numeric(as.character(dataExtract$Sub_metering_1))
dataExtract$Sub_metering_2<-as.numeric(as.character(dataExtract$Sub_metering_2))
dataExtract$Sub_metering_3<-as.numeric(as.character(dataExtract$Sub_metering_3))
#Convert the Global_active_power and Global_reactive_power variables to numeric format for plotting
dataExtract$Global_active_power<-as.numeric(as.character(dataExtract$Global_active_power))
dataExtract$Global_reactive_power<-as.numeric(as.character(dataExtract$Global_reactive_power))
dataExtract$Voltage<-as.numeric(as.character(dataExtract$Voltage))

#Create Plot4
png(filename = "plot4.png",width = 480, height = 480)
#Partition the plotting environment
par(mfrow = c(2,2))
#First Graph
with(dataExtract, plot(DateTime, Global_active_power,type = "l",xlab='', ylab = "Global Active Power"))
#Second Graph
with(dataExtract, plot(DateTime, Voltage,type = "l",xlab="datetime", ylab = "Voltage"))
#Third Graph
with(dataExtract, plot(DateTime, Sub_metering_1, type = "l", col="black", xlab='', ylab = "Energy sub metering"))
with(dataExtract, lines(DateTime, Sub_metering_2, type = "l", col="red"))
with(dataExtract, lines(DateTime, Sub_metering_3, type = "l", col="blue"))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1),col=c("black","red","blue"))
#Fourth Graph
with(dataExtract,plot(DateTime, Global_reactive_power,type = "l",xlab="datetime"))
dev.off()