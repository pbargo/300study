#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


library(shiny)

# By default, the file size limit is 5MB. It can be changed by
# setting this option. Here we'll raise limit to 9MB.
options(shiny.maxRequestSize = 9*1024^2)

shinyServer(function(input, output,session) {
  mydata <- reactive({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    
      read.csv(inFile$datapath, header = input$header,
               sep = input$sep, quote = input$quote)
    
  })
  observe({
    updateSelectInput(session, 'x', 'X-axis', choices = names(mydata()))
    })
  observe({
    updateSelectInput(session, 'y', 'Y-axis', choices = names(mydata()))
  })

  #   output$contents <- renderTable({
  #   # input$file1 will be NULL initially. After the user selects
  #   # and uploads a file, it will be a data frame with 'name',
  #   # 'size', 'type', and 'datapath' columns. The 'datapath'
  #   # column will contain the local filenames where the data can
  #   # be found.
  #   
  #   mydata <- mydata()
  #   
  # })
  output$myPlot <- renderPlot({
    mydata <- mydata()
    if (is.null(mydata))
      return(NULL)
    if (input$x == "")
      return (NULL)
    
    if (input$anatSite == '') {
      mydataSub <- mydata
      mytitle <- 'All'}
    else {
      mydataSub <- subset(mydata, site  == input$anatSite)
      mytitle <- toString(input$anatSite)}

    string <- paste0("mydataSub$",input$x)
    x <- eval(parse(text=string))
    string <- paste0("mydataSub$",input$y)
    y <- eval(parse(text=string))
    
    if (is.numeric(x) && is.numeric(y)) {
      plot(x,y, xlab = toString(input$x), ylab = toString(input$y), main = mytitle)
      abline(lm(y~x), col = 'red')
  }
    else if (is.factor(x) && is.numeric(y)) {
      a <- input$x
      b <- input$y
      string <- paste0("mydataSub$",input$x)
      colors <- rainbow(length(unique(eval(parse(text=string)))))
      boxplot(eval(parse(text=paste0(b,'~',a))),data = mydataSub, 
              xlab = toString(input$x), ylab = toString(input$y), col = colors, main = mytitle)
  }
  })
})