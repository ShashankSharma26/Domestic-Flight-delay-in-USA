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
* NASDelay		delay within control of National Airspace System(NAS) (in minutes)
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

## 2.2 Delay patterns by Airlines

![](images/delay%20per%20Airlines.png)

The above figure shows that Southwest, United and American airlines which are amongst the biggest airlines companies in USA, has the most number of delays in year 2008. This data might be skewed because these airlines have more functional flights than the other ones. Hence, to get a better idea about the airline which is most likely to be delayed, average carrier delay should be used as carrier delay is within the control of the airlines and would be the best factor to suggest an airlines punctuality.

![](images/Carrier%20delay.png)

Figure 7 shows a clearer picture about the measure of punctuality of all the airlines. Southwest airlines had the most number of delays but has the least average carrier delay, this proves that the dominance of southwest in figure 6 was just because of more number of flights. The tree map shows that Mesa Airlines has the highest number of average carrier delay, hence is most likely to be delayed as compared to all other flights.

## 2.3 Taxi In/Out dependency on departure delay

![](images/Taxi%20in.png)

![](images/Taxi%20out.png)

Figure 8 and 9 shows that taxi in and taxi out are independent of how delayed a flight is during departure. 

## 2.4 Taxi In/Out dependency on Airlines

![](images/airlines%20taxi%20in.png)


![](images/airlines%20taxi%20out.png)

The above two figures prove that taxi in/out time is independent of airline as well. One thing that can be deduced from last four figures is that taxi in/out time is independent of all attributes in the data as no other attribute would have an impact on taxi time. Therefore, in scope of this data it is not possible to establish a relation with taxi time of flight with any other factor.

## 2.5  Time recovery dependency on departure delay

This section is to identify if a delayed flight is more likely to recover some time during its journey i.e. finish the journey in less than the scheduled journey time. The figure below shows that the time recovered is positively related to delay in departure, but the relation is not as linear as one expects it to be (correlation coefficient = .4).

![](images/departure%20delay%20vs%20time%20recovered.png)

An attempt was made to up this correlation coefficient by using the data with journey distance of more than 600 miles, but even this did not make a significant difference as the correlation coefficient just increased by .04. Hence, it can be deduced that recovery time is moderately related to departure delay.

## 2.6 Routes with most number of delays

This section identifies the route with most number of delays in USA. The figure below shows the top 10 routes with the most delays in USA.

![](images/routes%20with%20most%20delays%20.png)

![](images/LAX_SF0%20delay%20reasons.png)

As shown in the figures above, the route between Los Angeles and San Francisco has the most number of delays and the reason for this is majorly late aircraft delay which could be due to high air traffic as NAS delay is not far behind as compared to late air craft delay.

# 3. User guide to Interactive Web Based Visualisation 

![](images/welcome%20page.png)

The welcome page of the application is made to help the user understand the motive behind the application. Also, it describes all the tabs used in the application to guide the user to the appropriate tab based on the requirement. The selected tab is given a darker shade to help the user understand which tab is opened at an instance. All the tabs can be accessed by clicking on it once.

![](images/Delay%20per%20time%20of%20year.png)

The first tab named ‘Delay per time of year’ as shown in figure 8, contains radio button to select between two plots. The first one explains the total delay across the year 2008 to help the user understand the worst time to fly in a year within America. Also, as weather is the major factor affecting flight delays at different periods of a year, the total weather delay across the year is also plotted. Initially the plot shows all the months of the year, but the user can alter this by deselecting the checkbox next to any month to hide it, if only a few months are to be considered for the analyses. The deselected can be brought back by selecting it again, this flexibility is given for better scope of analysis.

![](images/routes%20with%20most%20delays.png)

The tab named ‘Routes with most delays’ is to show the worst routes to fly within U.S.A based on time delays. Sankey diagram is implemented to show top ten routes with most time delay based on total time delay and average time delay. Radiobuttons could be used to toggle between the two Sankey diagrams. The reason behind using Sankey over any other diagram was its supremacy to show the links between two nodes (here airports) in a simple yet coherent manner. The Sankey diagram also exhibits hover on functionality when he cursor pointer is placed on a node or a link. Placing a cursor on a node shows a tooltip with the name of the airport represented by that node along with amount of delay occurred at the airport. Similarly, placing the cursor on a link shows a tooltip with flow of the link or in simpler words the origin and the destination airports name represented by the link along with the amount of delay that occurred on that route.

The loops of link observed in figure 9 is another reason that Sankey diagram was implemented. The loop means that the particular route is amongst the top routes with delays for both to and fro journey between the two airports, this trend can be viewed between DAL-HOU and LAX-SFO. The 3 letters used to describe an airport is not best way to convey the name of the airport, hence an index is provided along with the diagram with the full names of the airports for a better understanding.


![](images/Delay%20due%20to%20Airlines.png)

It is very important for every traveller to choose the right airlines, as no individual likes to reach the airport to know that flight is delayed due to some airlines issues. Hence, the ‘Delay per Airlines’ tab is included in the application to help the user understand the best and the worst airlines to travel from based on punctuality. This is done by using three plots based on:
* Average carrier delay: Delay due to mismanagement by airlines
* Average late air craft delay: Delay due to late arrival of the aircraft to be used for the
trip.
* Both: This is important to judge the airlines based on both the factors mentioned
above
The plots are given a colour gradient based on the amount of delay to make the experience of the user ever better. The user can toggle between the 3 plots using radiobuttons placed in the side panel of the application.


![](images/data.png)

The ‘Data’ tab is given in the application to provide the user with the sample data based on which all the visualisations were made. The data table is also provided with a search bar in case a user needs an exact value for from the data.

# 4. Conclusion and Reflection

The project helps the user to analyse and comprehend the best or the worst time to fly within United States of America. It also assists the user to decide the best possible airlines to fly with and in case the user is travelling to or from one of the airports with most delays, it prepares them as they might experience a delay considering the reputation of the airport. This application gives user the freedom to select the visualisation based on the requirements, as flashing colourful visualisation which is of no meaning to the user is just a waste of space on the screen. This application is made with an attempt to maintain a high data-ink ratio or more appropriately data-pixel ratio to give away maximum information and to ensure good user experience.

The size of the data used in this project was huge as it contained information of about 2 million flight delays in USA. Wrangling the data to the right format and removing the outliers to ensure that the visualisations are not skewed was a very demanding task. All the airlines and airports were mentioned in codes in the data, hence external sources were used to get the names of the airlines and the airports. Also, implementing Sankey diagram was not an easy task as the data was needed to be brought to a very specific format to feed it to plot a Sankey diagram. It was also ensured that the links of the Sankey diagram are coloured which makes it easy to identify and spot routes without any ambiguity even if it overlaps.






