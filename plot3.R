library(dplyr)

raw_hpc <- read.table(file = "household_power_consumption.txt",
                      header = TRUE,
                      sep = ';',
                      na.strings = "?",
                      stringsAsFactors = FALSE,
                      check.names = FALSE,
                      colClasses = c(character(),
                                     character(),
                                     numeric(),
                                     numeric(),
                                     numeric(),
                                     numeric(),
                                     numeric(),
                                     numeric(),
                                     numeric()))

tidy_hpc <- raw_hpc %>%
  mutate(Time = strptime(paste(Date, " " ,Time), "%d/%m/%Y %H:%M:%S")) %>%
  
  mutate(Date = as.Date(Date, "%d/%m/%Y")) %>%
  
  filter(Date >= "2007-02-01" & Date <= "2007-02-02")

Sys.setlocale("LC_TIME", "English")

png(filename = "plot3.png", 
    width = 480,
    heigh = 480, 
    units = "px",
    bg = "white")


plot(x = tidy_hpc$Time,
     y = tidy_hpc$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     xaxt = "n")

axis(side = 1, at = c(as.numeric(tidy_hpc$Time[1]),
                      as.numeric(tidy_hpc$Time[1441]),
                      as.numeric(tidy_hpc$Time[2880])),labels = c("Thu","Fri","Sat"))


lines(x = tidy_hpc$Time,
      y = tidy_hpc$Sub_metering_2,
      type = "l",
      col = "red")
      
lines(x = tidy_hpc$Time,
      y = tidy_hpc$Sub_metering_3,
      type = "l",
      col = "blue")
      
legend (x = "topright",
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        lty = 1,
        lwd = 2.5,
        col = c("black", "red", "blue"))
      
dev.off()





