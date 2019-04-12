library(reshape2) ##used to melt datraframes

##The wrangled csv is read and saved in a format to be used gor each visualisation
## this is done to reduce data loading time as the original file is huge

data<- read.csv("wrangled_data.csv") ## reading the wrangled csv


## Writing sample data to csv
new_d = data[,-match(c("X.2","X.1","X","UniqueCarrier","Distance"),names(data))]
new_d = head(new_d,n=100)  
write.csv(new_d, file = "sample_data.csv")


##data for delay count per day
day <- data[,c("ArrDelay","DayofMonth","Month")]
day_sum<-aggregate(day$ArrDelay,by=list(day$DayofMonth,day$Month ), FUN= sum)
write.csv(day_sum, file = "year_data.csv")



##for cariier delay and late aircraft delay
car<-data[,c("CarrierDelay","LateAircraftDelay","Airline")]
car <- car[data$CarrierDelay != 0 , ]
write.csv(car, file = "delay_date.csv")




## for sankey plot total delay
route <- data[,c("ArrDelay","Origin","Dest")]
x<-aggregate(route,by=list(route$Origin,route$Dest), FUN = length)
x <- x[,c("ArrDelay",'Group.1','Group.2')]

names(x)[names(x) == 'Group.1'] <- 'Origin'
names(x)[names(x) == 'Group.2'] <- 'Destination'
xe<- x[order(x$ArrDelay),]
rr<-tail(xe,10)
rr$org = c(0,1,2,3,4,5,6,7,8,9)
rr$dst = c(1,3,8,9,7,3,10,4,9,8)
rr$group=as.factor(c("a","b","c","d","e","f","g","e","f","g"))

write.csv(rr, file = "sankey_data_1.csv")




### for sankey mean delay
route_avg <- data[,c("ArrDelay","Origin","Dest")]
x_avg_s<-aggregate(route,by=list(route_avg$Origin,route_avg$Dest), FUN = function(x) c(mn = mean(x), n = length(x) ))
x_avg_df <- x_avg_s[,c("Group.1","Group.2")]
x_avg_df$Mean = x_avg_s$ArrDelay[,'mn']
x_avg_df$Frequency = x_avg_s$ArrDelay[,'n']

names(x_avg_df)[names(x_avg_df) == 'Group.1'] <- 'Origin'
names(x_avg_df)[names(x_avg_df) == 'Group.2'] <- 'Destination'

x_avg_df = x_avg_df[x_avg_df$Frequency > 100,]

ordered_x = x_avg_df[order(x_avg_df$Mean),]

sankey_df = tail(ordered_x, n = 10)

sankey_df$org = c(1,2,3,4,5,6,7,8,9,10)
sankey_df$dst = c(11,12,11,11,13,13,13,13,13,13)
sankey_df$group=as.factor(c("a","b","c","d","e","f","g","e","f","g"))
write.csv(sankey_df, file = "sankey_data_2.csv")




##for weather delay
weather_data <- data[,c("WeatherDelay","DayofMonth","Month")]
weather_sum<-aggregate(weather_data$WeatherDelay,by=list(day$DayofMonth,day$Month ), FUN= sum)
write.csv(weather_sum, file = "weather_data.csv")
