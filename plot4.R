# read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# loading dplyr package

library(dplyr)

# Merging NEI and SCC tables

mergedData <- merge(NEI, SCC, by = "SCC")

# add column that shows whether coal combustion-related sources exists in this row or not

mergedData <-
    mutate(mergedData,
           coal = grepl("coal", mergedData$Short.Name, ignore.case = TRUE))

# Filteration on coal then selecting the only wanted columns then factorize by year
# and after that summarize sum of emissions per year

emissionCoal <-
    mergedData  %>% filter(coal == TRUE) %>% select(c(Emissions, year)) %>% group_by(year) %>% summarize(sumYear = sum(Emissions))

# Launch png graphic device

png("plot4.png")

# Plotting Total Emissions per Year

barplot(
    emissionCoal$sumYear,
    names.arg = emissionCoal$year,
    xlab = "Year",
    ylab = "Total Emissions",
    main = "Total Emissions per Year from coal combustion-related sources",
    col = "green"
)

# close png graphic device

dev.off()