# read the data
NEI <- readRDS("summarySCC_PM25.rds")

# loading dplyr package

library(dplyr)

# Filteration on Baltimore then selecting the only wanted columns then factorize by year 
# and after that summarize sum of emissions per year

emissionBaltimore <-
    NEI  %>% filter(fips == "24510") %>% select(c(Emissions, year)) %>% group_by(year) %>% summarize(sumYear = sum(Emissions))

# Launch png graphic device

png("plot2.png")

# Plotting Total Emissions per Year

barplot(
    emissionBaltimore$sumYear,
    names.arg = emissionBaltimore$year,
    xlab = "Year",
    ylab = "Total Emissions",
    main = "Total Emissions per Year for Baltimore City",
    col = "green"
)

# close png graphic device

dev.off()