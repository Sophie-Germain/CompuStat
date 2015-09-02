
library(shiny)
library(ggplot2)
shinyServer(function(input, output) {
  output$exp_hist <- renderPlot({
    exp <- data.frame(value = rexp(n = input$sim, rate = input$lam),
                      label = rep("exp", input$sim))
    sim <- data.frame(value = -log(runif(input$sim))/input$lam,
                      label = rep("sim", input$sim))
    data <- rbind(exp, sim)
    ggplot(data, aes(x = value, fill = label)) +
      geom_histogram(alpha = .7) +
      theme(panel.background = element_blank(),
            axis.text = element_text(colour = "#1565C0"),
            axis.title = element_text(colour = "#1565C0"),
            legend.title = element_text(colour = "#1565C0")) +
      scale_fill_manual(name = "Distribución",
                        values = c("#1565C0","#2196F3"))
  })
  
  output$exp_dens <- renderPlot({
    exp <- data.frame(value = rexp(n = input$sim, rate = input$lam),
                      label = rep("exp", input$sim))
    sim <- data.frame(value = -log(runif(input$sim))/input$lam,
                      label = rep("sim", input$sim))
    data <- rbind(exp, sim)
    ggplot(data, aes(x = value, fill = label)) +
      geom_density(alpha = .7) +
      theme(panel.background = element_blank(),
            axis.text = element_text(colour = "#1565C0"),
            axis.title = element_text(colour = "#1565C0"),
            legend.title = element_text(colour = "#1565C0")) +
      scale_fill_manual(name = "Distribución",
                        values = c("#1565C0","#2196F3"))
  })
  
  output$qqplot <- renderPlot({
    data  <- data.frame(value = -log(runif(input$sim))/input$lam,
                        label = rep("sim", input$sim))
    ggplot(data, aes(sample = value)) +
      stat_qq(alpha = .7, col = "#1565C0") +
      theme(panel.background = element_blank(),
            axis.text = element_text(colour = "#1565C0"),
            axis.title = element_text(colour = "#1565C0"),
            legend.title = element_text(colour = "#1565C0")) 
  })
})