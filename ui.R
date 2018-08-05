ui <- fluidPage(
  
  # App title ----
  titlePanel("News API browser"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      textInput("keyword", "Keyword", "bitcoin"),
      radioButtons("newstype", "News type:",
                   c("Top headlines" = "top-headlines",
                     "Everything" = "everything")),
      checkboxGroupInput("sources", "Sources:",
                         c("ABC" = "abc-news",
                           "BBC" = "bbc-news",
                           "CNN" = "cnn",
                           "NYTimes" = "the-new-york-times",
                           "Time" = "time",
                           "Wired" = "wired")),
      checkboxGroupInput("variable", "Variables to show:",
                         c(
                           "Description" = "Description",
                           "Published At" = "Published",
                           "Source" = "Source",
                           "URL" = "URL"))
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      DT::dataTableOutput("mytable")

      
    )
  )
)