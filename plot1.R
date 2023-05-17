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
  mutate(Time = strptime(paste(Date, " ", Time), "%d/%m/%Y %H:%M:%S")) %>%
  mutate(Date = as.Date(Date, "%d/%m/%Y")) %>%
  filter(Date >= "2007-02-01" & Date <= "2007-02-02") 


png(filename = "plot1.png",
    width = 480,
    heigh = 480,
    units = "px",
    bg = "white")

hist(x = tidy_hpc$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power(kilowatts)")

dev.off()
