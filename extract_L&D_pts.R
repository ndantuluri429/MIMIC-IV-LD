# install.packages("pacman")

require(pacman)
pacman:: p_load (ggplot2, plotly, dyplr, tidyr, tidyverse, shiny, 
                 shinydashboard, tigris, sf, leaflet, readxl, zipcodeR, 
                 shinycssloaders, ggplot2) 

file_path <- "~/Downloads/drgcodes.csv" 
drgcodes <- read.csv(file_path)
glimpse(drgcodes)

unique(drgcodes$description)

# Search for only L&D stuff
matches <- drgcodes$description[grep("cesarean|delivery", drgcodes$description, ignore.case = TRUE)]
unique(matches)

# Only include L&D stuff
filtered_data <- drgcodes[grep("cesarean|delivery", drgcodes$description, ignore.case = TRUE), ]
head(filtered_data) 
dim(filtered_data)

# make L&D data its own CSV
write.csv(filtered_data, "filtered_data.csv", row.names = FALSE)
