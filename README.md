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


