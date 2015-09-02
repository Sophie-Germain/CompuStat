library(shiny)
library(nortest)

shinyServer(
  function(input, output)
  {
    
    #Generamos el cálculo que hay que imprimir
    valor <- reactive({ 
      
  
      #número de normales
      n = input$n
      
      #consideremos 10000 observaciones uniformes
      sim = runif(100000, min = -2, max = 2)
      
      monte <- function(sim,n){
        #usamos la densidad uniforme y la completamos para poder usarla para el calculo
        result = 1/sqrt(2*pi)*exp(-1/2*sim^2)*4
        media = mean(result)
        varianza = sd(result)
        lista<-list(media = media^n, var = varianza^n)
        lista
      }
      
      trapecio <- function(sim,n){
        result <- rnorm(n, mean=0, sd=1)
        result2 <- 1/sqrt(2*pi)*exp(-1/2*result^2)
        calc = 1/(2*n)*sum((result2[2:n] + result2[1:(n-1)]))
        return(calc)
      }
    
      
      riemann <- function(sim,n){
        result <- rnorm(n, mean=0, sd=1)
        result2 <- 1/sqrt(2*pi)*exp(-1/2*result^2)
        calc = 1/(n)*sum(result2[1:(n-1)])
        return (calc)
      }
      
      
      integral <- switch(input$metodo,
                         "m" = monte,
                         "t" = trapecio,
                         "r" = riemann)
    
        
      integral(sim, input$n)
      
    })
    
    #nuevo panel
    valor2 <- reactive({ 
      
      #número de observaciones
      m = input$m
      
      
  
      montef1 <- function(m){
        #usamos la densidad uniforme y la completamos para poder usarla para el calculo
        sim2 <- runif(m, min = 0, max = 2)
        result = sqrt(4-sim2^2)*2
        media = mean(result)
        return(media)
      }
      
      montef2 <- function(m){
        sim2 <- runif(m, min = 0, max = 1)
        #usamos la densidad uniforme y la completamos para poder usarla para el calculo
        result = 4/(1+sim2^2)
        media = mean(result)
        return(media)
      }
      
      montef3 <- function(m){
        #usamos la densidad uniforme y la completamos para poder usarla para el calculo
        sim2 <- runif(m, min = 0, max = 1)
        result = 6/ sqrt(4-sim2^2)
        media = mean(result)
        return(media)
      }
      
      integral <- switch(input$metodo2,
                        "f1"=montef1, "f2"=montef2, "f3"=montef3)
      
      integral(input$m)
      
    })
    
    
    #estimacion integral
    output$est2 <- renderPrint({
      v <- valor2()
      v
    })
    
    
    
    #estimacion integral
    output$est <- renderPrint({
     v <- valor()
     v[[1]]
    })
    
    #intervalos de confianza
    output$int <- renderPrint({
      if(input$metodo=="m"){
        v <- valor()
        u <- v[[1]] - 1.645*v[[2]]
        l <- v[[1]] + 1.645*v[[2]]
      print(paste("El intervalo de confianza al 95% por el Método de Montecarlo es: ","(",u,l,")", sep = " "))
      }else{
        "No hay intervalo de confianza para este método"
      }
    })
    
    
    
    #grafica error
    output$error <- renderPlot({
      if(input$metodo=="m"){
      error<-c()
      real<-0.9545^input$n
      for(i in 1:1000)
      {
        sim = runif(i, min = -2, max = 2)
        result = 1/sqrt(2*pi)*exp(-1/2*sim^2)*4
        media = mean(result)
        error[i]<-media^input$n-real
      }
      plot(seq(1,1000), error, main="Error de estimación por MonteCarlo", xlab="Número de simulaciones")
      }
      else{""}
    })
    
   
  })