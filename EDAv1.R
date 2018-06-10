#Libraries
install.packages("mlbench")
install.packages("ggplot2")
install.packages("dplyr")
library(mlbench)
library(ggplot2)
library(magrittr)
library(dplyr)
library(VIM)

#Set Work Directory
setwd("C:/Users/Colin/Documents/GMU DAEN 690/CRE Project Main Shell/Box_Downloads/Raw_Data")

#Read In Data
apt_mkt <- read.csv("APT_MKT.csv")
apt_sub <- read.csv("APT_SUB.csv")
ofc_mkt <- read.csv("OFC_MKT.csv")
ofc_sub <- read.csv("OFC_SUB.csv")

#How complete are our datasets? Start with apartment market
summary(apt_mkt)
summary(apt_mkt$Year)
nrow(apt_mkt)
sum(complete.cases(apt_mkt))
sum(is.na(apt_mkt))

#How complete are our datasets? Follow up with apartment submarket data
summary(apt_sub)
summary(apt_sub$Year)
nrow(apt_sub)
sum(complete.cases(apt_sub))
sum(is.na(apt_sub))

# we do have some missing/non-complete observations 
apt_sub %>%
  select(which(colMeans(is.na(.)) > 0)) %>%
  aggr(prop = FALSE, combined = TRUE, numbers = TRUE, bars = FALSE, cex.axis = 0.7)
# Seems like Rent has the most missing values, and the missing values typically come across...
# Absorption, Vacany Rate and Rent at the same time

#How complete are our datasets? Office market
summary(ofc_mkt)
summary(ofc_mkt$Year)
nrow(ofc_mkt)
sum(complete.cases(ofc_mkt))
sum(is.na(ofc_mkt))

#How complete are our datasets? Follow up with Office submarket data
summary(ofc_sub)
summary(ofc_sub$Year)
nrow(ofc_sub)
sum(complete.cases(ofc_sub))
sum(is.na(ofc_sub))
