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

png(filename = "plot2.png", 
    width = 480,
    heigh = 480, 
    units = "px",
    bg = "white")


plot(tidy_hpc$Time,
     tidy_hpc$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts",
     xaxt = "n")
 
axis(side = 1, at = c(as.numeric(tidy_hpc$Time[1]),
                      as.numeric(tidy_hpc$Time[1441]),
                      as.numeric(tidy_hpc$Time[2880])),labels = c("Thu","Fri","Sat"))


dev.off()





