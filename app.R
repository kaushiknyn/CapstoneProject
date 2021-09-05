#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

readRDS("predictor.rds")
library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Word Prediction App"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            textInput("text", label = "Please enter your phrase here:", value = "Hi, how are"),
            submitButton("Submit")
        ),

        # Show a plot of the generated distribution
        mainPanel(
           dataTableOutput("table")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$table <- renderDataTable({
        predictions <- predict(predictor, input$text)
        predictions <- data.frame(predictions, stringsAsFactors = FALSE)
        names(predictions) <- c("Predictions")
        predictions
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
