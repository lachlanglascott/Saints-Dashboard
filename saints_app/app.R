library(shiny)
library(shinyWidgets)
library(readxl)
library(tidyverse)
library(dplyr)
library(kableExtra)
library(lubridate)
library(scales)
library(formattable)
library(imager)
library(shinydashboard)
library(shinythemes)

ui <- fluidPage(theme=shinytheme("simplex"),
                
                tags$head(tags$style(
                    HTML('
         #sidebar {
            background-color: #28E3B4";
        }

        body, label, input, button, select { 
          font-family: "Arial";
        }')
                )),
                
                tags$style(HTML("hr {border-top: 1px solid #000000;}
                .well {height: 1200px;}")),
                
                setBackgroundColor(""),
                
                # Application title
                h1(titlePanel(" ")), align = "center",
                
                
                navbarPage(title = span( "AFL Model", style = "font-family: Arial"),
                           
                           tabPanel("Player",
                                    
                                    sidebarLayout(
                                        sidebarPanel(
                                            
                                            
                                            tags$strong(p("Select Team", style = "color:#004A6A; font-size:14px")),
                                            
                                            
                                            selectizeInput('Team', 
                                                           label = "Team", 
                                                           teams, multiple = FALSE, selected = TRUE)
                                            
                                            
                                        ),
                                        
                                        mainPanel(
                                            
                                            # Output: Tabset w/ plot, summary, and table ----
                                            tabsetPanel(type = "tabs",
                                                        
                                                        tabPanel("Ruckmen", tableOutput('ruckmen')), #Readme
                                                        
                                                        #landing page - flow model
                                                        tabPanel("Possessions", tableOutput('disposals')),
                                                        
                                                        tabPanel("Goals", tableOutput('goalscorer_round')),
                                                        
                                                        tabPanel("Fantasy", tableOutput('fantasy'))
                                                        
                                            )) #mainpanel
                                        
                                    ) #tabpanel
                           ) #sidebar
                ) #navbar
) #ui



# Define server logic required to draw a histogram
server <- function(input, output) {
    
    
}


# Run the application 
shinyApp(ui = ui, server = server)




