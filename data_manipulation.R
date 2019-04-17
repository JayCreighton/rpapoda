# This file will take care of the steps to pare down through a random sample the 
# original kickstarter data.

# Combining the files 
# If re-running this, the previously created csv file must be deleted or moved
# library(tidyverse)
# files <- list.files(pattern = "*.csv")
# kickstarter <- files %>%
#     map(read_csv) %>%
#     bind_rows() 

# Take a random sample of 500 observations
# The seed was 97 to start with
set.seed(97)
kickstarter_data <- sample_n(kickstarter, 519)
# dim(kickstarter_data)

# Creating a backup 
# write_csv(ks, "kickstarter_data2.csv")


# Write data to a new csv
write_csv(kickstarter_data, "kickstarter_data.csv")

# Remove currency_symbol if it messes things up
kickstarter_data <- kickstarter_data %>% 
    dplyr::select(-currency_symbol)

# Getting rid of a few outliers 
ks <- ks %>% 
    filter(pledged < 200000)
ks <- ks %>% 
    filter(goal < 150000)

# Trimming some character strings
library(stringr)
extract_category <- function(string) {
    output <- vector("character", length(string))
    start <- '"name":"'
    end <- '"id"'
    for (i in seq_along(string)) {
        loc_start <- str_locate(string[[i]], start) 
        loc_end <- str_locate(string[[i]], end)
        output[[i]] <- str_sub(string[[i]], 
                               (loc_start[1,1] + 8), 
                               (loc_end[1,1] - 3)
        )
    }
    output
}
ks$category <- extract_category(ks$category)
ks$creator <- extract_category(ks$creator)

# Looks like location needs a different function
extract_location <- function(string) {
    output <- vector("character", length(string))
    start <- '"displayable_name":"'
    end <- '"short_name"'
    for (i in seq_along(string)) {
        loc_start <- str_locate(string[[i]], start) 
        loc_end <- str_locate(string[[i]], end)
        output[[i]] <- str_sub(string[[i]], 
                               (loc_start[1,1] + 20), 
                               (loc_end[1,1] - 3)
        )
    }
    output
}
ks$location <- extract_location(ks$location)

ks2 <- ks

# Rewriting with the new changes
write_csv(ks, "kickstarter_data.csv")

