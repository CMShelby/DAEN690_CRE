#
# source("classEDA.r")
# source("classDensity.r")
# library("glmnet")
# library("corrplot")
#
# for time series
library(fpp)

# for Graphing
library(mlbench)
library(ggplot2)
library(magrittr)
library(dplyr)
library(VIM)

#
set.seed(1)
options(stringsAsFactors=FALSE)
# 
df_apt_mkt = read.csv("APT_MKT.csv", head=TRUE)
df_apt_sub = read.csv("APT_SUB.csv", head=TRUE)
dim(df_apt_mkt) # 96 14
dim(df_apt_sub) # 2788 12
#
df_ofc_mkt = read.csv("OFC_MKT.csv", head=TRUE)
df_ofc_sub = read.csv("OFC_SUB.csv", head=TRUE)
dim(df_ofc_mkt) # 152 14
dim(df_ofc_sub) # 3960 15
#
#
# Merge (inner-join) data
df_apt<-merge(df_apt_mkt, df_apt_sub, by="Year") 
df_ofc<-merge(df_ofc_mkt, df_ofc_sub, by="Year") 
dim(df_apt) # 2788 25
dim(df_ofc) # 3960 28
#
# Make data the first column (need for time series)


#
summary(df_apt)
names(df_apt) # column names
str(df_apt)
#
summary(df_ofc)
names(df_ofc) # column names
str(df_ofc)
#
# Vector of neighborhood names for apartment and offices, respectively
v_neigh_apt <- unique(df_apt$SubmarketName)
v_neigh_apt
v_neigh_ofc <- unique(df_ofc$SubmarketName)
v_neigh_ofc
#
# Create individual dataframe for each neighborhood
#  
for (i in 1:length(v_neigh_apt)) { 
  name=v_neigh_apt[i]
  temp<-subset(df_apt, SubmarketName==name)
  assign(paste("df_neigh_apt_", name, sep=""),temp)
}
#
for (i in 1:length(v_neigh_ofc)) { 
  name=v_neigh_ofc[i]
  temp<-subset(df_ofc, SubmarketName==name)
  assign(paste("df_neigh_ofc_", name, sep=""),temp)
}
#
# Time series forecast
#
# Time series using sweep and arima
# http://www.business-science.io/code-tools/2017/10/25/demo_week_sweep.html\
#
library("sweep")
library("forecast")
library("timetk")
# Convert from tbl to ts using timetk::tk_ts()
# Create time series forecast for each neighborhood for both offices and apt
for (i in 1:length(v_neigh_apt)) { 
  name=v_neigh_apt[i]
  full_name<-paste("ts_neigh_apt_", name, sep="")
  assign(paste("df_ts_neigh_apt_", name, sep=""),tk_ts(full_name,frequency=4,start=c(1994,1),end=c(2017,4), silent=FALSE, frequenc))
  summary(full_name)
}


