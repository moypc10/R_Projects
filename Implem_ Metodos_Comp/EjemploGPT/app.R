library(shiny)
library(igraph)
library(stringr)

ui <- fluidPage(
  titlePanel("Project 3 Converter"),
  sidebarLayout(
    sidebarPanel(
      textAreaInput(inputID="RG", "Write your Regular Grammar", rows = 7, cols = 40, resize = "both")
    ),
    mainPanel(
      # Otros elementos de la interfaz de usuario
    )
  )
)

server <- function(input, output) {
  # Funciones del servidor
}

shinyApp(ui = ui, server = server)