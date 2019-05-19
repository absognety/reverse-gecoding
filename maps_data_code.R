getwd()
#setwd(" ") (if any)
if(!require(readxl))
  install.packages("readxl")
library(readxl)
mydata <- read_xlsx("Long_Lattitufde.xlsx")
names(mydata)
str(mydata)
class(mydata)
test <- as.data.frame(mydata)
if(!require(sp))
  install.packages("sp")
if(!require(maps))
  install.packages("maps")
if(!require(maptools))
  install.packages("maptools")
library(maps)
library(sp)
library(maptools)
post_rem_dt <- na.omit(mydata)

req_dt <- as.data.frame(post_rem_dt)
result <- data.frame(nrow = 10,ncol = 3)

res <- lapply(with(req_dt, paste(lat, lon, sep = ",")), geocode, output = "more")
final <- character()
for(i in 1:nrow(req_dt)){
  final[i] <- as.character(res[[i]]$administrative_area_level_1)
}
final <- as.data.frame(final)
final_result <- cbind(req_dt,final)
write.csv(final_result,file = "latlong2states_updated.csv")


