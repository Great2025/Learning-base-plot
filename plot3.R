#downlaoding the data
setwd(.)

download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
              paste0(getwd(),'/Power Consumption.zip'), method = 'auto')

#unzips the zip file and stores it in the variable 
power_dataset = unzip(paste0(getwd(),'/exdata_data_household_power_consumption.zip'))

#reading in the file
df = read.table(strsplit(power_dataset[1], split ='/')[[1]][2], sep = ";", header = TRUE
                ,stringsAsFactors = FALSE, na.strings = '?')

#subset the required data for the given dates after conversion
df$Date = as.Date(df$Date, format = '%d/%m/%Y')
subdf = subset(df, df$Date == as.Date('01/02/2007', format = '%d/%m/%Y') |
                       df$Date == as.Date('02/02/2007', format = '%d/%m/%Y'))

#rearranging the time variable

subdf$Exact_Time = strptime(paste(subdf$Date, subdf$Time), format = "%Y-%m-%d %H:%M:%S") 

#creating the plot
png(file = 'plot3.png')

plot(subdf$Exact_Time, subdf$Sub_metering_1, type = 'n', xlab = '', 
     ylab = 'Energy sub Metering' )
lines(subdf$Exact_Time, subdf$Sub_metering_1)
lines(subdf$Exact_Time, subdf$Sub_metering_2, col = 'red')
lines(subdf$Exact_Time, subdf$Sub_metering_3, col = 'blue')
legend('topright', legend = c('Sub_metering_1', "Sub_metering_2", "Sub_metering_3"),
       lty = 1, col = c('black', 'red', 'blue'))
dev.off()
