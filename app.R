#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library(brio)
library(waldo)
library(shiny)

readRDS("predictor.rds")

source("Stupid back off model.R")


# Define UI for application
ui <- fluidPage(

    # Application title
    titlePanel("Word Prediction App"),

    # Sidebar with input field and submit button
    sidebarLayout(
        sidebarPanel(
            textInput("text", label = "Please enter your phrase here:", value = "Hi, how are"),
            submitButton("Submit")
        ),

        # Output table
        mainPanel(
           dataTableOutput("table")
        )
    )
)

# Define server logic
server <- function(input, output) {

    output$table <- renderDataTable({
        library(stats)
        
        predictions <- stats::predict(predictor, input$text)
        predictions <- data.frame(predictions, stringsAsFactors = FALSE)
        names(predictions) <- c("Predictions")
        predictions
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
