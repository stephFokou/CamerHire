#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(DT)
library(shinythemes)
library(readxl)

Entertainment <- read_excel("CamerHire.xlsx", sheet = "Entertainment")
Education <- read_excel("CamerHire.xlsx", sheet = "Education")
Youtube <- read_excel("CamerHire.xlsx", sheet = "Youtube")
Online <- read_excel("CamerHire.xlsx", sheet = "Online")
All_auto <- read_excel("CamerHire.xlsx", sheet = "All Auto")
Other <- read_excel("CamerHire.xlsx", sheet = "Other")

ui <- navbarPage(
  
  theme = shinytheme(theme = "cosmo"), title = h3("Camer Hire"),
  
  tabPanel(
    h4('About'), icon = icon('question'),
    h2('This platform was created to inform the Cameroonian commuinity in the U.S. about
       goods and services offered by their fellow citizens.'),
    h2('Click on each tab above to navigate the platform'),
    h2('If you want to update or add your business, email me at rjeutong@gmail.com')
  ),
  tabPanel(
    h4('Entertainment'), icon = icon('play'),
    h2("If you have an event, don't look elsewhere... These guys are talented"), br(),
    br(),
    dataTableOutput(outputId = 'entertainment')
  ),
  tabPanel(
    h4('Education'), icon = icon('book'),
    h2("See what cameroonians have to offer in education... These might be of interest to you"),
    br(),
    dataTableOutput(outputId = 'education')
  ),
  tabPanel(
    h4('YouTube'), icon = icon('youtube'),
    h2("Subscribe to these channels. You might find something here useful"),
    br(),
    dataTableOutput(outputId = 'youtube')
  ),
  tabPanel(
    h4('Online'), icon = icon('tablet'),
    h2("Online services and stores. Check them out"),
    br(),
    dataTableOutput(outputId = 'online')
  ),
  tabPanel(
    h4('All Auto'), icon = icon('car'),
    h2("Probably one of the most important. Need a car? Need car repairs? These guys can help"),
    br(),
    dataTableOutput(outputId = 'auto')
  ),
  tabPanel(
    h4('Other Businesses'), icon = icon('money'),
    h2("Don't ignore this. There are important goods and services here"),
    br(),
    dataTableOutput(outputId = 'other')
  )
)

server <- function(input, output) {
  
  output$entertainment <- DT::renderDataTable(
    Entertainment %>% 
      datatable(options = list(pageLength = 25,
                               escape = F,
                               #autoWidth = T,
                               #scrollX=TRUE,
                               #scrollY=400,
                               #scrollCollapse=TRUE,
                               columnDefs = list(list(targets = 2, width = '20%'),
                                                 list(targets = 6, width = '150px'))),
                filter = 'top')
  )
  
  output$education <- DT::renderDataTable(
   Education %>% 
     datatable(options = list(pageLength = 25), filter = 'top')
  )
  output$youtube <- DT::renderDataTable(
    Youtube %>%
      datatable(options = list(pageLength = 25), filter = 'top')
  )
  output$online <- DT::renderDataTable(
    Online %>%
      datatable(options = list(pageLength = 25,
                               escape = F,
                               columnDefs = list(list(targets = c(2,6), width = '30%'))),
                filter = 'top')
  )
  output$auto <- DT::renderDataTable(
    All_auto %>%
      datatable(options = list(pageLength = 25), filter = 'top')
  )
  output$other <- DT::renderDataTable(
    Other %>%
      datatable(options = list(pageLength = 25,
                               escape = F,
                               columnDefs = list(list(targets = c(2,8), width = '30%'))),
                filter = 'top')
  )
}

shinyApp(ui = ui, server = server)
