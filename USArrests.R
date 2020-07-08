library(ggiraphExtra)
library(tibble)
library(maps)
library(ggplot2)


dat <- USArrests
str(USArrests)


#tibble
dat <- rownames_to_column(USArrests, var = "states")
dat$states <- tolower(dat$states)

#ggplot2
us_map <- map_data("state")
str(us_map)

ggChoropleth(dat, aes(fill=Murder, map_id=states), map=us_map, interactive = T)
