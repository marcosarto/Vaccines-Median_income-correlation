library(ggplot2)
library(dplyr)
library(maps)
US <- map_data("world") %>% filter(region=="USA")
ggplot() +
  geom_polygon(data = US, aes(x=long, y = lat, group = group, fill=))+
  geom_point( data=income_coords, aes(x=longitude, y=latitude, size=Income))+
  theme_void() + xlim(-160,-50)+ ylim(10,60) + coord_map()
ggplot() +
  geom_polygon(data = spdf_fortified, aes(fill = nb_equip, x = long, y = lat, group = group)) +
  theme_void() +
  coord_map()