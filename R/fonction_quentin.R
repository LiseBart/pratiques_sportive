format_data_quentin <- function(data) {

  colnames(data) <- sapply(colnames(data), function(col){
    col <- gsub(pattern = " ", replacement = "", x=col, fixed = TRUE)
    #col <- gsub(pattern = "-", replacement = "_", x = col, fixed = TRUE)
  })
  return(data)
}



#' @title trier_quentin
#'
#' #' @description 
#' This function clean and modify the base dataset 
#'
#' @param x a `data.frame` import with load_data()
#'
#' @return A `data.frame` fice column (`Féfération`,`Total`,`femme_tot`,`homme_tot`,`diff`)
#' 
#' @importFrom format_data()
#' 

trier_quentin <- function(data_in){
    ## Créer un nouveau tableau ----
    data_quentin <- data_in
    
    ##Formater le tableau ----
    data_quentin <- format_data_quentin(data_quentin)
    
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
    data_out <- data_quentin
    return(data_out)
}

#' @title creation_classement_hf_sport
#'
#' #' @description 
#' This function create a vector of all the sport sort by the absolut practice difference
#'
#' @param x a dataframe (data_quentin)
#'
#' @return a vecteur of all sport 
#' 
#' @importFrom dplyr
#' 
creation_classement_hf_sport <- function(data_in){
  # extraire les valeurs absolue 
  data_in$diff_abs <- abs(data_in$diff)
  data_in <- data_in %>%
    dplyr::arrange(-diff_abs)
  vector_out <- data_in$Fédération
  return(vector_out)
}

#' @title ordonnne_quentin
#'
#' #' @description 
#' This function sort a specific table (data_quentin) base on the value of the diff column
#'
#' @param x a dataframe (data_quentin) 
#'
#' @return A the same dataframe but sort
#' 
#' @importFrom dplyr
#' 

ordonne_quentin <- function(data_in){
  # Ordonnée les valeur de différence 
  data_out <- data_in %>%
    dplyr::arrange(-diff)
  return(data_out)
}


#' @title plot_quentin
#'
#' #' @description 
#' plot a beautifull graph
#'
#' @param x the dataframe data_quentin
#'
#' @return nothing
#' 
#' @importFrom ggplot2
#' 

# Créer un graphique avec ggplot2
selectionsport = c( 1,6,10,12,18,40,56,70,81,86,92,100,106)
plot_quentin <- function(data_for_graph){
  p <- ggplot2::ggplot(data_for_graph, ggplot2::aes(x = 1:nrow(data_for_graph), y = diff)) +
    ggplot2::geom_point(color = "dodgerblue", size = 3, alpha = 0.7) + # Points bleus translucides
    ggplot2::geom_text(data = data_for_graph[selectionsport, ], 
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
      limits = c(-10, nrow(data_for_graph) + 20), # Ajout d'espace à gauche
      expand = ggplot2::expansion(mult = c(0.05, 0.1)) # Espacement supplémentaire
    )
  
  
  # Sauvegarder le graphique dans un fichier PNG
  
  ggplot2::ggsave("sport_par_sexisme.png",path = here::here("figures"), plot = p, width = 10, height = 6, dpi = 300)
}

