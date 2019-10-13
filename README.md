# Flight Delay Visualisation

This project is to develop an interactive visualisation for domestic flight delays in U.S.A, using the data obtained from Statistical Computing Statistical Graphics 2009 Data Expo ("Get the data",2018). The motivation behind this interactive visualisation is to help the travellers looking to fly within U.S.A to choose the right time of the year as well as the best airlines to avoid flight delays

The visualisation is developed using R shiny and the web application has been hosted on shiny server. The webpage can be accessed using the following url: http://bit.ly/FlighDelay

The attributes of the data are explained below: 
* Month:			1(January)-12(December)
* DayofMonth:		1-31
* DayOfWeek:		1 (Monday) - 7 (Sunday)
* DepTime:		actual departure time (local, hhmm)
* CRSDepTime:		scheduled departure time (local, hhmm)
* ArrTime:		actual arrival time (local, hhmm)
* CRSArrTime:		scheduled arrival time (local, hhmm)
* UniqueCarrier:		unique carrier code
* FlightNum:		flight number
* TailNum:		plane tail number
* ActualElapsedTime:	actual journey time (in minutes)
* CRSElapsedTime:	scheduled journey time (in minutes)
* AirTime:		air time (in minutes)
* ArrDelay:		arrival delay, in minutes
* DepDelay:		departure delay, in minutes
* Origin	: 		origin IATA airport code
* Dest: 			destination IATA airport code
* Distance: 		in miles
* TaxiIn:			taxi in time, in minutes
* TaxiOut:		taxi out time in minutes
* Cancelled:		was the flight cancelled?
* CancellationCode:	reason for cancellation (A=carrier, B = weather,C =NAS, D = security)
* Diverted:		1 = yes, 0 = no
* CarrierDelay:		delay within control of airlines (in minutes)
* WeatherDelay: 		delay due to bad weather (in minutes)
* NASDelay		delay within control of NAS (in minutes)
* SecurityDelay		delay due to security procedures (in minutes)
* LateAircraftDelay	delay due to late arrival of aircraft (in minutes)

The questions that this project aims to answer are:
* What time of the year are flight most likely to be delayed?
* Which airlines has the most number of delayed flights and why?
* Is the time recovered during journey related to delay at departure?
* Is priority given to delayed flights using Taxi in/out?
* Is priority given to any specific airlines wile taxi in/out?
* Which route has the most number of delays and why?

 
# 1. Data Wrangling

There were a lot of NA’s in the data, especially in the columns with kinds of delays such as Carrier Delay, Weather Delay etc., these values were replaced with 0. All the months and days of week were represented in a numerical form in the data. This was changed to appropriate months and days names for quick understanding.
The data contains information of 20 airlines that fly within USA, the airlines were represented using their IATA code which is a bit hard to interpret. Hence, proper names were given to all the airlines for easy interpretation. 

To ensure the data is not skewed, the rows of data with departure/arrival delay above the upper whisker of their respective boxplot were removed. The data also had a considerate number of rows with arrival delay below 0 meaning that the flight landed before scheduled time. So much so that the lower whisker of the arrival delay boxplot was at -61 minutes. As this exploration is only to discover the trend in delayed flights, all the rows with negative arrival delay values where removed.

![](images/boxplot%20arrival:departure%20delay.png)

Figure 2 shows that the data has a minimum scheduled elapsed time in negative values which is not possible. Similarly, minimum actual elapsed time of 14 minutes also is unrealistic. The fact that the shortest domestic flight in USA has a journey time of 45 minutes was used to refine this data (Soo Kim, 2018). Hence, all the rows with actual/schedule journey time under 45 were removed. 

The shortest domestic flight mentioned above has an air time of 16 minutes. This fact was used to remove all the rows of the data with airtime value under 16 minutes.

Figure 2 shows that taxi in/out also had peculiar values in the data, taxi time of more than two hours or equal to zero is unrealistic. Therefore, using an online resource to find the maximum and minimum taxi/in out time ("What Is Your Airport's Average Taxi Time?", 2016), all the rows with values below 2 or above 11.88 for taxi in or values below 5.6 or above 27 for taxi out were removed.

![](images/Summary%20of%20attributes.png)

# 2. Data Exploration

## 2.1 Delay pattern by time of the year

![](images/total%20arrival%20delay.png)

Using the graph above, one can easily say that end of December and start of January has a lot of delays which can be due festive season in USA. There are few other huge peaks which coincides with or falls around federal holidays in the year 2008, like: February 18 – President’s Day, May 26- Memorial Day and November 28- Thanksgiving. Though this trend is not followed in all the months, but high delays are observed at the beginning and end of many months like January, February, March, April, June and December.

Figure 3 was unable to explain the reason for less delays in September, October and November and high delay patterns in the month of June. To get a better idea about this, all the months were compared by the amounts of weather delay that occurred in them using a tree map as shown in figure 4 below.

![](images/Weather%20delay.png)

This visualisation helps us to understand that the month of June has the maximum delay time due to bad weather, hence, it explains the high delay patterns. Figure 4 also shows that the month of September, October and November has the lowest number of weather delay as compared to all other months which explains the low delay patterns observed in these months in figure 3.

## 3.2 Delay patterns by Airlines

![](images/delay%20per%20Airlines.png)

The above figure shows that Southwest, United and American airlines which are amongst the biggest airlines companies in USA, has the most number of delays in year 2008. This data might be skewed because these airlines have more functional flights than the other ones. Hence, to get a better idea about the airline which is most likely to be delayed, average carrier delay should be used as carrier delay is within the control of the airlines and would be the best factor to suggest an airlines punctuality.

![](images/Carrier%20delay.png)

Figure 7 shows a clearer picture about the measure of punctuality of all the airlines. Southwest airlines had the most number of delays but has the least average carrier delay, this proves that the dominance of southwest in figure 6 was just because of more number of flights. The tree map shows that Mesa Airlines has the highest number of average carrier delay, hence is most likely to be delayed as compared to all other flights.

## 3.3 Taxi In/Out dependency on departure delay

![](images/Taxi%20in.png)

![](images/Taxi%20out.png)

Figure 8 and 9 shows that taxi in and taxi out are independent of how delayed a flight is during departure. 

## 3.4 Taxi In/Out dependency on Airlines

![](images/airlines%20taxi%20in.png)


![](images/airlines%20taxi%20out.png)




