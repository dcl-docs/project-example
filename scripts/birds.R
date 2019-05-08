# Reads in and writes out species data on birds

# Source: https://royalsocietypublishing.org/action/downloadSupplement?doi=10.1098%2Frspb.2019.0364&file=rspb20190364supp1.pdf

# Author: Sara Altman
# Version: 2019-05-01

# Libraries
library(tidyverse)

# Parameters
  # Input file
file_raw <- here::here("data-raw/birds.txt")
  # Actual column names are incorrect
column_names <- 
  c(
    "genus", 
    "species", 
    "family", 
    "num_collisions", 
    "flight_call", 
    "habitat", 
    "stratum"
  )
  # Output file
file_out <- here::here("data/birds.rds")

#===============================================================================

file_raw %>% 
  read_delim(
    delim = " ", 
    skip = 1, 
    col_names = column_names,
    col_types = 
      cols(
        genus = col_character(),
        species = col_character(),
        family = col_character(),
        num_collisions = col_double(),
        flight_call = col_character(),
        habitat = col_character(),
        stratum = col_character()
      )
  )  %>% 
  mutate_at(vars(flight_call, habitat, stratum), str_to_lower) %>% 
  mutate(
    species = str_to_title(species),
    stratum = str_remove_all(stratum, "[^\\w].*$")
  ) %>% 
  select(family, genus, species, everything()) %>% 
  write_rds(file_out)
