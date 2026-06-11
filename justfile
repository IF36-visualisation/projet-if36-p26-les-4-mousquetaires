default:
    @just --list

shiny:
    Rscript -e 'shiny::runApp("shiny", launch.browser = TRUE)'

deps:
    Rscript -e 'pkgs <- c("tidyverse", "shiny", "shinydashboard", "countrycode", "rnaturalearth", "rnaturalearthdata", "sf"); install.packages(setdiff(pkgs, rownames(installed.packages())), repos = "https://cloud.r-project.org")'

rapport:
    Rscript -e 'rmarkdown::render("rapport.Rmd")'
