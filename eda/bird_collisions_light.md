Bird collisions + light scores
================
Sara Altman, Bill Behrman
2023-08-08

- <a href="#summary" id="toc-summary">Summary</a>
- <a href="#collisions-over-time-by-flight-call"
  id="toc-collisions-over-time-by-flight-call">Collisions over time by
  flight call</a>
- <a href="#collisions-by-light-score"
  id="toc-collisions-by-light-score">Collisions by light score</a>

``` r
# Packages
library(tidyverse)

# Parameters
file_data <- here::here("data/bird_collisions_light.rds")

#===============================================================================

# Read in data
df <- read_rds(file_data)

mccormick_place <- 
  df |> 
  filter(locality == "McCormick Place")
```

## Summary

``` r
df |> 
  summary()
```

    ##     genus             species               date              locality        
    ##  Length:69784       Length:69784       Min.   :1978-09-15   Length:69784      
    ##  Class :character   Class :character   1st Qu.:1992-10-11   Class :character  
    ##  Mode  :character   Mode  :character   Median :2006-09-06   Mode  :character  
    ##                                        Mean   :2002-05-24                     
    ##                                        3rd Qu.:2011-10-14                     
    ##                                        Max.   :2016-11-30                     
    ##                                                                               
    ##     family          flight_call          habitat            stratum         
    ##  Length:69784       Length:69784       Length:69784       Length:69784      
    ##  Class :character   Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
    ##                                                                             
    ##                                                                             
    ##                                                                             
    ##                                                                             
    ##   light_score   
    ##  Min.   : 3.00  
    ##  1st Qu.: 5.00  
    ##  Median :12.00  
    ##  Mean   :10.97  
    ##  3rd Qu.:16.00  
    ##  Max.   :17.00  
    ##  NA's   :28887

## Collisions over time by flight call

``` r
df |> 
  count(year_month = floor_date(date, unit = "month"), flight_call) |> 
  ggplot(aes(year_month, n, color = flight_call)) +
  geom_line()
```

![](bird_collisions_light_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

``` r
df |> 
  count(year = floor_date(date, unit = "year"), flight_call) |> 
  ggplot(aes(year, n, color = flight_call)) +
  geom_line()
```

![](bird_collisions_light_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

## Collisions by light score

``` r
mccormick_place |> 
  drop_na(light_score) |> 
  count(light_score, flight_call) |> 
  ggplot(aes(light_score, n, color = flight_call)) +
  geom_point() +
  geom_line() 
```

![](bird_collisions_light_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

Birds with a flight call appear more affected by light.

``` r
mccormick_place |> 
  drop_na(light_score) |>  
  count(light_score, habitat) |> 
  ggplot(aes(light_score, n, color = habitat)) +
  geom_point() +
  geom_line() 
```

![](bird_collisions_light_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

Birds across the three habitats have similar responses to light.

``` r
mccormick_place |> 
  drop_na(light_score) |>  
  count(light_score, stratum) |> 
  ggplot(aes(light_score, n, color = stratum)) +
  geom_point() +
  geom_line() 
```

![](bird_collisions_light_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->
