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
#creating the plot
png(file = 'plot1.png')

hist(subdf$Global_active_power, xlab = 'Global Active Power (kilowatts)', 
     ylab = 'Frequency', main = 'Global Active Power', col = 'red')
dev.off()
