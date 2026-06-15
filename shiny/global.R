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

centroids_iso <- centroids %>%
  mutate(iso3 = countrycode(name, "country.name", "iso3c")) %>%
  filter(!is.na(iso3)) %>%
  select(iso3, lon, lat)

bill_by_country <- data %>%
  filter(country != "") %>%
  mutate(iso3 = countrycode(country, "country.name", "iso3c")) %>%
  filter(!is.na(iso3)) %>%
  count(country, iso3, name = "n") %>%
  left_join(centroids_iso, by = "iso3") %>%
  filter(!is.na(lon), !is.na(lat))

pays_choices <- sort(unique(bill_by_country$country))

gen_levels <- c(
  "Génération GI\n(avant 1928)",
  "Génération silencieuse\n(1928–1945)",
  "Baby-Boomers\n(1946–1964)",
  "Génération X\n(1965–1980)",
  "Millennials\n(1981–1996)",
  "Génération Z\n(1997–2012)"
)

gen_data <- data %>%
  filter(!is.na(birthYear)) %>%
  mutate(
    gender   = recode(gender, "M" = "Hommes", "F" = "Femmes"),
    selfMade = ifelse(as.logical(selfMade), "Self-made", "Héritier"),
    generation = case_when(
      birthYear >= 1997 & birthYear <= 2012 ~ gen_levels[6],
      birthYear >= 1981 & birthYear <= 1996 ~ gen_levels[5],
      birthYear >= 1965 & birthYear <= 1980 ~ gen_levels[4],
      birthYear >= 1946 & birthYear <= 1964 ~ gen_levels[3],
      birthYear >= 1928 & birthYear <= 1945 ~ gen_levels[2],
      birthYear <  1928                     ~ gen_levels[1],
      TRUE ~ NA_character_
    )
  ) %>%
  filter(!is.na(generation)) %>%
  mutate(generation = factor(generation, levels = gen_levels))
