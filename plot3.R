courseproj1_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(courseproj1_url, "household_power_consumption.zip")
unzip("household_power_consumption.zip", exdir="assignment1")
# identifies, downloads, unzips project data file

hpow  <- read.table("assignment1/household_power_consumption.txt", header = TRUE,
                    sep = ";", na="?")
# reads file in table format and creates a data frame called "hpow"

hpow$Date <- as.Date(hpow$Date, format="%d/%m/%Y")
# converts date column from class = character to class = date
# with arguments matching how the date was originally formatted

hpow_sub <- hpow[hpow$Date=="2007-02-01" | hpow$Date=="2007-02-02", ]
# subsets data to dates of interest

hpow_sub$datetime <- paste(hpow_sub$Date, hpow_sub$Time)
# combine date and time variables into separate column

hpow_sub$Sub_metering_1 <- as.numeric(hpow_sub$Sub_metering_1)
hpow_sub$Sub_metering_2 <- as.numeric(hpow_sub$Sub_metering_2)
hpow_sub$Sub_metering_3 <- as.numeric(hpow_sub$Sub_metering_3)
# converts sub-metering data to numerics for use in plot 3

png(file="plot3.png", height=480, width=480)
plot(x=as.POSIXlt(hpow_sub$datetime), y=hpow_sub$Sub_metering_1, type="n",
     xlab = "", ylab = "Energy sub metering")

lines(as.POSIXlt(hpow_sub$datetime),hpow_sub$Sub_metering_1)
lines(as.POSIXlt(hpow_sub$datetime),hpow_sub$Sub_metering_2,col="red")
lines(as.POSIXlt(hpow_sub$datetime),hpow_sub$Sub_metering_3,col="blue")

legend(x='topright',
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col=c('black', 'red', 'blue'), lwd=2)
dev.off()
# opens up the png device, creates plot 3, and then closes device