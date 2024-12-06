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


# Créer un graphique avec ggplot2
p <- ggplot2::ggplot(data_quentin, ggplot2::aes(x = 1:nrow(data_quentin), y = diff)) +
  ggplot2::geom_point(color = "dodgerblue", size = 3, alpha = 0.7) + # Points bleus translucides
  ggplot2::geom_text(data = data_quentin[selectionsport, ], 
                     ggplot2::aes(x = selectionsport, y = diff, label = Fédération), 
                     nudge_x = 3, nudge_y = 0.5, 
                     color = "darkred", size = 3.5) + # Étiquettes rouges
  ggplot2::labs(
    title = "Nuage de points avec étiquettes sélectionnées",
    x = "Ordre des données",
    y = "Différence (diff)"
  ) +
  ggplot2::theme_minimal(base_size = 14) + # Thème propre et épuré
  ggplot2::scale_x_continuous(
    limits = c(-10, nrow(data_quentin) + 20), # Ajout d'espace à gauche
    expand = ggplot2::expansion(mult = c(0.05, 0.1)) # Espacement supplémentaire
  )

#Plot the figure
print(p)

# Sauvegarder le graphique dans un fichier PNG

ggplot2::ggsave("sport_par_sexisme.png",path = here::here("figures"), plot = p, width = 10, height = 6, dpi = 300)
