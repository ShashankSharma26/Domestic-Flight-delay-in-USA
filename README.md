# Flight Delay Visualisation

This project is to develop an interactive visualisation for domestic flight delays in U.S.A, using the data obtained from Statistical Computing Statistical Graphics 2009 Data Expo ("Get the data",2018). The motivation behind this interactive visualisation is to help the travellers looking to fly within U.S.A to choose the right time of the year as well as the best airlines to avoid flight delays

The visualisation is developed using R shiny and the web application has been hosted on shiny server. The webpage can be accessed using the following url: http://bit.ly/FlighDelay

The attributes of the data are explained below: 
•	Month:			1(January)-12(December)
•	DayofMonth:		1-31
•	DayOfWeek:		1 (Monday) - 7 (Sunday)
•	DepTime:		actual departure time (local, hhmm)
•	CRSDepTime:		scheduled departure time (local, hhmm)
•	ArrTime:		actual arrival time (local, hhmm)
•	CRSArrTime:		scheduled arrival time (local, hhmm)
•	UniqueCarrier:		unique carrier code
•	FlightNum:		flight number
•	TailNum:		plane tail number
•	ActualElapsedTime:	actual journey time (in minutes)
•	CRSElapsedTime:	scheduled journey time (in minutes)
•	AirTime:		air time (in minutes)
•	ArrDelay:		arrival delay, in minutes
•	DepDelay:		departure delay, in minutes
•	Origin	: 		origin IATA airport code
•	Dest: 			destination IATA airport code
•	Distance: 		in miles
•	TaxiIn:			taxi in time, in minutes
•	TaxiOut:		taxi out time in minutes
•	Cancelled:		was the flight cancelled?
•	CancellationCode:	reason for cancellation (A=carrier, B = weather,C =NAS, D = security)
•	Diverted:		1 = yes, 0 = no
•	CarrierDelay:		delay within control of airlines (in minutes)
•	WeatherDelay: 		delay due to bad weather (in minutes)
•	NASDelay		delay within control of NAS (in minutes)
•	SecurityDelay		delay due to security procedures (in minutes)
•	LateAircraftDelay	delay due to late arrival of aircraft (in minutes)

The questions that this project aims to answer are:
•	What time of the year are flight most likely to be delayed?
•	Which airlines has the most number of delayed flights and why?
•	Is the time recovered during journey related to delay at departure?
•	Is priority given to delayed flights using Taxi in/out?
•	Is priority given to any specific airlines wile taxi in/out?
•	Which route has the most number of delays and why?

I was motived to answer these question as this would help travellers to understand the trend of flight delays depending on when they are travelling, where they are travelling and by which airlines they are travelling. 
 
#1. Data Wrangling





