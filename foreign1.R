library(foreign)
library(dplyr)
library(tidyverse)
library(ggplot2)
library(readxl)

raw_welfare <- read.spss(file = "C:\\Users\\mega\\Desktop\\rwork\\Doit_R_170717\\Data\\Koweps_hpc10_2015_beta1.sav", to.data.frame = T)
welfare <- raw_welfare


welfare <- rename(welfare, sex = h10_g3,
                  birth = h10_g4,
                  marriage = h10_g10,
                  religion = h10_g11,
                  income = p1002_8aq1,
                  code_job = h10_eco9,
                  code_religion = h10_reg7)

class(welfare$birth)
summary(welfare$birth)

qplot(welfare$birth)
welfare$birth <- ifelse(welfare$birth == 9999, NA, welfare$birth)
table(is.na(welfare$birth))

welfare$age <- (2020 - welfare$birth + 1)
summary(welfare$age)
qplot(welfare$age)

age_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age) %>%
  summarise(mean_income = mean(income))
age_income

ggplot(data=age_income, aes(x=age, y=mean_income)) + geom_line()


welfare <- welfare %>%
  mutate(ageg = ifelse(age<30, "young", ifelse(age<=59, "middle", "old")))
table(welfare$ageg)

ageg_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(ageg) %>%
  summarise(mean_income = mean(income))
ageg_income

ggplot(data = ageg_income, aes(x=ageg, y=mean_income)) + geom_col() + scale_x_discrete(limits = c("young","middle","old"))

#--------------------------------
class(welfare$religion)
table(as.factor(welfare$religion)) 

welfare$religion <- ifelse(welfare$religion==1, "yes", "no")
table(welfare$religion)

qplot(welfare$religion)

#----------------------------------
class(welfare$marriage)
table(welfare$marriage)

welfare$group_marriage <- ifelse(welfare$marriage == 1, "married", 
                                 ifelse(welfare$marriage == 3, "divorced", NA))
table(welfare$group_marriage)
table(is.na(welfare$group_marriage))
qplot(welfare$group_marriage)

#----------------------------------
religion_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  group_by(religion, group_marriage) %>%
  summarise(n=n()) %>%
  mutate(total = sum(n),
         percetage = round((n/total)*100,1))
religion_marriage

#----------------------------------
ageg_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  group_by(ageg, group_marriage) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n),
         pct = round(n/tot_group*100, 1))
ageg_marriage

ageg_divorce <- ageg_marriage %>%
  filter(ageg != "young" & group_marriage == "divorced") %>%
  select(ageg, pct)

ageg_divorce

ggplot(ageg_divorce, aes(x=ageg, y=pct, fill=ageg)) + geom_col()

ageg_religion_marriage <- welfare %>%
  filter(!is.na(group_marriage) & ageg != "young") %>%
  group_by(ageg, religion, group_marriage) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n),
         pct = round(n/tot_group*100, 1))
ageg_religion_marriage

df_divorce <- ageg_religion_marriage %>%
  filter(group_marriage == "divorced") %>%
  select(ageg, religion, pct)
df_divorce

ggplot(df_divorce, aes(x=ageg, y=pct, fill=religion)) + geom_col(position="dodge")
