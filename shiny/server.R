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

  monde_filtre <- reactive({
    res <- bill_by_country %>% filter(n >= input$monde_min)
    if (!is.null(input$monde_pays) && length(input$monde_pays) > 0) {
      res <- res %>% filter(country %in% input$monde_pays)
    }
    res
  })

  output$monde_nb_pays <- renderValueBox({
    valueBox(
      nrow(monde_filtre()), "Pays affichés",
      icon = icon("flag"), color = "blue"
    )
  })

  output$monde_nb_bill <- renderValueBox({
    valueBox(
      sum(monde_filtre()$n), "Milliardaires concernés",
      icon = icon("users"), color = "green"
    )
  })

  output$carte_monde <- renderPlot({
    validate(need(nrow(monde_filtre()) > 0, "Aucun pays ne correspond au filtre sélectionné."))

    ggplot() +
      geom_sf(data = world, fill = "gray95", color = "white") +
      geom_point(
        data = monde_filtre(),
        aes(x = lon, y = lat, size = n),
        color = "darkblue", alpha = 0.6
      ) +
      scale_size(name = "Nb de milliardaires", range = c(1, 14), trans = "sqrt") +
      labs(
        title = "Répartition des milliardaires dans le monde",
        x = NULL, y = NULL
      ) +
      theme_minimal(base_size = 14)
  })

  gen_filtre <- reactive({
    res <- gen_data %>% filter(gender %in% input$gen_genres)
    if (input$gen_origine != "Tous") {
      res <- res %>% filter(selfMade == input$gen_origine)
    }
    res %>% count(generation, name = "n", .drop = FALSE)
  })

  output$gen_total <- renderValueBox({
    valueBox(
      sum(gen_filtre()$n), "Milliardaires affichés",
      icon = icon("users"), color = "blue"
    )
  })

  output$gen_top <- renderValueBox({
    g <- gen_filtre()
    top <- if (sum(g$n) > 0) gsub("\n", " ", as.character(g$generation[which.max(g$n)])) else "—"
    valueBox(
      top, "Génération la plus représentée",
      icon = icon("trophy"), color = "yellow"
    )
  })

  output$plot_gen <- renderPlot({
    g <- gen_filtre()
    validate(need(sum(g$n) > 0, "Aucun milliardaire ne correspond aux filtres sélectionnés."))

    ggplot(g, aes(x = generation, y = n, fill = n)) +
      geom_col(width = 0.65, show.legend = FALSE) +
      geom_text(
        aes(label = ifelse(n > 0, paste0(n, "\n(", round(n / sum(n) * 100, 1), "%)"), "")),
        vjust = -0.4, size = 3.5, fontface = "bold", color = "grey30"
      ) +
      scale_fill_gradient(low = "#a8d0f0", high = "#0d47a1") +
      scale_y_continuous(expand = expansion(mult = c(0, 0.18))) +
      labs(
        title = "Distribution des milliardaires par génération",
        x = NULL, y = "Nombre de milliardaires"
      ) +
      theme_minimal(base_size = 13) +
      theme(
        axis.text.x        = element_text(size = 9, lineheight = 1.2),
        panel.grid.major.x = element_blank(),
        panel.grid.minor   = element_blank()
      )
  })
}
