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
-   L'indice des prix à la consommation du pays dans lequel ce millionnaire vit (cpi_country, cpi_change_country)
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
On peut supposer que s'il y a un taux d'inflation élévé, cela peut vouloir dire que ça pourrait leur être profitable. Toutefois, nous ne sommes pas sûr de l'interprétation du résultat. Il faudrait voir la corrélation, d'abord. Nous allons croiser les pays d'habitation des milliardaires et les deux variables sur l'inflation.

-   Comment se répartissent les milliardaires dans les états américains ?
On peut supposer que certains états américains concentrent les milliardaires (New Jersey, Californie). On peut utiliser une carte pour rendre cela visuel. On utilise la variable state et country pour faire la visualisation.  

-   Est-ce qu’il y a des sources de richesse récurrente parmi les milliardaires ?

-   Y a-t-il un lien entre l'âge et la richesse ?
