
shinyUI(fluidPage(
  titlePanel("Generación de v.a. normales (0,1)"),
  sidebarLayout(
    sidebarPanel(
      h2("Instrucciones", align = "left"),
      em("Esta app sirve para simular v.a. normales estándar usando el método de Box Muller. Puedes escoger el número de observaciones simuladas y generar un histograma y densidad de las mismas. "),
      br(),
      br(),
      column(12, 
      sliderInput("n", label = h4("Número de realizaciones: ",style = "color:#E91E63"),
        min = 0, max = 100000, value = 5000)
      ),
      br(),
      br(),
      div("Fernanda Mora", style = "color:#3F51B5"),
      img(src="cloud.png", height = 150, width = 150)
      ),
    mainPanel(
      tabsetPanel(type = "tabs", 
        tabPanel("Histograma",plotOutput("hist")),
        tabPanel("Densidad",plotOutput("prueba")),
        tabPanel("Resumen de estadísticas",verbatimTextOutput("resumen")),
        tabPanel("Tabla de valores", tableOutput("tabla"))
      )
    )
  )
))