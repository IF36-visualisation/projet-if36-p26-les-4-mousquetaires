# **Introduction**

## Données

Le [dataset](https://www.kaggle.com/datasets/nelgiriyewithana/billionaires-statistics-dataset/) utilisé par notre groupe contient des données sur les milliardaires à travers le monde contenant 2540 observations et un total de 35 variables.

Ce dataset provient de [Nidula Elgiriyewithana](https://www.linkedin.com/in/nidula/), un ingénieur chercheur en IA et regroupe un ensemble d'informations sur les milliardaires.

La structure du dataset est le suivant : 

-   Le classement du milliardaire (rank)
-   Le montant de sa fortune (finalWorth)
-   Le secteur économique dans lequel le milliardaire opère (category, industries)
-   Les informations personnelles du milliardaire (personName, age, country, state, city, countryOfCitizenship, gender, birthDate, ...)
-   L'entreprise à l'origine de leur fortune ou le domaine spécifique à l'origine de la fortune (source)
-   Le nom de l'organisme ou entreprise affiliée actuellement à ces milliardaires (organization)
-   Un indicateur si le milliardaire a produit ou hérité de sa fortune (selfMade, status)
-   L'indice des prix à la consommation (2010 base 100) du pays dans lequel ce millionnaire vit en 2019 (cpi_country)
-   L'inflation des prix en pourcentage entre le début et la fin de l'année 2019 dans lequel ce millionaire vit (cpi_country_change)
-   Le PIB du pays dans lequel ce millionnaire vit (gdp_country)
-   Des informations sur le taux d'éducation dans le primaire et le supérieur du pays dans lequel ce millionnaire vit (gross_tertiary_education_enrollment, gross_primary_education_enrollment_country)
-   L'espérance de vie (life_expectancy_country) 
-   Le taux de recettes fiscales en pourcentage du PIB (tax_revenue_country_country)
-   Le taux d'imposition sur les entreprises en pourcentage des bénéfices commerciaux (total_tax_rate_country)
-   La population du pays dans lequel le milliardaire réside (population_country)


Cependant, certaines variables se recoupent. En effet, personName, qui inclut le nom et le prénom, se retrouve dans lastName (nom) et firstName (prénom). 
La date d'anniversaire entière du milliardaire (birthDate), qui est présente, est divisée aussi dans les données par birthYear, birthMonth et birthDay. 
Le pays où habite le milliardaire est présent (country), mais, on trouve aussi les coordonnées du pays d'origine du pays (latitude_country,longitude_country). 
Les variables category et industries sont redondantes. 

Ce dataset est composé, pour les variables pertinentes, de données : discrètes, continues et nominale.

Nous avons choisi ce dataset car :

-   Il est complet et toutes les informations nécessaires pour répondre à nos questions y figurent.
-   Nous avons la volonté et la curiosité d'en apprendre plus sur les milliardaires comme la provenance de leur richesse et leur répartition dans le monde nous intéresse.
-   Avec cette large quantitée d'informations variées, il est possible d'obtenir des réponses plus ou moins pertinentes sur des questions qu'on pourrait tous se poser et d'en tirer des conclusions générales d'un point de vue sociologique. (proportions d'hommes/femmes, gagnée par l'héritage ou le travail, etc.)

## Plan d'analyse

Liste des questions :

-   Quelles villes comptent le plus de milliardaires?
On pense que certaines villes vont concentrer les milliardaires et que cela sera dans des métropoles ou des mégapoles. On va juste regarder la variable city et voir quel est le nombre brut de milliardaires par ville. 
On va utiliser un bar chart pour visualiser cette question. 
    
-   Existe-il une corrélation entre la densité des milliardaires par pays et le niveau d'inflation sur l'année 2019 ?
Par définition, l'inflation est [la perte du pouvoir d'achat de la monnaie qui se traduit par une augmentation générale et durable des prix.](https://www.insee.fr/fr/metadonnees/definition/c1473) On entend des courants divers disant que cela profite aux milliardaires et parfois, non. 
Néanmoins, les milliardaires se concentrent dans des pays stables économiquement avec une faible variation des prix. Toutefois, nous ne sommes pas sûr de l'interprétation du résultat.
Nous allons croiser les variables country, population_country et cpi_country_change. On va utiliser un scatter plot pour cette question. 

-   Comment se répartissent les milliardaires dans les états américains ?
On peut supposer que certains états américains concentrent les milliardaires (New Jersey, Californie). On peut utiliser une carte pour rendre cela visuel, mais il nous fraudrait les coordonnées GPS de ces états pour rendre cela possible. On utilise les variables state et country pour faire la visualisation.  
On fait soit une carte choroplèthe, ou soit, un bar chart. 

-   Est-ce qu’il y a des sources de richesse récurrentes parmi les milliardaires ?
Je pense qu'ici on entend source au sens des secteurs économiques récurrents où il y a beaucoup de milliardaires. On envisage d'utiliser un diagramme à barre empilé. 
On pourrait, alors, diviser par secteur économique représenté (variable category ou industries) et à l'intérieur, préciser le domaine spécifique ou le nom de l'entreprise (variable source) dans la barre. 
La variable source pourrait être utilisée si on a uniquement un domaine spécifique et pas un nom d'entreprise. Il reste à savoir ce qu'on met à la place du nom de l'entreprise dans le diagramme.
J'avoue que nous ne savons pas vraiment quel secteur va être surprésenter ou non, les secteurs économiques stables. On peut s'attendre à voir les catégories technologiques, informatiques, fashion représentées. Cependant, c'est certainement du au fait que leurs dirigeants sont connus du grand public. 

-   Y a-t-il un lien entre l'âge et la richesse ?
On suppose qu'une personne riche est certainement agée car il faut du temps pour faire fortune et qu'on ne met pas à la tête d'une entreprise quelqu'un de jeune et d'inexpérimenté. C'est ce qu'on s'attend à voir représenté. On aura besoin de tester la corrélation entre l'âge et la fortune. 
On ne laisse de côté aucun milliardaire. On va faire un histogramme pour répondre à cette question. 

-  Est-ce que les milliardaires viennent seulement de pays très peuplé ?
On se heurte à des considérations de définitions car qu'est-ce qu'est un pays très peuplé. Il faut aller chercher dans des sources officielles qui peuvent parfois ne pas être d'accord, les unes avec les autres. On va utiliser la variable countryOfCitizenship 

-  Est-ce que les milliardaires dont le statut est “self-made” viennent d’un pays dont le taux d’inscription dans le supérieur est bas ?
Avec cette question, on veut voir si un pays avec un taux d'accès dans le supérieur bas peut produire des milliardaires car il a statistiquement moins de chances d'aller dans le supérieur, à moins de faire partie d'une élite, sans pour autant, pouvoir hérité d'une entreprise/fortune.
On veut savoir si on peut finalement "se faire soi-même" ou si notre environnement nous favorise grandement par des indicateurs sociaux-économiques très favorables et que ceux étant milliardaires venant d'un pays ayant un taux d'accès dans le supérieur sont des erreurs statistiques. 
Pour faire cette analyse correctement, il faudrait aller chercher en ligne ce qui est considéré comme un taux d'accès bas à l'enseignement supérieur. On aurait peut-être des données qui pourrait varier légèrement en fonction de la source.

-   Où sont répartis les milliardaires dans le monde ?
On veut voir où se répartissent les milliardaires sur une carte à bulles. On compte faire l'analyse par rapport à l'hémisphère Nord/Sud et on s'attend à trouver beaucoup de milliardaire dans l'hémisphère nord et un nombre certain dans les BRICS+. 
On va utiliser les variables country et les latitudes et longitudes pour les placer sur une carte. 

-   Quelle est la nationalité la plus représentée parmi les milliardaires ?
On veut voir si un pays a produit le plus de milliardaires. On s'attend à trouver les pays les plus développés et comptant le plus d'habitants. On va utiliser la variable countryOfCitizenship. On peut utiliser un diagramme à barre pour cette visualisation. 

-   Existe-t-il une corrélation entre la densité de milliardaires pays et le niveau d'éducation d'un pays mesuré par, le taux de scolarisation dans l’enseignement primaire et supérieur?
Nous utilisons la densité afin de lisser en divisant par la population du pays car plus un pays compte d'habitant plus il y comptera de milliardaires. Nous pensons qu'il y a une corrélation positive entre les trois variables. 
Il faudrait trancher entre un scatter plot matrix pour analyser les trois dimensions en même temps ou deux scatter plot, un attestant de la corrélation nombre de milliardaire par habitant et taux de scolarisation primaire et un autre avec l'enseignement supérieur.
Néanmoins, il nous semble qu'un scatter plot matrix est plus intérressant car on pourrait voir une corrélation, ou non, entre taux de scolarisation primaire et supérieur. Pour les variables, on va utiliser country, population, gross_tertiary_education_enrollment et gross_primary_education_enrollment_country.