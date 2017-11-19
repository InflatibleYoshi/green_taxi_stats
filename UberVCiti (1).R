library(readr)
library(dplyr)

#Reading Uber Date
uberraw_sep14 <- read_csv("~/Documents/Data_Science/Transportation/NYC_Uber-Taxi_Data/NYC_Uber-2014/uber-raw-data-sep14.csv", 
                                col_types = cols(`Date/Time` = col_datetime(format = "%m/%d/%Y %H:%M:%S")))

#Extracting date/time
UberDate <- uberraw_sep14$`Date/Time`
#Partitioning date/time by day
UberDateTable <- table(cut(UberDate, breaks="day"))
#Turning it into a dataframe
data.frame(UberDateTable)
#Plot it
plot(UberDateTable, type="l", xlab="Date", ylab="The number of Uber requests")
UberHourTable <- table(cut(UberDate, breaks="hour"))
data.frame(UberHourTable)
plot(UberHourTable, type="l", xlab="Date", ylab="The number of Uber requests")


#Analogous code for Citibike
citibike_sep14 <- read_csv("~/Documents/Data_Science/Transportation/NYC_Bike_Data/CitiBike Data - Bike Sharing/2014 CitiBike Trips/2014 CitiBike Trips/201409-citibike-tripdata.csv", 
                                      col_types = cols(starttime = col_datetime(format = "%m/%d/%Y %H:%M:%S"), 
                                                       stoptime = col_datetime(format = "%m/%d/%Y %H:%M:%S")))
CitiBikeDate <- citibike_sep14$starttime
CitiBikeDateTable <- table(cut(CitiBikeDate, breaks="day"))
data.frame(CitiBikeDateTable)
plot(CitiBikeDateTable, type="l", xlab="Date", ylab ="Trips")
CitiBikeHourTable <- table(cut(CitiBikeDate, breaks="hour"))
data.frame(CitiBikeHourTable)
plot(CitiHourTable, type="l", xlab="Date", ylab="The number of CitiBike trips")
