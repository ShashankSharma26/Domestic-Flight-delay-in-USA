##importing lib
library(shiny)
library(networkD3)
library(shinythemes)
library(DT)

shinyUI(fluidPage(
  tags$style("body {background-color: #F0F0F0; }"), ##background colour
  headerPanel(h2(strong("Domestic Flight Delays In U.S.A In 2008"), align = "center", style = "color: brown; font-family: 'georgia';")), ##Main heading
  tags$style(HTML("
                  .tabbable > .nav > li > a                  {background-color: #C0C0C0;  color:black}   
                  .tabbable > .nav > li[class=active]    > a {background-color: #A0A0A0; color:white}
                  ")),
  tabsetPanel(
              tabPanel(h6(strong("Welcome"),style = "color:blue;font-family: 'georgia';"), value = 1,    ##welcome tab ui 
                       
                       sidebarLayout(
                         sidebarPanel(
                             h4(strong("Guide for tab selection"),style ="color:brown;font-family: 'georgia';" ),
                             h5(strong("Delay per time of year"),style ="font-family: 'georgia';"),
                             tags$ul(
                               tags$li("What time of year are flights most delayed?"), 
                               tags$li("How weather delay varies over the months?")
                               
                             ),
                             h5(strong("Routes with most delays"),style ="font-family: 'georgia';"),
                             tags$ul(
                               tags$li("Which route has the most number of delays?"), 
                               tags$li("Which route has the highest average delay time?")
                               
                             ),
                             h5(strong("Delay per Airlines"),style ="font-family: 'georgia';"),
                             tags$ul(
                               tags$li("Average delay per airline due to carrier delay"), 
                               tags$li("Average delay per airline due to late aircraft delay"),
                               tags$li("Comparing average delay per airlines")
                               
                             ),
                             h5(strong("Data"),style ="font-family: 'georgia';"),
                             tags$ul(
                               tags$li("Displays the first 100 rows of the data used for the project")
                               
                             )
                           ),
                       mainPanel(h3("Fed up of flight delays?", align = "center", style = "color:blue;font-family: 'georgia';"),
                                 h5("This app helps you decide the best time to fly by the right airlines. Also, discover the",align = "center", style = "color:brown;font-family: 'georgia'"),
                                 
                                 h5("worst airports to travel to/from in United States of America based on flight delays.",align = "center", style = "color:brown;font-family: 'georgia'"),
                                 
                                 HTML('<center><img src="late.jpg" width="600" height="400"></center>')))),
             
              tabPanel(h6(strong("Delay per time of year"),style = "color:blue;font-family: 'georgia';"), value = 3,
                       sidebarLayout(
                         sidebarPanel(
                           conditionalPanel(
                           condition = "input.tabs == 3",
                           radioButtons("weather",                                #weather option for radio button
                                        h5(strong("Delay across the year based on"),style = "color:brown;font-family: 'georgia';" ),
                                        choices = c("Total delay","Weather Delay")
                                        
                           )
                           
                         ),
                         conditionalPanel(
                           condition = "(input.weather == 'Total delay') & (input.tabs == 3)",
                           checkboxGroupInput("Months",                                ##l;,,
                                              h6(strong("Select months to plot"),style = "color:brown;font-family: 'georgia';"),
                                              choices = c("January","February","March","April","May","June","July","August","September","October","November","December"),
                                              selected = c("January","February","March","April","May","June","July","August","September","October","November","December")
                           ) 
                         ),
                         conditionalPanel(
                           condition = "(input.weather == 'Weather Delay') & (input.tabs == 3)",
                           checkboxGroupInput("weather_months",                                ##l;,,
                                              h6(strong("Select months to plot"),style = "color:brown;font-family: 'georgia';"),
                                              choices = c("January","February","March","April","May","June","July","August","September","October","November","December"),
                                              selected = c("January","February","March","April","May","June","July","August","September","October","November","December")
                           ) 
                         )
                         
                         ),
                         
                         mainPanel(conditionalPanel(
                           condition = "(input.tabs == 3) & (input.weather == 'Weather Delay')",
                           plotOutput("weatherplot")
                         )
                         ,
                         
                         conditionalPanel(
                           condition = "(input.tabs == 3) & (input.weather == 'Total delay')",
                           plotOutput("flightplot")
                         )
                           
                         )
                       )),
              
              tabPanel(h6(strong("Routes with most delays"),style = "color:blue;font-family: 'georgia';"), value = 4,
                       sidebarLayout(
                         sidebarPanel(conditionalPanel(
                           condition = "input.tabs == 4",
                           radioButtons("sankey",                                ##l;,,
                                        h5(strong("Routes with most delay based on:"),style = "color:brown;font-family: 'georgia';"),
                                        choices = c("Number of delays","Average Delay")
                                        
                           )
                           ),
                           conditionalPanel(
                             condition = "(input.sankey == 'Number of delays') &(input.tabs == 4)",
                             
                             h5(strong("Airport Index"),style = "color:brown;font-family: 'georgia';"),
                             tags$ul(
                               tags$li(strong("DFW"),": Dallas/FortWorth Int'l Airport "), ##index for sankey diagram
                               tags$li(strong("DEN"),": Denver Int'l Airport "),
                               tags$li(strong("SAN"),": San Diego Int'l Airport "),
                               tags$li(strong("LAS"),": Las Vegas Int'l Airport "), 
                               tags$li(strong("HOU"),": Houston Int'l Airport "),
                               tags$li(strong("DAL"),": Dallas Int'l Airport "),
                               tags$li(strong("SFO"),": San Francisco Int'l Airport "), 
                               tags$li(strong("LAX"),": Los Angeles Int'l Airport "),
                               tags$li(strong("LGA"),": LaGuardia Int'l Airport ")
                               
                             )
                           ),
                           conditionalPanel(
                             condition = "(input.sankey == 'Average Delay') &(input.tabs == 4)",
                             
                             h5(strong("Airport Index"),style = "color:brown;font-family: 'georgia';"), ##index for sankey diagram
                             tags$ul(
                               tags$li(strong("CAE"),": Columbia Metroppolitan Airport "), 
                               tags$li(strong("SPI"),": Abraham Lincoln Capital Airport "),
                               tags$li(strong("LNK"),": Lincoln Airport "),
                               tags$li(strong("PVD"),": T.F Green Int'l Airport "), 
                               tags$li(strong("ACV"),": Arcata - Eureka Airport "),
                               tags$li(strong("RDD"),": Redding Municipal Airport "),
                               tags$li(strong("SBD"),": San Bernardino Int'l Airport "), 
                               tags$li(strong("ONT"),": Ontaria Int'l Airport "),
                               tags$li(strong("SBA"),": Santa Barbera Municipal Airport "),
                               tags$li(strong("ORD"),": O'Hare Int'l Airport "), 
                               tags$li(strong("AWR"),": Awar Airport "),
                               tags$li(strong("SFO"),": San Francisco International Airport ")
                               
                             )
                           )
                           ),
                         mainPanel( conditionalPanel(
                           condition = "(input.sankey == 'Number of delays') &(input.tabs == 4)",
                           
                           sankeyNetworkOutput("sankeyplot")
                         ),
                         
                         
                         conditionalPanel(
                           condition = "(input.sankey == 'Average Delay') &(input.tabs == 4) ",
                           
                           sankeyNetworkOutput("sankey_avg")
                         )
                         
                         ))),
              tabPanel(h6(strong("Delay per Airlines"),style = "color:blue;font-family: 'georgia';"), value =2,
                       sidebarLayout(
                         sidebarPanel(conditionalPanel(
                           condition = "input.tabs == 2",
                           radioButtons("reason",                                ##l;,,
                                        h5(strong("Airlines delay due to:"),style = "color:brown;font-family: 'georgia';"),
                                        choices = c("Carrier Delay","Late Aircraft Delay","Both")
                                        
                           )))
                         ,
                         mainPanel( conditionalPanel(
                           condition = "(input.reason == 'Both') &(input.tabs == 2)",
                           
                           plotOutput("bothplot")
                         ),
                         
                         
                         conditionalPanel(
                           condition = "(input.reason == 'Carrier Delay') &(input.tabs == 2) ",
                           
                           plotOutput("airplot")
                         ),
                         
                         conditionalPanel(
                           condition = "(input.reason == 'Late Aircraft Delay') &(input.tabs == 2)",
                           
                           plotOutput("airplot_lateair")
                         )
                         
                         ))
              ),
              
              tabPanel(h6(strong("Data"),style = "color:blue;font-family: 'georgia';"), value = 5,
                       mainPanel(
                         DT::dataTableOutput("table")
                       )
                
              ),
              
              id = 'tabs'
                       )
  
  
  
              
   
    )
  )

