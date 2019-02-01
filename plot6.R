# read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# loading dplyr package

library(dplyr)

# Merging NEI and SCC tables

mergedData <- merge(NEI, SCC, by = "SCC")

# add column that shows whether vehicle sources exists in this row or not

mergedData <-
    mutate(mergedData,
           vehicle = grepl("vehicle", mergedData$Short.Name, ignore.case = TRUE))

# Filteration on vehicle in Baltimore then selecting the only wanted columns then factorize by year
# and after that summarize sum of emissions per year

emissionBal <-
    mergedData  %>% filter(vehicle == TRUE &
                               fips == "24510") %>% select(c(Emissions, year)) %>% group_by(year) %>% summarize(sumYear = sum(Emissions))

# Filteration on vehicle in Los Angeles then selecting the only wanted columns then factorize by year
# and after that summarize sum of emissions per year

emissionLA <-
    mergedData  %>% filter(vehicle == TRUE &
                               fips == "06037") %>% select(c(Emissions, year)) %>% group_by(year) %>% summarize(sumYear = sum(Emissions))


# Launch png graphic device

png("plot6.png")

# Plotting Total Emissions per Year

par(mfrow = c(1, 2))

barplot(
    emissionBal$sumYear,
    names.arg = emissionBal$year,
    xlab = "",
    ylab = "Total Emissions",
    main = "Total Emissions in Baltimore",
    col = "blue",
    ylim = c(0, 1500)
)

barplot(
    emissionLA$sumYear,
    names.arg = emissionLA$year,
    xlab = "",
    ylab = "Total Emissions",
    main = "Total Emissions in Los Angeles",
    col = "green",
    ylim = c(0, 1500)
)

# close png graphic device

dev.off()