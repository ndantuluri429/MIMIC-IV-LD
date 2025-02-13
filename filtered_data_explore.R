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

# look at clinical notes for each patient
discharge <- "~/Downloads/discharge.csv" 
discharge_notes <- read.csv(discharge)

# merge drg description & clinical notes
LD_notes <- discharge_notes %>% 
  select(subject_id, text)
labor_deliv_notes <- left_join(labor_deliv_drgs, LD_notes, by = "subject_id")

# include desired columns
clean_LD_notes <- labor_deliv_notes %>% 
  select(subject_id, drg_code, description, text)
dim(clean_LD_notes)

merged_data <- clean_LD_notes %>%
  group_by(subject_id) %>%
  summarise(
    drg_code   = paste(unique(drg_code), collapse = ", "),
    description = paste(unique(description), collapse = ", "),
    text       = paste(unique(text), collapse = "\n")
  ) %>%
  ungroup()
# dim(merged_data) # 14327! 
# head(merged_data$text) # glimpse clincial notes for each patient