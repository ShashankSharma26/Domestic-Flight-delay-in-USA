##loading libraries
##these libararies should be installed to run the shiny app
library(shiny)
library(networkD3)
library(ggplot2)
library(reshape2)
library(DT)

##data for total delay per day
day_sum = read.csv("year_data.csv")

##data for delay by airline
air_df = read.csv("delay_date.csv")
air_1<-setNames( aggregate( air_df$CarrierDelay,by=list(air_df$Airline), FUN= mean),c("Airline","Carrier Delay"))
air_2<-setNames( aggregate( air_df$LateAircraftDelay,by=list(air_df$Airline), FUN= mean),c("Airline","Late Aircraft delay"))
total <- merge(air_1,air_2,by="Airline")
new_total <- melt(total, id=c("Airline"))

## sankey total delay
sank = read.csv("sankey_data_1.csv")
node_1 = data.frame("name"= c("DFW","DEN","SAN","LAS","HOU","PHX","ORD","DAL","SFO","LAX","LGA"))
node_1$group=as.factor(c("a","b","c","d","e","f","g","e","f","g","h"))


#sankey 2
sank_2 = read.csv("sankey_data_2.csv")
node_2 = data.frame("name"= c("","CAE","PVD","SPI","LNK","ACV","RDD","SBP","ONT","SBA","CEC","ORD","AWR","SFO"))
node_2$group=as.factor(c("a","a","b","c","d","e","f","g","e","f","g","h","f","d"))

#colour for sankey
my_color <- 'd3.scaleOrdinal() .domain(("a","b","c","d","e","f","g","e","f","g","h")) .range(["blue", "pink","green","yellow","orange","grey","brown","darkblue","purple","dark green","light green"])'

##weather data
weather_sum = read.csv("weather_data.csv")

##sample data
Sample_data = read.csv("sample_data.csv")


shinyServer(function(input, output) {
  
  
  
  
  output$flightplot <- reactivePlot(function()
  {
    types_cor <- c(input$Months)       ##input from group check box
    day_sum$mon = factor(day_sum$Group.2, levels=c("January","February","March","April","May","June","July","August","September","October","November","December"))
    data_new <- day_sum[day_sum$mon %in% types_cor,]     ##extracting a datframe with al selected types
    
    ggplot(data_new, aes( x = Group.1, y= x,fill = x)) + geom_bar(stat = "identity") + facet_grid( . ~ mon) + scale_fill_gradient2("Total Delay in minutes",low = "lightblue",mid = "lightblue", high = "darkblue") + labs(y ='Total Arrival Delay (minutes)', x = 'Days of month',title = 'Total delay time for each day in year 2008') +theme(axis.text=element_text(size=12),axis.title=element_text(size=14,face="bold"))
                                                                                                                                                                                                                                                                                                                                                
  }, height = 550, width = 1000)
  
  
  output$weatherplot <- reactivePlot(function()
  {
    types_co <- c(input$weather_months)       ##input from group check box
    weather_sum$mon = factor(weather_sum$Group.2, levels=c("January","February","March","April","May","June","July","August","September","October","November","December"))
    data_weather <- weather_sum[weather_sum$mon %in% types_co,]     ##extracting a datframe with al selected types
    
    ggplot(data_weather, aes( x = Group.1, y= x,fill = x)) + geom_bar(stat = "identity") + facet_grid( . ~ mon) + scale_fill_gradient2("Weather Delay in minutes",low = "yellow",mid = "yellow", high = "red") + labs(y ='Total Weather Delay (minutes)', x = 'Days of month',title = 'Weather delay each day in year 2008') +theme(axis.text=element_text(size=12),axis.title=element_text(size=14,face="bold"))
  }, height = 550, width = 1000)
  
  
  
  output$sankeyplot <- renderSankeyNetwork({
    # plotting sankey diagram
    sankeyNetwork(Links = sank, Nodes = node_1, Source = "org",
                  Target = "dst", Value = "ArrDelay",colourScale=my_color, LinkGroup="group", NodeGroup="group", NodeID = "name",
                  fontSize = 40, nodeWidth = 20)
  })
  
  output$sankey_avg <- renderSankeyNetwork({
    ##plotting sankey diagram
    sankeyNetwork(Links = sank_2, Nodes = node_2, Source = "org",
                  Target = "dst", Value = "Mean",colourScale=my_color, LinkGroup="group", NodeGroup="group", NodeID = "name",
                  fontSize = 40, nodeWidth = 20)
  })
  
  output$table <- DT::renderDataTable({
    ##sample data
    Sample_data
    
  })
  
  output$airplot <- renderPlot({
    
    ggplot(total, aes(x=Airline,y=total$`Carrier Delay` , fill =total$`Carrier Delay`)) + geom_bar(stat = "identity") + scale_fill_gradient2('Carrier delay in minutes',low= 'green',mid = 'green', high= 'brown') + coord_flip() + labs(y ='Average Carrier Delay (minutes)', x = 'Airline',title = 'Average carrier delay for each airline in year 2008') +theme(axis.text=element_text(size=12),axis.title=element_text(size=14,face="bold"))
    
  }, height = 550, width = 900)
  
  output$airplot_lateair <- renderPlot({
    
    ggplot(total, aes(x=Airline,y=total$`Late Aircraft delay`, fill = total$`Late Aircraft delay`)) + geom_bar(stat = "identity") + scale_fill_gradient2('Late Aircraft delay in minutes',low= 'green',mid = 'green', high= 'brown') + coord_flip() + labs(y ='Average Late Aircraft Delay (minutes)', x = 'Airline',title = 'Average late aircraft delay for each airline in year 2008') +theme(axis.text=element_text(size=12),axis.title=element_text(size=14,face="bold"))
    
  }, height = 550, width = 900)
  
  output$bothplot <- renderPlot({
    
    ggplot(new_total,aes(x=Airline,y=value,fill=factor(variable)))+coord_flip() +geom_bar(stat="identity",position="dodge", width = 0.6)+scale_fill_manual("Delay Reason\n", values = c("darkblue","orange"), labels = c(" Carrier Delay", " Late Aircraft Delay"))+xlab("Airlines")+ylab("Delay in minutes") +theme(axis.text=element_text(size=12),axis.title=element_text(size=14,face="bold"))
    
    
  }, height = 700, width = 900) 
  
})
