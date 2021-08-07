library(ggplot2)
library(sf)
library(tmap)
library(tmaptools)
library(leaflet)
library(dplyr)

map <- st_read("shapefile/USA_States_Generalized.shp")
