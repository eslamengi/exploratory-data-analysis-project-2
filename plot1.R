# read the data 
NEI <- readRDS("summarySCC_PM25.rds")

# loading dplyr package

library(dplyr)

# selecting the only wanted columns then factorize by year and after that summarize sum of emissions per year

emission <-
    NEI  %>% select(c(Emissions, year)) %>% group_by(year) %>% summarize(sumYear = sum(Emissions))

# Launch png graphic device

png("plot1.png")

# Plotting Total Emissions per Year

barplot(
    emission$sumYear,
    names.arg = emission$year,
    xlab = "Year",
    ylab = "Total Emissions",
    main = "Total Emissions per Year",
    col = "green"
)

# close png graphic device

dev.off()
