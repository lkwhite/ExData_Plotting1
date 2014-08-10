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

png(file="plot2.png", height=480, width=480)
plot(x=as.POSIXlt(hpow_sub$datetime),
     y=as.numeric(hpow_sub$Global_active_power), type='l', 
     xlab="", ylab='Global Active Power')

dev.off()    
# opens up the png device, creates plot 2, and then closes device