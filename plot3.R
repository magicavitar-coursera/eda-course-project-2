library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

total_annual_emissions_baltimore <- 
  NEI %>% 
  filter(fips == "24510") %>%
  group_by(type, year) %>% 
  summarise(total_emissions = sum(Emissions))

png("plot3.png")

qplot(
  year, 
  total_emissions, 
  data = total_annual_emissions_baltimore,
  facets = .~type,
  geom='smooth',
  xlab='Year',
  ylab='Emissions (tons)', 
  main = "Baltimore City: Annual Emissions By Source") + theme(plot.title = element_text(hjust = 0.5))

dev.off()