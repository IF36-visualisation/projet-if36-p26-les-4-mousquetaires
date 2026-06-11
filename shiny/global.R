library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(countrycode)
library(rnaturalearth)
library(sf)

sf_use_s2(FALSE)

data <- read.csv("../data/Billionaires_Statistics_Dataset.csv", fileEncoding = "UTF-8-BOM")

ages <- data %>%
  filter(!is.na(age)) %>%
  mutate(
    gender = recode(gender, "M" = "Hommes", "F" = "Femmes"),
    selfMade = ifelse(as.logical(selfMade), "Self-made", "Héritier")
  )

industries_choices <- c("Toutes", sort(unique(ages$industries)))

ne_recode <- c(
  "United States" = "United States of America",
  "St. Kitts & Nevis" = "St. Kitts and Nevis",
  "Hong Kong SAR China" = "Hong Kong",
  "Macao SAR China" = "Macao",
  "British Virgin Islands" = "British Virgin Is.",
  "Turks & Caicos Islands" = "Turks and Caicos Is.",
  "Cayman Islands" = "Cayman Is."
)

mvt_bill <- data %>%
  filter(country != "", countryOfCitizenship != "") %>%
  mutate(
    country = tolower(country),
    countryOfCitizenship = tolower(countryOfCitizenship)
  ) %>%
  filter(country != countryOfCitizenship) %>%
  select(country, countryOfCitizenship) %>%
  mutate(
    country = countrycode(country, "country.name", "country.name"),
    countryOfCitizenship = countrycode(countryOfCitizenship, "country.name", "country.name")
  ) %>%
  count(country, countryOfCitizenship, name = "volume") %>%
  mutate(
    country = recode(country, !!!ne_recode),
    countryOfCitizenship = recode(countryOfCitizenship, !!!ne_recode)
  )

world <- ne_countries(scale = 110, returnclass = "sf")

centroids <- world %>%
  select(name, geometry) %>%
  st_centroid() %>%
  mutate(
    lon = st_coordinates(geometry)[, 1],
    lat = st_coordinates(geometry)[, 2]
  ) %>%
  st_drop_geometry()

flux_geo <- mvt_bill %>%
  left_join(centroids, by = c("country" = "name")) %>%
  rename(to_lon = lon, to_lat = lat) %>%
  left_join(centroids, by = c("countryOfCitizenship" = "name")) %>%
  rename(from_lon = lon, from_lat = lat) %>%
  filter(!is.na(to_lon), !is.na(from_lon))

destinations_choices <- c("Tous", sort(unique(flux_geo$country)))
