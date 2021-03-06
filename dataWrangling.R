library(tidyverse)
library(lubridate)
library(stringr)

# Read in dataset
ssa <- read_csv("http://594442.youcanlearnit.net/ssadisability.csv")
glimpse(ssa)

# Convert dataset from wide to long
ssa_long <- gather(ssa, month, applications, -Fiscal_Year)
print(ssa_long, n = 20)

# Format dates in dataset
unique(ssa_long$month)

ssa_long <- separate(ssa_long, month, c("month", "application_method"), sep="_")
print(ssa_long, n = 20)
unique(ssa_long$month)

ssa_long$month <- substr(ssa_long$month, 1, 3)
unique(ssa_long$month)

unique(ssa_long$Fiscal_Year)

ssa_long$Fiscal_Year <- str_replace(ssa_long$Fiscal_Year, "FY", "20")
unique(ssa_long$Fiscal_Year)

ssa_long$Date <- dmy(paste('01', ssa_long$month, ssa_long$Fiscal_Year))
unique(ssa_long$Date)

# Handle fiscal years in dataset
advanced_date <- which(month(ssa_long$Date) >= 10)

year(ssa_long$Date[advanced_date]) <- year(ssa_long$Date[advanced_date]) - 1

# Widen dataset
summary(ssa_long)

ssa_long$Fiscal_Year <- NULL
ssa_long$month <- NULL

ssa_long$application_method <- as.factor(ssa_long$application_method)
summary(ssa_long)

ssa <- spread(ssa_long, application_method, applications)
print(ssa, n = 20)

# Visualize dataset
ssa$online_percentage <- ssa$Internet / ssa$Total * 100

ggplot(data = ssa, mapping = aes(x = Date, y = online_percentage)) +
  geom_point()
