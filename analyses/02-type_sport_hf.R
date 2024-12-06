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

# extraire les valeurs absolue 
data_quentin$diff_abs <- abs(data_quentin$diff)
data_quentin <- data_quentin %>%
  dplyr::arrange(-diff_abs)
classement_hf_sport <- data_quentin$Fédération

# Ordonnée les valeur de différence 
data_quentin <- data_quentin %>%
  dplyr::arrange(-diff)


#Plot all sport 

ggplot2::ggplot(data_quentin, ggplot2::aes(x = diff, y = diff, label = Fédération)) +
  ggplot2::geom_point(color = "blue", size = 3) +    # Points
  ggplot2::geom_text(nudge_x = 0.5, nudge_y = 0.5, color = "red") + 
  ggplot2::theme_minimal()


# Créer un nuage de points
plot(1:nrow(data_quentin), data_quentin$diff, 
     type = "p",  # Points
     main = "Nuage de points", 
     xlab = "Ordre des données", 
     ylab = "Col2 (axe y)", 
     xlim = c(0, nrow(data_quentin) + 20), 
     pch = 19, col = "blue")

# Ajouter les étiquettes (Col1) aux points
selectionsport <- c(1,6,10,12,18,40,56,70,81,86,92,100,106)
text(selectionsport, data_quentin$diff[selectionsport], labels = data_quentin$Fédération[selectionsport], pos = 4, cex = 0.8, col = "red")
