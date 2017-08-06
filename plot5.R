library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

motorVechicleSCCs <- subset(SCC$SCC, grepl("Vehicle", SCC$Short.Name))

total_annual_emissions_motor_vehicle_sources_baltimore <- 
  NEI %>% 
  filter(fips == "24510") %>%
  filter(SCC %in% motorVechicleSCCs) %>%
  group_by(year) %>% 
  summarise(total_emissions = sum(Emissions))

png("plot5.png")

qplot(
  year, 
  total_emissions, 
  data = total_annual_emissions_motor_vehicle_sources_baltimore,
  geom=c('smooth', 'point'),
  xlab='Year',
  ylab='Emissions (tons)', 
  main = "Baltimore City: Annual PM25 Emissions, Motor Vehicle Sources") + theme(plot.title = element_text(hjust = 0.5))

dev.off()