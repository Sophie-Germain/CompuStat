library(shiny)
library(nortest)

# Define server logic required to draw a histogram
shinyServer(
  function(input, output)
  {
    
    #Generamos las normales como data reactivo
    data <- reactive({ 
      size = input$n
      u1 <- runif(size)
      u2 <- runif(size)
      x <- sqrt(-2*log(u1))*cos(2*pi*u2)
      y <- sqrt(-2*log(u1))*sin(2*pi*u2)
      
      c(x,y)
    })
    
    
    #graficamos la densidad
    output$prueba <- renderPlot({  
      lillie.test(data())
      plot(density(data()), main=paste('Densidad de simulaciones normales'))
   })
    
    output$hist <- renderPlot({
      hist(data(), main=paste('Histograma de simulaciones normales'))
    })
    
    output$resumen <- renderPrint({
      summary(data())
    })
    
    output$tabla <- renderTable({
      data.frame(x=data())
    })

  })
