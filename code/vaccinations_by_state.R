#DIFFERENZE DOMANDA OFFERTA
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

#DIFFERENZE TRA DOMANDA OFFERTA
#POSSO USARE DIRETTAMENTE LE RISERVE DEGLI STATI UNITI AL COMPLETO
US <- na.omit(filter(vaccinations,location=='United States'))
US$date = as.Date(US$date, format =  "%Y-%m-%d")
ggplot(US, aes(x=date)) + 
  geom_line(aes(y = total_vaccinations), color = "darkred") + 
  geom_line(aes(y = total_distributed), color="steelblue")

US$diff = US$total_distributed-US$total_vaccinations
ggplot(US, aes(x = date, y = diff)) + geom_bar(stat = "identity", space=3)

#Vedo ora i ratei di vaccinazione
states <- c('Alabama', 'Alaska', 'American Samoa', 'Arizona', 'Arkansas',
            'California', 'Colorado', 'Connecticut', 'Delaware', 
            'District of Columbia', 'Florida', 'Georgia', 'Guam', 'Hawaii', 
            'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 
            'Louisiana', 'Maine', 'Maryland', 'Massachusetts', 'Michigan', 
            'Minnesota', 'Minor Outlying Islands', 'Mississippi', 'Missouri', 
            'Montana', 'Nebraska', 'Nevada', 'New Hampshire', 'New Jersey', 
            'New Mexico', 'New York', 'North Carolina', 'North Dakota', 
            'Northern Mariana Islands', 'Ohio', 'Oklahoma', 'Oregon', 
            'Pennsylvania', 'Puerto Rico', 'Rhode Island', 'South Carolina', 
            'South Dakota', 'Tennessee', 'Texas', 'U.S. Virgin Islands', 'Utah', 
            'Vermont', 'Virginia', 'Washington', 'West Virginia', 'Wisconsin', 
            'Wyoming')

for (value in states) {
  t1 <- filter(vaccinations,location==value,date=='2021-07-28')
  t2 <- filter(vaccinations,location==value,date=='2021-07-29')
  t3 <- filter(vaccinations,location==value,date=='2021-07-21')
  if(is.null(t1)){t1 = t2}
  if(is.null(t1)){t1=t3}
  cat("\n",value, t1$total_vaccinations_per_hundred)
}

ggplot(filter(vaccinations,date=='2021-07-28'), aes(x = total_vaccinations_per_hundred, y = reorder(location, total_vaccinations_per_hundred))) + geom_bar(stat = "identity")


vaccinations$STATE_NAME=vaccinations$location

#Interactive map
map_and_data = inner_join(map,filter(vaccinations,date=='2021-07-28'))
tm_shape(map_and_data)+
  tm_polygons("total_vaccinations_per_hundred", id="STATE_NAME", palette="Greens")

tmap_mode("view")
tmap_last()
interactive_map <- tmap_last()
tmap_save(interactive_map,"Vaccination_per_hundred.html")

#Barplot income ratio
income_coords$Income <- (income_coords$Income - min(income_coords$Income)) / (max(income_coords$Income) - min(income_coords$Income))
ggplot(income_coords, aes(x = Income, y = reorder(STATE_NAME, Income))) + geom_bar(stat = "identity")

#Doppio barplot con i ratios
a <- filter(vaccinations,date=='2021-07-28')
income_coords$Income <- (income_coords$Income - min(income_coords$Income)) / (max(income_coords$Income) - min(income_coords$Income))
b <- income_coords
a <- select(a,STATE_NAME,total_vaccinations_per_hundred)
a <- na.omit(a) 
a$total_vaccinations_per_hundred <- (a$total_vaccinations_per_hundred - min(a$total_vaccinations_per_hundred)) / (max(a$total_vaccinations_per_hundred) - min(a$total_vaccinations_per_hundred))
b<-select(b,STATE_NAME,Income)
ratios <- merge(a,b)
library(tidyr)
df2 <- tidyr::pivot_longer(ratios, cols=c('Income', 'total_vaccinations_per_hundred'), names_to='variable', 
                           values_to="value")
ggplot(df2, aes(x=value, y=reorder(STATE_NAME,value), fill=variable)) +
  geom_bar(stat='identity', position='dodge')



