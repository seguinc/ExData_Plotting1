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

#Convert the Global_active_power variable to numeric format for plotting
dataExtract$Global_active_power<-as.numeric(as.character(dataExtract$Global_active_power))

#Create Plot2
png(filename = "plot2.png",width = 480, height = 480)
with(dataExtract, plot(DateTime, Global_active_power,type = "l",xlab='', ylab = "Global Active Power (kilowatts)"))
dev.off()