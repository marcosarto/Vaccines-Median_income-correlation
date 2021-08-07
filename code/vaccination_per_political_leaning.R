map_and_data <- inner_join(map,political)

tm_shape(map_and_data)+
  tm_polygons("percent_democrat", id="STATE_NAME", palette="Blues")

tmap_mode("view")
tmap_last()
interactive_map <- tmap_last()
tmap_save(interactive_map,"Democrat_leaning_interactive.html")

political$percent_democrat <- political$percent_democrat/100

valPoli <- inner_join(a,political)

df2 <- tidyr::pivot_longer(valPoli, cols=c('percent_democrat', 'total_vaccinations_per_hundred'), names_to='variable', 
                           values_to="value")
ggplot(df2, aes(x=value, y=reorder(STATE_NAME,value), fill=variable)) +
  geom_bar(stat='identity', position='dodge')
