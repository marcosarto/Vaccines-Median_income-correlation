library(dplyr)


#median income per household
income <- read.csv(file = 'dataset/Median Household Income in the United States.csv')
coords <- read.csv(file = 'dataset/us-state-capitals.csv')
income_coords <- merge(income, coords, by = "STATE_NAME")
remove(coords)
remove(income)



#vaccines
vaccinations <- read.csv(file = "dataset/us_state_vaccinations.csv")
vaccinations <- select(vaccinations, -people_fully_vaccinated_per_hundred)
#vaccinations <- select(vaccinations, -total_vaccinations_per_hundred)
vaccinations <- select(vaccinations, -share_doses_used)
vaccinations <- select(vaccinations, -daily_vaccinations_per_million)
#vaccinations <- select(vaccinations, -daily_vaccinations)
vaccinations <- select(vaccinations, -daily_vaccinations_raw)
vaccinations <- select(vaccinations, -distributed_per_hundred)
vaccinations <- select(vaccinations, -people_vaccinated_per_hundred)
vaccinations <- vaccinations[!(vaccinations$location=="Veterans Health" | vaccinations$location=="Long Term Care"
                               |vaccinations$location=="Dept of Defense" | vaccinations$location== "Bureau of Prisons" 
                               | vaccinations$location=="Republic of Palau" | vaccinations$location=="	
                                Federated States of Micronesia" | vaccinations$location=="	
                                Indian Health Svc"),]

#education by state
education <- read.csv(file = 'dataset/Education.csv')
education <- select(education, STATE_NAME,Percent.of.adults.with.less.than.a.high.school.diploma..2015.19,
                    Percent.of.adults.with.a.high.school.diploma.only..2015.19,
                    Percent.of.adults.with.a.bachelor.s.degree.or.higher..2015.19,
                    Percent.of.adults.completing.some.college.or.associate.s.degree..2015.19)

#political leaning by state 2020
political <- read.csv(file = 'dataset/political2020.csv')
