library(shiny)

# Note: adapted from Tabsets (https://shiny.rstudio.com/gallery/tabsets.html)
# and Iris k-means clustering (https://shiny.rstudio.com/gallery/kmeans-example.html)
# sample Shiny apps

# Define UI for gene visualizer ----
ui <- fluidPage(

    # App title ----
    titlePanel("nsSNPHotspotViewer"),

    # Sidebar layout with input and output definitions ----
    sidebarLayout(

        # Sidebar panel for inputs ----
        sidebarPanel(

            # Input: Enter minCounts for query
            numericInput('minCounts', 'Filter minimal SNP count', 0, min = 0),

            # Input: Enter minLength for query
            numericInput('minLength', 'Filter minimal gene length', 0, min = 0),

            # Input: Enter sorting priority for queried hits
            selectInput('sortBy', 'Sort queried hits by:',
                        c('counts', 'length', 'none')),

            # br() element to introduce extra vertical spacing ----
            br(),

            # Input: String input for visualized gene ID ----
            textInput('id', "Gene ID to visualize:")

        ),

        # Main panel for displaying outputs ----
        mainPanel(

            # Output: Tabset w/ plot, summary, and table ----
            tabsetPanel(type = "tabs",
                        tabPanel("Plot", plotOutput("plot")),
                        tabPanel("Query", tableOutput("table")),
                        tabPanel("Visualization", plotOutput("geneVis"))
            )
        )
    )
)

# Define server logic for gene visualizer ----
server <- function(input, output) {

    # Reactive elements
    minCounts <- reactive(input$minCounts)
    minLength <- reactive(input$minLength)
    target <- reactive(input$id)
    sortBy <- reactive(input$sortBy)

    # Generate population plot
    output$plot <- renderPlot({
        plotPopulation(snpPositions)
    })

    # Generate an HTML table view of the data ----
    output$table <- renderTable({
        countsData <- getSNPCounts(snpPositions)
        queryCounts(countsData, minLength=minLength(), minCounts=minCounts(), sortBy=sortBy())
    })

    # Generate a visualization of the target gene
    output$geneVis <- renderPlot({
        if (target() != "") {
            gene <- initializeGene(target(), snpPositions)
            visualizeGene(gene)
        }
    })
}

# Create Shiny app ----
shinyApp(ui, server)
