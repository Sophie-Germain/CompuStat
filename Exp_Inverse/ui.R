
library(shiny)
library(datasets)
## Interfaz gráfica
shinyUI(
  fluidPage(
    h1("Generación de variables aleatorias"),
    br(),
    br(),
    theme = "theme.css",
    sidebarLayout(
      ## Sidebar panel
      sidebarPanel(h5("María Fernanda \n Mora Alba"),
                   br(),
                   ## 
                   sliderInput(inputId = "lam",
                               label=h4(withMathJax("$$\\text{Elige el valor de}\\quad\\lambda$$")),
                               min = 0, max = 5,
                               step = .2,
                               value = 2),
                   br(),
                   sliderInput(inputId = "sim",
                               label=h4(withMathJax("$$\\text{Elige el número de realizaciones}$$")),
                               min = 100, max = 1000, value = 500),
                   br(),
                   helpText(h3("Ayuda"),"Elige el tipo de distribución que de la cual  quieres generar variables y determina el número de variables generadas")
                   
      ),
      ## Main Panel
      mainPanel(
        tabsetPanel(
          tabPanel(h3("Histograma"),
                   plotOutput("exp_hist")
          ),
          tabPanel(h3("Densidad"),
                   plotOutput("exp_dens")
          ),
          tabPanel(h3("Qqplot"),
                   plotOutput("qqplot")
          )
        )
        
      )
    )
  )
)