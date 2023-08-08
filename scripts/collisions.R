# Transforms species data on bird collisions

# Source: 
# Winger BM, Weeks BC, Farnsworth A, Jones AW, Hennen M, Willard DE (2019) 
# Data from: Nocturnal flight-calling behavior predicts vulnerability to 
# artificial light in migratory birds. Dryad Digital Repository. 
# https://doi.org/10.5061/dryad.8rr0498

# Authors: Sara Altman, Bill Behrman
# Version: 2023-08-08

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
  quos(
    genus == "Ammodramus" & species %in% c("Nelsoni", "Leconteii") ~
      "Ammospiza",
    genus == "Ammodramus" & species == "Henslowii" ~ "Centronyx",
    .default = genus
  )
  # Output file
file_out <- here::here("data/collisions.rds")

#===============================================================================

file_raw |> 
  read_csv(
    col_types = 
      cols(
        Genus = col_character(), 
        Species = col_character(),
        Date = col_date(),
        Locality = col_character()
      )
  ) |> 
  rename_with(str_to_lower) |> 
  mutate(
    across(c(genus, species), str_to_title), 
    locality = recode(locality, !!! locations_recode),
    genus = case_when(!!! genus_recode)
  ) |> 
  write_rds(file_out)
