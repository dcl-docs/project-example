# Reads in and writes out species data on bird collisions

# Source: Winger BM, Weeks BC, Farnsworth A, Jones AW, Hennen M, Willard DE (2019) 
#         Data from: Nocturnal flight-calling behaviour predicts vulnerability to 
#         artificial light in migratory birds. Dryad Digital Repository. 
#         https://doi.org/10.5061/dryad.8rr0498

# Author: Sara Altman
# Version: 2019-05-07

# Packages
library(tidyverse)

# Parameters
  # Input file
file_raw <- here::here("data-raw/collisions.csv")
  # Specifies how to recode locations 
locations_recode <- 
  c(
    "MP"  = "McCormick Place",
    "CHI" = "Chicago area"
  )
  # Some of the bird names were recorded with outdated genus information
genus_recode <-
  c(
    "Ammodramus Nelsoni"   = "Ammospiza",
    "Ammodramus Leconteii" = "Ammospiza",
    "Ammodramus Henslowii" = "Centronyx"
  )
  # Output file
file_out <- here::here("data/collisions.rds")

#===============================================================================

file_raw %>% 
  read_csv(
    col_types = 
      cols(
        Genus = col_character(), 
        Species = col_character(),
        Date = col_date(),
        Locality = col_character()
      )
  ) %>% 
  rename_all(str_to_lower) %>% 
  mutate_at(vars(genus, species), str_to_title) %>% 
  mutate(locality = recode(locality, !!! locations_recode)) %>% 
  mutate(
    genus = 
      if_else(
        str_glue("{genus} {species}") %in% names(genus_recode),
        genus_recode[str_glue("{genus} {species}")] %>% unname(),
        genus
      )
    ) %>% 
  write_rds(file_out)
