plot1 <- function() {
  ## Set directory
  vDir="/Users/Administrator/Coursera/Exploratory Data Analysis/Course Project 1"
  setwd(vDir)

  ## Read the Household Power Consumption data into table
  hpc <- read.table("household_power_consumption.txt",header=TRUE,sep=";",blank.lines.skip=TRUE)
  
  ## nrow(hpc) 2075259 rows  

  ## Obtain subset of data
  hpc_0201_0202 <- subset(hpc,as.Date(hpc$Date,"%d/%m/%Y")=="2007-02-01"|as.Date(hpc$Date,"%d/%m/%Y")=="2007-02-02")

  ## Generate a PNG file with the name plot1.png
  png(file="plot1.png",width = 480, height = 480, units = "px")

  ## Plot the histogram with labels
  plot(hist(as.numeric(as.character(hpc_0201_0202$Global_active_power))),xlab="Global Active Power (kilowatts)",ylab="Frequency",col="red",main="Global Active Power")
  dev.off()
}
