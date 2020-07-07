library(foreign)
library(dplyr)
library(tidyverse)
library(ggplot2)
library(readxl)

raw_welfare <- read.spss(file = "C:\\Users\\mega\\Desktop\\rwork\\Doit_R_170717\\Data\\Koweps_hpc10_2015_beta1.sav", to.data.frame = T)
welfare <- raw_welfare
View(welfare)
summary(welfare)

welfare <- rename(welfare, sex = h10_g3,
                  birth = h10_g4,
                  marriage = h10_g10,
                  religion = h10_g11,
                  income = p1002_8aq1,
                  code_job = h10_eco9,
                  code_religion = h10_reg7)

welfare_simplified <- welfare %>%
  select(sex, birth, marriage, religion, income, code_job, code_religion)

class(welfare_simplified$sex)
table(welfare_simplified$sex)

str(welfare_simplified)


welfare_simplified$sex <- ifelse(welfare_simplified$sex==9, NA, welfare_simplified$sex)
welfare_simplified$sex <- ifelse(welfare_simplified$sex==1, "male", "female")
table(is.na(welfare_simplified$sex))

qplot(welfare_simplified$sex, colour=welfare_simplified$sex)

class(welfare_simplified$income)
summary(welfare_simplified$income)

qplot(welfare_simplified$income)
qplot(welfare_simplified$income) + xlim(0,1000)
welfare_simplified$income <- ifelse(welfare_simplified$income %in% c(0,9999), NA, welfare$income)

table(is.na(welfare_simplified$income))

sex_income <- welfare_simplified %>%
  filter(!is.na(income)) %>%
  group_by(sex) %>%
  summarise(mean_income = mean(income))

sex_income















