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

#Convert the Sub_metering variables to numeric format to prepare for plotting
dataExtract$Sub_metering_1<-as.numeric(as.character(dataExtract$Sub_metering_1))
dataExtract$Sub_metering_2<-as.numeric(as.character(dataExtract$Sub_metering_2))
dataExtract$Sub_metering_3<-as.numeric(as.character(dataExtract$Sub_metering_3))

#Create Plot3
png(filename = "plot3.png",width = 480, height = 480)
#Creating first plot
with(dataExtract, plot(DateTime, Sub_metering_1, type = "l", col="black", xlab='', ylab = "Energy sub metering"))
#Add two other variables to the plot
with(dataExtract, lines(DateTime, Sub_metering_2, type = "l", col="red"))
with(dataExtract, lines(DateTime, Sub_metering_3, type = "l", col="blue"))
#Add the legend to the plot
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1),col=c("black","red","blue"))
dev.off()