library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")

total_annual_emissions_baltimore <- 
  NEI %>% 
  filter(fips == "24510") %>%
  group_by(year) %>% 
  summarise(total_emissions = sum(Emissions))

png("plot2.png")

barplot(
  total_annual_emissions_baltimore$total_emissions, 
  names.arg = total_annual_emissions_baltimore$year, 
  main = "Baltimore City: Total PM25 Emissions (in tons)"
)

dev.off()