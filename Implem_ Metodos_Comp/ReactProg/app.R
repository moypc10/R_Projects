#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(igraph)
library(stringr)

ui <- fluidPage(
  titlePanel("Project 3 Converter"),
  sidebarLayout(
    sidebarPanel(
      textAreaInput(inputId = "myinputtext", label = "Write your Regular Grammar", rows = 7, cols = 40, resize = "both")
    ),
    mainPanel(
      plotOutput("graphDFA")
    )
  )
)

server <- function(input, output) {
  output$graphDFA <- renderPlot({
    stringg <- input$myinputtext
    
    # Formatted data
    string <- str_replace_all(stringg, "(\n)|([:space:]*\n)", " ")
    
    ## Extract the edges
    edgesCompleted <- str_extract_all(string, "[A-Z] -> [a-z][A-Z]")[[1]]
    edgesFinal  <- str_extract_all(string, "([A-Z] -> [a-z][^A-Z])|[A-Z] -> [a-z](?!.*[A-Z])")[[1]]
    edgesFinalZ <- str_replace_all(edgesFinal, "(?<=[a-z])(?!$)|(?<=[a-z])$", "Z")
    
    stringUpdated <- append(edgesCompleted, edgesFinalZ)
    
    nodes <- unlist(str_extract_all(stringUpdated, "[A-Z]"))
    edge.labels <- unlist(str_extract_all(string, "[a-z]"))
    g <- graph(nodes, directed = TRUE)
    
    uniqueNodes <- unique(nodes)
    if (length(uniqueNodes) < 2) {
      node.types <- 1
    } else {
      node.types <- c(1, rep(2, length(uniqueNodes) - 2), 3)
    }
    
    mapping.colors <- c("green","white", "red")
    node.colors <- mapping.colors[node.types]
    
    curves <- curve_multiple(g, start = 0.8)
    set.seed(12)
    plot(g, edge.arrow.size = 0.3, vertex.label.cex = 0.8, vertex.size = 35,
         vertex.frame.color = "gray", vertex.label.color = "black",
         edge.label = edge.labels, vertex.color = node.colors, edge.curved = curves)
  })
}

shinyApp(ui = ui, server = server)