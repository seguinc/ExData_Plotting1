#Loading the data
temp<-tempfile()
fileName<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileName,temp, mode="wb")
unzip(temp, "household_power_consumption.txt")
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
unlink(temp)

#Convert the Date column to Date format
data$Date<-as.Date(data$Date,format='%d/%m/%Y')
#Convert the Global_active_power to numeric format to be able to create histogram
data$Global_active_power<-as.numeric(as.character(data$Global_active_power))

#Extract the data for the dates 2007-02-01 and 2007-02-02
dataExtract<-subset(data, (data$Date == "2007-02-01")|(data$Date == "2007-02-02"))

#Create Plot1
png(filename = "plot1.png",width = 480, height = 480)
hist(dataExtract$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()