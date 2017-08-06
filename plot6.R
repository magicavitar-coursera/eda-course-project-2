library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

motorVechicleSCCs <- subset(SCC$SCC, grepl("Vehicle", SCC$Short.Name))

total_annual_emissions_motor_vehicle_sources_baltimore_and_la <- 
  NEI %>% 
  filter(fips == "24510" | fips == "06037") %>%
  filter(SCC %in% motorVechicleSCCs) %>%
  group_by(fips, year) %>% 
  summarise(total_emissions = sum(Emissions))

total_annual_emissions_motor_vehicle_sources_baltimore_and_la$city <- factor(total_annual_emissions_motor_vehicle_sources_baltimore_and_la$fips,levels = c("24510","06037"), labels = c("Baltimore", "Los Angeles"))

png("plot6.png")

qplot(
  year, 
  total_emissions, 
  data = total_annual_emissions_motor_vehicle_sources_baltimore_and_la,
  geom=c('smooth', 'point'),
  facets = .~city,
  xlab='Year',
  ylab='Emissions (tons)', 
  main = "Baltimore City vs. Los Angeles: \nAnnual PM25 Emissions, Motor Vehicle Sources") + theme(plot.title = element_text(hjust = 0.5))

dev.off()