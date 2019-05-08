# Reads in and writes out species data on light by date at McCormick Place in Chicago

# Source: Winger BM, Weeks BC, Farnsworth A, Jones AW, Hennen M, Willard DE (2019) 
#         Data from: Nocturnal flight-calling behaviour predicts vulnerability to 
#         artificial light in migratory birds. Dryad Digital Repository. 
#         https://doi.org/10.5061/dryad.8rr0498

# Author: Sara Altman
# Version: 2019-05-07

# Libraries
library(tidyverse)

# Parameters
  # Input file
file_raw <- here::here("data-raw/light_mp.csv")
  # Output file
file_out <- here::here("data/light_mp.rds")

#===============================================================================

file_raw %>% 
  read_csv(
    col_types = cols(Date = col_date(), Light_Score = col_double())
  ) %>% 
  rename_all(str_to_lower) %>% 
  write_rds(file_out)
