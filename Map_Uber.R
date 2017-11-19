library(readr)
library(dplyr)
library(plotly)
library(maps)
Sys.setenv('MAPBOX_TOKEN' = 'pk.eyJ1IjoieXVuaGV1bXNlb2wiLCJhIjoiY2phNXp4NGlyYWcxZTJxcGFjNXBybnlsZSJ9.tGb-MkXyN4R1Ee-iqVi8jQ')
uberRaw_sep14 <- read_csv("~/Documents/Data_Science/Transportation/NYC_Uber-Taxi_Data/NYC_Uber-2014/uber-raw-data-sep14.csv", 
                          col_types = cols(`Date/Time` = col_datetime(format = "%m/%d/%Y %H:%M:%S")))

trip <- select(uberRaw_sep14, `Date/Time`, Lon, Lat)
trip <- mutate(trip, timehourly = cut(trip$`Date/Time`, breaks = "1 hour"))
trip <- select(trip, timehourly, Lon, Lat)
write.csv(trip, file = 'UBER_RAW')
p <-trip %>%
  plot_mapbox(lat = ~Lat, lon = ~Lon, frame = ~timehourly) %>%
  layout(title = 'Active Uber Drivers in New York City per hour - Sep 2014',
         font = list(color='white'),
         plot_bgcolor = '#191A1A', paper_bgcolor = '#191A1A',
         mapbox = list(style = 'dark'),
         legend = list(orientation = 'h',
                       font = list(size = 8)),
         margin = list(l = 20, r = 20,
                       b = 20, t = 20,
                       pad = 2))
htmlwidgets::saveWidget(as_widget(p),"map.html")

