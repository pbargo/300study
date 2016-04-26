#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  sidebarLayout(
    sidebarPanel(
      titlePanel("Uploading Files"),
      wellPanel(
      fileInput('file1', 'Choose file to upload',
                accept = c(
                  'text/csv',
                  'text/comma-separated-values',
                  'text/tab-separated-values',
                  'text/plain',
                  '.csv',
                  '.tsv'
                )
      ),
      tags$hr(),
      checkboxInput('header', 'Header', TRUE),
      splitLayout(
        radioButtons('sep', 'Separator',
                   c(Comma=',',
                     Semicolon=';',
                     Tab='\t'),
                   ','),
        radioButtons('quote', 'Quote',
                   c(None='',
                     'Double'='"',
                     'Single'="'"),
                   '"')
      )
      ),
      titlePanel("Choose plotting variables"),
      wellPanel(
        strong('Define the variable to plot'),
               selectInput('x', 'X-axis',
                           c("")),
               selectInput('y', 'Y-axis',
                           c(""))
      ),
      titlePanel("Filter anatomic site"),
      wellPanel(
        radioButtons('anatSite', 'Choose Site:',
                     c('All' = '',
                       'Arm'='A',
                       'Left Face'='L',
                       'Right Face'='R'),
                     '')
      )
    ),
    mainPanel(
      plotOutput('myPlot'),
      tableOutput('contents')
      
    )
  )
))
