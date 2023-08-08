McCormick Place light scores
================
Sara Altman, Bill Behrman
2023-08-08

- <a href="#summary" id="toc-summary">Summary</a>
- <a href="#1d-eda" id="toc-1d-eda">1D EDA</a>
- <a href="#2d-eda" id="toc-2d-eda">2D EDA</a>

``` r
# Packages
library(tidyverse)

# Parameters
file_data <- here::here("data/light_mp.rds")

#===============================================================================

# Read in data
light_mp <- read_rds(file_data)
```

## Summary

``` r
light_mp |> 
  summary()
```

    ##       date             light_score   
    ##  Min.   :2000-03-06   Min.   : 3.00  
    ##  1st Qu.:2004-11-21   1st Qu.: 4.00  
    ##  Median :2009-09-04   Median :11.00  
    ##  Mean   :2009-07-18   Mean   :10.38  
    ##  3rd Qu.:2013-11-07   3rd Qu.:15.00  
    ##  Max.   :2018-05-26   Max.   :17.00

The light score is the “proportion of the 17 window bays that were
illuminated” [^1]. The recordings all happened before dawn.

``` r
light_mp |> 
  count(light_score, sort = TRUE)
```

    ## # A tibble: 15 × 2
    ##    light_score     n
    ##          <dbl> <int>
    ##  1          17   553
    ##  2           4   474
    ##  3          14   377
    ##  4           3   304
    ##  5          15   201
    ##  6          16   173
    ##  7           6   163
    ##  8           7   149
    ##  9           5   128
    ## 10          11   121
    ## 11          12   116
    ## 12           9    98
    ## 13          13    91
    ## 14          10    73
    ## 15           8    41

``` r
light_mp |> 
  count(date, sort = TRUE)
```

    ## # A tibble: 3,062 × 2
    ##    date           n
    ##    <date>     <int>
    ##  1 2000-03-06     1
    ##  2 2000-03-08     1
    ##  3 2000-03-10     1
    ##  4 2000-03-31     1
    ##  5 2000-04-02     1
    ##  6 2000-04-14     1
    ##  7 2000-04-15     1
    ##  8 2000-04-30     1
    ##  9 2000-05-01     1
    ## 10 2000-05-03     1
    ## # ℹ 3,052 more rows

## 1D EDA

``` r
light_mp |> 
  ggplot(aes(light_score)) +
  geom_histogram(binwidth = 1, center = 0)
```

![](light_mp_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

Light tends to be either very low or very high.

``` r
light_mp |> 
  ggplot(aes(date)) +
  geom_histogram(binwidth = 365)
```

![](light_mp_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

Data was collected pretty evenly across time.

## 2D EDA

``` r
light_mp |> 
  ggplot(aes(date, light_score)) +
  geom_col()
```

![](light_mp_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

``` r
light_mp |> 
  filter(year(date) > 2013) |> 
  ggplot(aes(date, light_score)) +
  geom_col()
```

![](light_mp_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

``` r
light_mp |> 
  mutate(month = month(date, label = TRUE)) |> 
  ggplot(aes(month)) +
  geom_bar()
```

![](light_mp_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

The researchers only measured the light of McCormick Place during bird
migration periods, which occur in the spring and autumn.

``` r
light_mp |> 
  group_by(year = year(date)) |> 
  summarize(light_mean = mean(light_score)) |> 
  ggplot(aes(year, light_mean)) +
  geom_line() +
  scale_x_continuous(breaks = seq(2000, 2018, 1))
```

![](light_mp_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

``` r
light_mp |> 
  group_by(month = month(date, label = TRUE)) |> 
  summarize(light_mean = mean(light_score)) |> 
  ggplot(aes(month, light_mean)) +
  geom_col() 
```

![](light_mp_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->

[^1]: Winger BM, Weeks BC, Farnsworth A, Jones AW, Hennen M, Willard DE.
    Nocturnal flight-calling behaviour predicts vulnerability to
    artificial light in migratory birds. 286. Proceedings of the Royal
    Society B: Biological Sciences.
    <http://doi.org/10.1098/rspb.2019.0364>.
