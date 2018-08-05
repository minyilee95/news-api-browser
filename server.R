library(shiny)
library(DT)
library(httr)
library(tidytext)
library(stringr)
library(tidyverse)
NEWSAPI_KEY <- "YOUR API KEY GOES HERE" #<- YOUR API KEY HERE


getDF <- function(r) {
  if (r$totalResults > 0 ) {
    titles = c()
    descriptions = c()
    publishedAt = c()
    sourceNames = c()
    urls = c()
    for (i in c(1:length(r$articles))) {
      titles = c(titles, r$articles[[i]]$title)
      descriptions = c(descriptions, r$articles[[i]]$description)
      publishedAt = c(publishedAt, r$articles[[i]]$publishedAt)
      sourceNames = c(sourceNames, r$articles[[i]]$source$name)
      urls = c(urls, paste0("<a href='",r$articles[[i]]$url,"'>",r$articles[[i]]$url,"</a>"))
      
    }
    return(data_frame(Title = titles, Description = descriptions, Published = publishedAt, Source = sourceNames, URL = urls))
  } else {
    #not sure how to better handle the case where there are 0 results
    return(data_frame(Title = c("No Results Found, Sorry!"), Description = c(""), Published = c(""), Source = c(""), URL = c("")))
  }
}


server <- function(input, output) {
  df <- reactive({
    sources = paste(input$sources,collapse=",")
    url = paste("https://newsapi.org/v2/", input$newstype, "?q=", input$keyword, "&sources=",sources, "&pageSize=50&language=en&apiKey=", NEWSAPI_KEY, sep = "")
    print(url)
    r <- GET(url)
    warn_for_status(r)
    r <- content(r, "parsed")
    getDF(r)
  })
  
  output$mytable =     DT::renderDataTable({
    df()[,c("Title", input$variable), drop = FALSE]
  }, escape = FALSE)
}
