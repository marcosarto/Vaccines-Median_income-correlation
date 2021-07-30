tm_shape(map_and_data)+
  tm_polygons("Income", id="STATE_NAME", palette="Blues")

tmap_mode("view")
