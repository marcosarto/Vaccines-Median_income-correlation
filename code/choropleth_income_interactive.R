tm_shape(map_and_data)+
  tm_polygons("Income", id="STATE_NAME", palette="Blues")

tmap_mode("view")
tmap_last()
interactive_map <- tmap_last()
tmap_save(interactive_map,"Median_income_interactive.html")