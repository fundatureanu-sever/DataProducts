library(shiny)
library(UsingR)
data(galton)

shinyServer(
  function(input, output, session) {
    
    modelFit <- reactive({
        x <- airquality[,input$xaxis]
        lm(airquality$Temp ~ x)
    })
    
    modelPrediction <- reactive({
        fit <- modelFit()
        predict(fit, newdata=data.frame(x=input$xvalue))
    })
    
    output$newPlot <- renderPlot({
      plot(airquality[,input$xaxis], airquality$Temp,
           ylab="Temperature", xlab=input$xaxis)
      abline(modelFit(), col="blue")  
      points(input$xvalue, modelPrediction(), col = "red", pch = 10)
      abline(h=modelPrediction(), col="red")
      abline(v=input$xvalue, col="red")
    })
    
    observe({
        xRange <- range(airquality[,input$xaxis], na.rm=TRUE)
        updateSliderInput(session, 'xvalue', value = xRange[2]/2, 
                          min=xRange[1], max=xRange[2], step = 0.05)
    })
    
    output$prediction <- renderText({
        modelPrediction()
    })
  }
)
