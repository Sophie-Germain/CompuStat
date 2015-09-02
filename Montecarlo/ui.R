shinyUI(fluidPage(
  titlePanel("App para estimación de integrales"),
  sidebarLayout(
    
    sidebarPanel(
      tabsetPanel(
        tabPanel("Integracion multivariada",
      h2("Instrucciones", align = "left"),
      em("Esta app sirve para ejemplificar tres diferentes métodos de integración: Riemann, Trapecio e integracion Montecarlo para la integral en donde cada observación es N(0,1): "),
      h5(withMathJax("$$ \\displaystyle\\idotsint_{-2}^{2} \\frac{1}{(2\\pi) ^{n/2} } e^ \\frac{-x^{T}x}{2} \\,du_1 \\dots du_n$$  ")),
      br(),
      br(),
      selectInput("metodo", "Método de integración:",
                  c("MonteCarlo" = "m",
                    "Trapecio" = "t",
                    "Riemann" = "r")),
      
      column(12, 
             sliderInput("n", label = h4("Número de normales a considerar: ",style = "color:#E91E63"),
                         min = 1, max = 20, value = 5)
      ),
      br(),
      br(),
      br(),
      br(),
      br(),
      div("Fernanda Mora", style = "color:#3F51B5"),
      img(src="cloud.png", height = 150, width = 150)
        ),
      tabPanel("Integracion Montecarlo",
               
               h6(withMathJax("$$ 1. \\int_{0}^{2} \\sqrt{4-x^2} dx $$  ")),
               h6(withMathJax("$$ 2. \\int_{0}^{1} \\frac{4}{1+x^2} dx $$")),
               h6(withMathJax("$$ 3. \\int_{0}^{1} \\frac{6}{\\sqrt{4-x^2}} dx $$")),
               
               selectInput("metodo2", "Función a integrar:",
                           c("1" = "f1",
                             "2" = "f2",
                             "3" = "f3")),
               
               column(12, 
                      sliderInput("m", label = h4("Número de observaciones para estimar la integral seleccionada: ",style = "color:#E91E63"),
                                  min = 1, max = 10000, value = 5)
               ),
               br(),
               br(),
               br(),
               br(),
               br(),
               br(),
               br(),
               br()
               
               
               )
      )
    ),
    
    
    mainPanel(
      tabsetPanel(
        tabPanel( "Resultados Integracion multivariada",
                h4("El valor de la integral por el método seleccionado es: "),  
                verbatimTextOutput("est"),
                verbatimTextOutput("int"),
                plotOutput("error")
        ),
        tabPanel("Resultados 3 Integrales Montecarlo",
                 h4("El valor de la integral seleccionada por MonteCarlo es: "),
                 verbatimTextOutput("est2")
                 
                 )
      )
                
      )
    )
  )
)