library(readr)
library(dplyr)
library(plotly)
library(maps)
Sys.setenv('MAPBOX_TOKEN' = 'pk.eyJ1IjoieXVuaGV1bXNlb2wiLCJhIjoiY2phNXp4NGlyYWcxZTJxcGFjNXBybnlsZSJ9.tGb-MkXyN4R1Ee-iqVi8jQ')
citibike_sep14 <- read_csv("~/Documents/Data_Science/Transportation/NYC_Bike_Data/CitiBike Data - Bike Sharing/2014 CitiBike Trips/2014 CitiBike Trips/201409-citibike-tripdata.csv", 
                                            col_types = cols(starttime = col_datetime(format = "%m/%d/%Y %H:%M:%S"), 
                                                             stoptime = col_datetime(format = "%m/%d/%Y %H:%M:%S")))

trip <- select(citibike_sep14, starttime, `start station longitude`,`start station latitude`)
trip <- mutate(trip, timehourly = cut(trip$starttime, breaks = "1 hour"))
trip <- select(trip, timehourly, `start station longitude`, `start station latitude`)
write.csv(trip, file = 'CITIBIKE_RAW')
p <-trip %>%
  plot_mapbox(lat = ~`start station latitude`, lon = ~`start station longitude`, frame = ~timehourly) %>%
  layout(title = 'CitiBike trips per hour - New York City - Sep 2014',
         font = list(color='white'),
         plot_bgcolor = '#191A1A', paper_bgcolor = '#191A1A',
         mapbox = list(style = 'dark'),
         legend = list(orientation = 'h',
                       font = list(size = 8)),
         margin = list(l = 20, r = 2,
                       b = 20, t = 20,
                       pad = 2))
htmlwidgets::saveWidget(as_widget(p),"map2.html")
