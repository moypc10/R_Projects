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
library(magrittr)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Project 3 Converter"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Regular Grammar", tabName = "option1", icon = icon("spell-check")),
      menuItem("Transicions", tabName = "option2", icon = icon("circle-xmark"))
    )
  ),
  dashboardBody(
    tabItems(
      # Option1 ----------------------------------------------------------------------
      tabItem(tabName = "option1",
              h2("Regular Grammar"),
              textAreaInput(inputId = "myinputtext", label = "Write your Regular Grammar", rows = 7, cols = 40, resize = "both"),
              plotOutput("graphDFA")
      ),
      
      # Option2 ----------------------------------------------------------------------
      tabItem(tabName = "option2",
              h2("Transicions"),
              textAreaInput(inputId = "myinputtext2", label = "Write your Regular Grammar", rows = 7, cols = 40, resize = "both"),
              plotOutput("graphDFA2")
      )
    )
  )
)

server <- function(input, output) {
  output$graphDFA <- renderPlot({
    string <- input$myinputtext
    
    # Formatted data
    string <- str_replace_all(string, "(\n)|([:space:]*\n)", " ")
    
    ## Extract the edges
    edgesCompleted <- str_extract_all(string, "[A-Z] -> [a-z][A-Z]")[[1]]
    edgesFinal  <- str_extract_all(string, "([A-Z] -> [a-z][^A-Z])|[A-Z] -> [a-z](?!.*[A-Z])")[[1]]
    edgesFinalZ <- str_replace_all(edgesFinal, "(?<=[a-z])(?!$)|(?<=[a-z])$", "Z")
    
    stringUpdated <- append(edgesCompleted, edgesFinalZ)
    
    nodes <- unlist(str_extract_all(stringUpdated, "[A-Z]"))
    edge.labels <- unlist(str_extract_all(stringUpdated, "[a-z]"))
    g <- graph(nodes, directed = TRUE)
    
    uniqueNodes <- unique(nodes)
    nodeTypes <- c()
    for(node in uniqueNodes){
      if(node == "S"){
        nodeTypes <- nodeTypes %>% append(1)
      } else if (node == "Z"){
        nodeTypes <- nodeTypes %>% append(3)
      }
      else {
        nodeTypes <- nodeTypes %>% append(2) 
      }
    }
    
    if (!("S" %in% uniqueNodes)) {
      nodeTypes <- nodeTypes[-1]
      nodeTypes <- append(nodeTypes, 1, after= 0)
    }
    
    node.types <- nodeTypes
    mapping.colors <- c("green","white", "red")
    node.colors <- mapping.colors[node.types]
    
    curves <- curve_multiple(g, start = 0.9)
    set.seed(12)
    plot(g, edge.arrow.size = 0.5, vertex.label.cex = 0.8, vertex.size = 35,
         vertex.frame.color = "gray", vertex.label.color = "black",
         edge.label = edge.labels, vertex.color = node.colors, edge.curved = curves)
  })
  
  #Opcion2-------------------------------------------------------------
  
  output$graphDFA2 <- renderPlot({
    string <- input$myinputtext2
    
    string <- str_replace_all(string, "(\n)|([:space:]*\n)", " ")
    
    ## Extract edges
    string <- str_replace_all(string, "(\n)|([:space:]*\n)", " ")
    string <- str_replace_all(string, "(\n)|([:space:]*\n)", " ")
    string <- str_replace_all(string, "(\n)|([:space:]*\n)", " ")
    
    ## Extract edges
    edgesCompleted <- str_extract_all(string, "\\([A-Z],[A-Z],[a-z]\\)")[[1]]
    edgesFinal <- str_extract_all(string, "\\([A-Z],[A-Z]\\.,([a-z]|.)\\)")[[1]]
    string <- append(edgesCompleted, edgesFinal)
    
    ## Extract nodes
    coupleNodesCompleted <- unlist(str_extract_all(edgesCompleted, "[A-Z]"))
    coupleNodesFinal <- unlist(str_extract_all(edgesFinal, "(?!S)[A-Z]"))
    nodesFinal <- gsub("\\.","",unique(unlist(str_extract_all(edgesFinal, "(?!S)[A-Z]\\."))))
    nodes <- append(coupleNodesCompleted, coupleNodesFinal)
    uniqueNodes <- unique(nodes)
    
    ## Number of nodes
    nNodesCompleted <- length(unique(unlist(str_extract_all(edgesCompleted, "(?!S)[A-Z]"))))
    nNodesFinal <- length(gsub("\\.","",unique(unlist(str_extract_all(edgesFinal, "(?!S)[A-Z]\\.")))))
    
    ## Alphabet
    uniqueAlphabet <- unique(unlist(str_extract_all(string, "[a-z]")))
    nAlphabet <- length(uniqueAlphabet)
    
    nodeTypes <- c()
    for(node in uniqueNodes){
      if(node == "S"){
        nAlphabetCheck = 0
        for(alphabet in uniqueAlphabet){
          if((sum(grepl(paste("S,[A-Z].?,[", alphabet, "]", sep = ""), string))) == TRUE){
            nAlphabetCheck = nAlphabetCheck + 1  
          } 
        }
        if(nAlphabetCheck == nAlphabet){
          nodeTypes <- nodeTypes %>% append(1)
        } else {
          nodeTypes <- nodeTypes %>% append(4)  
        } 
        
      } else if (node %in% nodesFinal){
        nAlphabetCheck = 0
        for(alphabet in uniqueAlphabet){
          if(sum(grepl(paste(node, ",[A-Z].?,[", alphabet, "]", sep = ""), string)) == TRUE){
            nAlphabetCheck = nAlphabetCheck + 1
          }
        }
        if(nAlphabetCheck == nAlphabet){
          nodeTypes <- nodeTypes %>% append(3)  
        } else {  
          nodeTypes <- nodeTypes %>% append(4)
        }
      }
      else {
        nAlphabetCheck = 0
        for(alphabet in uniqueAlphabet){
          if(sum(grepl(paste(node, ",[A-Z].?,[", alphabet, "]", sep = ""), string)) == TRUE){
            nAlphabetCheck = nAlphabetCheck + 1
          }
        }
        if(nAlphabetCheck == nAlphabet){
          nodeTypes <- nodeTypes %>% append(2) 
        } else {  
          nodeTypes <- nodeTypes %>% append(4)
        }
      }
    }
    
    node.types <- nodeTypes
    g <- graph(nodes, directed = TRUE)
    
    edge.labels <- gsub("-","λ",unlist(str_extract_all(string, "[a-z]|-")))
    
    #if λ
    if ("λ" %in% edge.labels) {
      posiciones <- which(edge.labels == "λ")  # Obtener las posiciones de "λ"
      
      for (pos in posiciones) {
        pos <- (pos * 2) - 1  # Calcular la nueva posición
        
        poss <- 1  # Reiniciar la variable poss
        
        for (poss in 1:length(uniqueNodes)) {
          if (nodes[pos] == uniqueNodes[poss]) {
            break
          }
          poss <- poss + 1
        }
        
        # Checar si el nodo en esa posición es igual a 4
        if (nodeTypes[poss] == 4) {
          # Si es así, cambiarlo a 5
          nodeTypes <- nodeTypes[-poss]
          nodeTypes <- append(nodeTypes, 5, after = poss - 1)
        } else {
          # Si no, cambiarlo a 4
          nodeTypes <- nodeTypes[-poss]
          nodeTypes <- append(nodeTypes, 4, after = poss - 1)
        }
      }
    }
    
    node.types <- nodeTypes
    g <- graph(nodes, directed = TRUE)
    
    mapping.colors <- c("green","white", "red", "yellow", "orange")
    node.colors <- mapping.colors[node.types]
    
    curves <- curve_multiple(g, start = 0.8)
    set.seed(10)
    plot(g, edge.arrow.size=.3, vertex.label.cex=0.8, vertex.size=35,vertex.frame.color="gray", vertex.label.color="black",  edge.label = edge.labels, vertex.color = node.colors, edge.curved=curves )
  })
}

shinyApp(ui = ui, server = server)