library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Comb = Combustion
coalSCCs <- subset(SCC$SCC, grepl("Fuel Comb.*Coal", SCC$EI.Sector))

total_annual_emissions_coal_sources <- 
  NEI %>% 
  filter(SCC %in% coalSCCs) %>%
  group_by(year) %>% 
  summarise(total_emissions = sum(Emissions))

png("plot4.png")

qplot(
  year, 
  total_emissions, 
  data = total_annual_emissions_coal_sources,
  geom=c('smooth', 'point'),
  xlab='Year',
  ylab='Emissions (tons)', 
  main = "Annual PM25 Emissions, Coal Sources") + theme(plot.title = element_text(hjust = 0.5))

dev.off()