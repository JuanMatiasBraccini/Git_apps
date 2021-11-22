.libPaths('C:/~/R/win-library/4.0')
library(shiny)

#key notes: Behind the app webpage, my computer runs the R script. 
#           need a web server to upload the shiny app to the cloud
#           

#Components
#1. Build user interphase
#2. Set of instructions to tell the server what to do


rport.link.fn=function(x)paste("http://www.fish.wa.gov.au/Documents/research_reports/",x,".pdf",sep="")


palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
          "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

ui=fluidPage(
  titlePanel("TDGDLF"),
  
  #Document links
  selectInput('website', 'Choose a document', list(
    Commercial.species.movement = rport.link.fn("frr282"),
    White.shark.population.modelling = rport.link.fn("frr277"),
    White.shark.movement = rport.link.fn("frr273"),
    Fisheries.Status.Report="http://www.fish.wa.gov.au/About-Us/Publications/Pages/State-of-the-Fisheries-report.aspx",
    Reference.Points.Paper="https://www.researchgate.net/publication/280555448_Displaying_uncertainty_in_the_biological_reference_points_of_sharks"
  )),
  htmlOutput("mySite"),
  
  #Dummy interactive plot
  headerPanel('Dummy example - MDS ordination'),
  sidebarPanel(
    selectInput('xcol', 'X Variable', names(iris)),
    selectInput('ycol', 'Y Variable', names(iris),
                selected = names(iris)[[2]]),
    numericInput('clusters', 'Cluster count', 3,
                 min = 1, max = 9)
  ),
  mainPanel(
    plotOutput('plot1')
  )
  
)



# instructions of what to show in the webpage
server = function(input, output, session)
{
  #Document links
  output$mySite <- renderUI({
    tags$a(href = input$website, input$website)
  })
  
  #Dummy interactive plot
  selectedData <- reactive({
    iris[, c(input$xcol, input$ycol)]
  })
  
  clusters <- reactive({
    kmeans(selectedData(), input$clusters)
  })
  
  output$plot1 <- renderPlot({
    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData(),
         col = clusters()$cluster,
         pch = 20, cex = 3)
    points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
  })
}



# link server and app using shiny
shinyApp(ui = ui, server = server)