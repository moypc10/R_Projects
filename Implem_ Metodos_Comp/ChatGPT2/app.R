#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Mi Dashboard"),
  dashboardSidebar(
    # Controles y elementos del sidebar
  ),
  dashboardBody(
    # Elementos principales del dashboard
  )
)

server <- function(input, output) {
  # Funciones del servidor
}

shinyApp(ui = ui, server = server)