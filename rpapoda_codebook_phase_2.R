## ------------------------------------------------------------------------
sessionInfo()

## ----load necessary packages---------------------------------------------
library(tidyverse)
library(lubridate)
library(knitr)

## ----import dataset------------------------------------------------------
ks <- read_csv("kickstarter_data.csv")

## ----converting dates----------------------------------------------------
ks$created_at <- as.POSIXct(as.numeric(ks$created_at), origin = '1970-01-01', tz = 'GMT')


ks$deadline <- as.POSIXct(as.numeric(ks$deadline), origin = '1970-01-01', tz = 'GMT')

ks$state_changed_at <- as.POSIXct(as.numeric(ks$state_changed_at), origin = '1970-01-01', tz = 'GMT')

ks$launched_at <- as.POSIXct(as.numeric(ks$launched_at), origin = '1970-01-01', tz = 'GMT')


