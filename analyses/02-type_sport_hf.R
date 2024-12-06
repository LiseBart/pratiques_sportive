# Classement des sport par la partié ----

## Créer un nouveau tableau ----
data_quentin <- data

## Formater le tableau ----
data_quentin <- format_data(data_quentin)

## Fusion des colonnes ages ----
data_quentin$femme_tot <- rowSums(data_quentin[, 10:27])
data_quentin$homme_tot <- rowSums(data_quentin[, 28:45])

## Supprimer les fédération étrangère et NR
data_quentin <- subset(data_quentin, Région != "Etranger")
data_quentin <- subset(data_quentin, Région != "NR - Non réparti")

## Supprimer les colonne inutiles ----
data_quentin <- data_quentin[,-(1:8)]
data_quentin <- data_quentin[,-(2:38)]

## Sommer les fédération de sport 
data_quentin <- aggregate(. ~ Fédération, data = data_quentin, FUN = sum)

# Créer une colonne différentielle Homme par femme 
data_quentin$diff <- ((data_quentin$homme_tot - data_quentin$femme_tot) / data_quentin$Total) * 100


# Ordonnée les valeur de différence 
data_quentin <- data_quentin %>%
  arrange(diff)

#Plot all sport 

