library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")

total_annual_emissions_in_millions <- 
    NEI %>% 
    group_by(year) %>% 
    summarise(total_emissions = sum(Emissions) / 10^6)

png("plot1.png")

barplot(
  total_annual_emissions_in_millions$total_emissions, 
  names.arg = total_annual_emissions_in_millions$year, 
  main = "Total PM25 Emissions (in millions of tons)"
)

dev.off()