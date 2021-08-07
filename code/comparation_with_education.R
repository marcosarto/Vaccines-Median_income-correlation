#education$Percent.of.adults.with.less.than.a.high.school.diploma..2015.19 <- na.omit(education) 
#education$Percent.of.adults.with.less.than.a.high.school.diploma..2015.19 <- (education$Percent.of.adults.with.less.than.a.high.school.diploma..2015.19  - min(education$Percent.of.adults.with.less.than.a.high.school.diploma..2015.19 )) / (max(education$Percent.of.adults.with.less.than.a.high.school.diploma..2015.19 ) - min(education$Percent.of.adults.with.less.than.a.high.school.diploma..2015.19 ))
ratioeduvac <- inner_join(a,education)
library(tidyr)
library(ggplot2)
ratioeduvac$total_vaccinations_per_hundred <- ratioeduvac$total_vaccinations_per_hundred*80
ratioeduvac$Percent.of.adults.with.a.high.school.diploma.only..2015.19<-ratioeduvac$Percent.of.adults.with.a.high.school.diploma.only..2015.19*2
ratioeduvac$Percent.of.adults.completing.some.college.or.associate.s.degree..2015.19<-ratioeduvac$Percent.of.adults.completing.some.college.or.associate.s.degree..2015.19*5
ratioeduvac$Percent.of.adults.with.a.bachelor.s.degree.or.higher..2015.19<-ratioeduvac$Percent.of.adults.with.a.bachelor.s.degree.or.higher..2015.19*10
ratioeduvac$valEdu <-ratioeduvac$Percent.of.adults.with.a.high.school.diploma.only..2015.19+ratioeduvac$Percent.of.adults.completing.some.college.or.associate.s.degree..2015.19+ratioeduvac$Percent.of.adults.with.a.bachelor.s.degree.or.higher..2015.19

#somma solo di laureati o poco meno. Vedere correlazione


df2 <- tidyr::pivot_longer(ratioeduvac, cols=c('percent_democrat', 'total_vaccinations_per_hundred'), names_to='variable', 
                           values_to="value")
ggplot(df2, aes(x=value, y=reorder(STATE_NAME,value), fill=variable)) +
  geom_bar(stat='identity', position='dodge')
