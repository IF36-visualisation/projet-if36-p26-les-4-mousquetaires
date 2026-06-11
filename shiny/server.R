server <- function(input, output) {

  ages_filtre <- reactive({
    res <- ages %>% filter(gender %in% input$genres)
    if (input$origine != "Tous") {
      res <- res %>% filter(selfMade == input$origine)
    }
    if (input$industrie != "Toutes") {
      res <- res %>% filter(industries == input$industrie)
    }
    res
  })

  output$nb_milliardaires <- renderValueBox({
    valueBox(
      nrow(ages_filtre()), "Milliardaires affichés",
      icon = icon("users"), color = "blue"
    )
  })

  output$age_moyen <- renderValueBox({
    valueBox(
      round(mean(ages_filtre()$age), 1), "Âge moyen",
      icon = icon("cake-candles"), color = "green"
    )
  })

  output$age_median <- renderValueBox({
    valueBox(
      median(ages_filtre()$age), "Âge médian",
      icon = icon("scale-balanced"), color = "yellow"
    )
  })

  output$hist_ages <- renderPlot({
    validate(need(nrow(ages_filtre()) > 0, "Aucun milliardaire ne correspond aux filtres sélectionnés."))

    ggplot(ages_filtre(), aes(x = age)) +
      geom_histogram(
        binwidth = input$binwidth,
        fill = "darkblue",
        color = "white"
      ) +
      labs(
        title = "Répartition de l'âge des milliardaires en 2023",
        x = "Âge",
        y = "Nombre de milliardaires"
      ) +
      theme_minimal(base_size = 15)
  })

  flux_filtre <- reactive({
    res <- flux_geo %>% filter(volume >= input$volume_min)
    if (input$destination != "Tous") {
      res <- res %>% filter(country == input$destination)
    }
    res
  })

  output$nb_flux <- renderValueBox({
    valueBox(
      nrow(flux_filtre()), "Flux affichés",
      icon = icon("arrows-turn-to-dots"), color = "blue"
    )
  })

  output$nb_migrants <- renderValueBox({
    valueBox(
      sum(flux_filtre()$volume), "Milliardaires expatriés concernés",
      icon = icon("plane"), color = "green"
    )
  })

  output$carte_flux <- renderPlot({
    validate(need(nrow(flux_filtre()) > 0, "Aucun flux ne correspond aux filtres sélectionnés."))

    ggplot() +
      geom_sf(data = world, fill = "gray95", color = "white") +
      geom_segment(
        data = flux_filtre(),
        aes(
          x = from_lon, y = from_lat,
          xend = to_lon, yend = to_lat,
          linewidth = volume
        ),
        color = "red",
        alpha = 0.6,
        arrow = arrow(type = "closed", length = unit(0.1, "cm"))
      ) +
      scale_linewidth(range = c(0.3, 2), name = "Nb de milliardaires") +
      labs(
        title = "Mouvements des milliardaires entre pays de nationalité et de résidence",
        x = NULL, y = NULL
      ) +
      theme_minimal(base_size = 14)
  })
}
