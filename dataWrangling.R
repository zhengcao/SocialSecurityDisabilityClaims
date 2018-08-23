library(tidyverse)
library(lubridate)
library(stringr)

# Read in dataset
ssa <- read_csv("http://594442.youcanlearnit.net/ssadisability.csv")
glimpse(ssa)

# Convert dataset from wide to long
ssa_long <- gather(ssa, month, applications, -Fiscal_Year)
print(ssa_long, n = 20)