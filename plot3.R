# read the data
NEI <- readRDS("summarySCC_PM25.rds")

# loading dplyr & ggplot2 packages

library(dplyr)
library(ggplot2)

# Filteration on Baltimore then selecting the only wanted columns then factorize by year and type
# and after that summarize sum of emissions per year

emissionBaltimore <-
    NEI  %>% filter(fips == "24510") %>% group_by(year, type) %>% summarize(sumYear = sum(Emissions))

# Launch png graphic device

png("plot3.png")

# Plotting Total Emissions per Year

qplot(
    as.character(year),
    data = emissionBaltimore,
    facets = . ~ type,
    geom = "bar",
    weight = sumYear,
    main = "Total Emissions per Year for Baltimore City",
    xlab = "Year",
    ylab = "Total Emissions",
    fill = type
)

# close png graphic device

dev.off()