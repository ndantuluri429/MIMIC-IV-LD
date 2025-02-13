require(pacman)
pacman:: p_load (ggplot2, plotly, dyplr, tidyr, tidyverse, shiny, 
                 shinydashboard, tigris, sf, leaflet, readxl, zipcodeR, 
                 shinycssloaders, ggplot2) 

# load filtered_data
labor_deliv <- "~/Downloads/filtered_data.csv" 
labor_deliv_drgs <- read.csv(labor_deliv)

# count # of obstetric patients 
obstetric_pts <- labor_deliv_drgs %>% 
  summarise(n_unique = n_distinct(subject_id))
print(obstetric_pts) # 14327 patients!