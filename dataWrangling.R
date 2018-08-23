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

