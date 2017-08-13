library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Predict Temperature using Air Quality Dataset"),

  sidebarPanel(
    h3('Guidelines'),
    p('This app plots and predicts temperature based
        on either Ozone, Solar Radiation or Wind. The user can choose the variable
        to use as input for the model using the radio buttons below. Additionally he
        can choose a value used as input in the prediction'),
    
    h3('Input'),
    radioButtons("xaxis", "Choose x variable:",
                 c("Ozone"="Ozone", "Solar Radiation"="Solar.R", "Wind"="Wind")),
    sliderInput('xvalue', 'Choose x value for prediction:',value = 70, 
                min = 1, max = 168, step = 0.05)
  ),
  mainPanel(
    h3("Predicted temperature for chosen x"),
    textOutput('prediction'),
    
    plotOutput('newPlot')
  )
))
