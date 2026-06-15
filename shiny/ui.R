ui <- dashboardPage(
  skin = "blue",

  dashboardHeader(title = "Milliardaires 2023"),

  dashboardSidebar(
    sidebarMenu(
      menuItem("Répartition des âges", tabName = "ages", icon = icon("chart-column")),
      menuItem("Flux migratoires", tabName = "flux", icon = icon("globe")),
      menuItem("Carte mondiale", tabName = "monde", icon = icon("earth-americas")),
      menuItem("Générations", tabName = "generations", icon = icon("people-group"))
    )
  ),

  dashboardBody(
    tabItems(

      tabItem(
        tabName = "ages",
        fluidRow(
          valueBoxOutput("nb_milliardaires"),
          valueBoxOutput("age_moyen"),
          valueBoxOutput("age_median")
        ),
        fluidRow(
          box(
            title = "Filtres", width = 4, status = "primary", solidHeader = TRUE,
            sliderInput(
              "binwidth", "Largeur des classes d'âge (années) :",
              min = 1, max = 10, value = 1, step = 1
            ),
            checkboxGroupInput(
              "genres", "Genre :",
              choices = c("Hommes", "Femmes"),
              selected = c("Hommes", "Femmes")
            ),
            radioButtons(
              "origine", "Origine de la fortune :",
              choices = c("Tous", "Self-made", "Héritier"),
              selected = "Tous"
            ),
            selectInput(
              "industrie", "Industrie :",
              choices = industries_choices, selected = "Toutes"
            )
          ),
          box(
            title = "Répartition de l'âge des milliardaires en 2023",
            width = 8, status = "primary", solidHeader = TRUE,
            plotOutput("hist_ages", height = "500px")
          )
        )
      ),

      tabItem(
        tabName = "flux",
        fluidRow(
          valueBoxOutput("nb_flux", width = 6),
          valueBoxOutput("nb_migrants", width = 6)
        ),
        fluidRow(
          box(
            title = "Filtres", width = 4, status = "primary", solidHeader = TRUE,
            sliderInput(
              "volume_min", "Volume minimum d'un flux (nb de milliardaires) :",
              min = 1, max = max(flux_geo$volume), value = 2, step = 1
            ),
            selectInput(
              "destination", "Pays de résidence (destination) :",
              choices = destinations_choices, selected = "Tous"
            ),
            helpText(
              "Chaque flèche relie le pays de nationalité au pays de résidence.",
              "L'épaisseur du trait est proportionnelle au nombre de milliardaires concernés."
            )
          ),
          box(
            title = "Mouvements des milliardaires entre nationalité et lieu de résidence",
            width = 8, status = "primary", solidHeader = TRUE,
            plotOutput("carte_flux", height = "500px")
          )
        )
      ),

      tabItem(
        tabName = "monde",
        fluidRow(
          valueBoxOutput("monde_nb_pays", width = 6),
          valueBoxOutput("monde_nb_bill", width = 6)
        ),
        fluidRow(
          box(
            title = "Filtres", width = 4, status = "primary", solidHeader = TRUE,
            sliderInput(
              "monde_min", "Nombre minimum de milliardaires par pays :",
              min = 1, max = max(bill_by_country$n), value = 1, step = 1
            ),
            selectInput(
              "monde_pays", "Pays :",
              choices = pays_choices, selected = NULL, multiple = TRUE
            ),
            helpText(
              "Chaque bulle est centrée sur un pays de résidence ;",
              "sa taille est proportionnelle au nombre de milliardaires y vivant.",
              "Laissez le champ 'Pays' vide pour afficher tous les pays."
            )
          ),
          box(
            title = "Répartition des milliardaires dans le monde",
            width = 8, status = "primary", solidHeader = TRUE,
            plotOutput("carte_monde", height = "500px")
          )
        )
      ),

      tabItem(
        tabName = "generations",
        fluidRow(
          valueBoxOutput("gen_total", width = 4),
          valueBoxOutput("gen_top", width = 8)
        ),
        fluidRow(
          box(
            title = "Filtres", width = 4, status = "primary", solidHeader = TRUE,
            checkboxGroupInput(
              "gen_genres", "Genre :",
              choices = c("Hommes", "Femmes"),
              selected = c("Hommes", "Femmes")
            ),
            radioButtons(
              "gen_origine", "Origine de la fortune :",
              choices = c("Tous", "Self-made", "Héritier"),
              selected = "Tous"
            )
          ),
          box(
            title = "Distribution des milliardaires par génération",
            width = 8, status = "primary", solidHeader = TRUE,
            plotOutput("plot_gen", height = "500px")
          )
        )
      )
    )
  )
)
