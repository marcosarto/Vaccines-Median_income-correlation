Alabama <- filter(vaccinations, location=="Alabama")
Alabama$date = as.Date(Alabama$date, format =  "%Y-%m-%d")

Maryland <- filter(vaccinations, location=="Maryland")
Maryland$date = as.Date(Maryland$date, format =  "%Y-%m-%d")

Washington <- filter(vaccinations, location=="Washington")
Washington$date = as.Date(Washington$date, format =  "%Y-%m-%d")

ggplot(Alabama, aes(x=date)) + 
  geom_line(aes(y = total_vaccinations), color = "darkred") + 
  geom_line(aes(y = total_distributed), color="steelblue")
ggplot(Maryland, aes(x=date)) + 
  geom_line(aes(y = total_vaccinations), color = "darkred") + 
  geom_line(aes(y = total_distributed), color="steelblue")
ggplot(Washington, aes(x=date)) + 
  geom_line(aes(y = total_vaccinations), color = "darkred") + 
  geom_line(aes(y = total_distributed), color="steelblue")

  