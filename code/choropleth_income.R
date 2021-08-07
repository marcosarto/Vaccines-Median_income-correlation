map_and_data <- inner_join(map,income_coords)

ggplot(map_and_data)+
  geom_sf(aes(fill=Income))+
  scale_fill_gradient(low="#56b1f7", high="#132b43")
