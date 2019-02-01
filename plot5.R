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

emissionVehicle <-
    mergedData  %>% filter(vehicle == TRUE & fips == "24510") %>% select(c(Emissions, year)) %>% group_by(year) %>% summarize(sumYear = sum(Emissions))

# Launch png graphic device

png("plot5.png")

# Plotting Total Emissions per Year

barplot(
    emissionVehicle$sumYear,
    names.arg = emissionVehicle$year,
    xlab = "Year",
    ylab = "Total Emissions",
    main = "Total Emissions per Year from vehicle sources",
    col = "blue"
)

# close png graphic device

dev.off()