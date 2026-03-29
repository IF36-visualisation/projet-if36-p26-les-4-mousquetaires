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
On pense que certaines villes vont concentrer les milliardaires et que cela sera des métropoles ou des mégapoles. On va juste regarder la variable city et voir quel est le nombre brut de milliardaires par ville. 
    
-   Est-ce que les pays comptant des milliardaires ont de l’inflation ?
Par définition, l'inflation est [la perte du pouvoir d'achat de la monnaie qui se traduit par une augmentation générale et durable des prix.](https://www.insee.fr/fr/metadonnees/definition/c1473) On entend des courants divers disant que cela profite aux milliardaires et parfois, non. 
On peut supposer que s'il y a un taux d'inflation élévé, cela peut vouloir dire que ça pourrait leur être profitable. Toutefois, nous ne sommes pas sûr de l'interprétation du résultat. Il faudrait voir la corrélation. Nous allons croiser les pays d'habitation des milliardaires et les deux variables sur l'inflation.

-   Comment se répartissent les milliardaires dans les états américains ?
On peut supposer que certains états américains concentrent les milliardaires (New Jersey, Californie). On peut utiliser une carte pour rendre cela visuel, mais il nous fraudrait les coordonnées GPS de ces états pour rendre cela possible. On utilise les variables state et country pour faire la visualisation.  

-   Est-ce qu’il y a des sources de richesse récurrente parmi les milliardaires ?
Je pense qu'ici on entend source au sens des secteurs économiques récurrents où il y a beaucoup de milliardaires. La variable source pourrait être utilisée si on a uniquement un domaine spécifique et pas un nom d'entreprise. 
Cependant, avec un diagramme à barres, on pourrait afficher chaque secteur économique représenté (variable category ou industries) et à l'intérieur, préciser le domaine spécifique ou le nom de l'entreprise (variable source) dans la barre.
J'avoue que nous ne savons pas vraiment quel secteur va être surprésenté ou non. On peut s'attendre à voir les catégories technologiques, informatiques, fashion représentées pour sûr mais c'est parce que leurs dirigeants sont visibles. 

-   Y a-t-il un lien entre l'âge et la richesse ?
On suppose qu'une personne riche est certainement agée car il faut du temps pour faire fortune et qu'on ne met pas à la tête d'une entreprise quelqu'un de jeune et d'inexpérimenté. C'est ce qu'on s'attend à voir représenté. On aura besoin de tester la corrélation entre l'âge et la fortune. On ne laisse de côté aucun milliardaire.

3. Statistique de l’âge des milliardaires. Quelle est la répartition de l’âge des milliardaires en 2023 ?
On suppose que les milliardaires sont majoritairement dans une tranche d’âge élevée, car l’accumulation de richesse prend du temps. Cependant, il pourrait aussi y avoir une présence croissante de jeunes milliardaires, notamment dans le secteur technologique.
On va étudier la variable âge pour observer sa distribution (moyenne, médiane, écart-type) et visualiser la répartition à l’aide d’un histogramme ou d’un diagramme. Cela permettra de voir si la richesse est concentrée dans certaines classes d’âge.

13. Quels sont les points communs entre les riches dans le monde ?
On suppose que les milliardaires partagent certaines caractéristiques communes, comme leur secteur d’activité, leur niveau d’éducation, leur âge ou encore leur pays d’origine. Ces points communs pourraient permettre d’identifier des tendances globales dans la création de richesse.
Pour répondre à cette question, on va analyser plusieurs variables du dataset (par exemple : industrie, âge, pays, niveau d’études s’il existe) et observer les tendances dominantes ou les profils récurrents parmi les milliardaires.

16. Le taux d’imposition a-t-il une influence sur le nombre de milliardaires par pays ?
On suppose que le taux d’imposition pourrait influencer la concentration de milliardaires dans un pays. Par exemple, des impôts plus faibles pourraient attirer ou favoriser les grandes fortunes, tandis que des impôts élevés pourraient avoir l’effet inverse.
Cependant, cette relation n’est pas forcément directe, car d’autres facteurs (économie, stabilité politique, opportunités d’investissement) entrent en jeu.
On va croiser les données sur le taux d’imposition avec le nombre de milliardaires par pays et analyser la corrélation entre ces variables pour voir s’il existe une relation significative.

19. Comment se répartit la richesse des billionaires ?
On suppose que la richesse des milliardaires est très inégalement répartie, avec une petite partie d’entre eux possédant une grande proportion de la richesse totale (effet de concentration).
Pour analyser cela, on va étudier la variable de richesse (net worth) et observer sa distribution. On pourra utiliser des outils comme une courbe de Lorenz ou un graphique de distribution pour voir si la richesse suit une loi très asymétrique.

