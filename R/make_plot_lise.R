#' @title make plot
#'
#' #' @description 
#' This function create a plot 
#'
#' @param data a `data.frame` containing observations
#' 
#' @classement_hf_sport a `vector` containing absolute disparities in athlete genders 
#'
#' @return A `data.frame`  
#' 
#' @importFrom tidyr::pivot_longer()

make_plot <- function(data, vecteur_sport) {
  
  # Clean data
  
  data_grpd <- format_data(data, vecteur_sport)
  
  plot_sport <- ggplot2::ggplot(data_grpd, ggplot2::aes(x = Fédération, y = Total, fill = interaction(Genre, class_Age))) +
    ggplot2::geom_bar(stat = "identity", position = "stack") +
    ggplot2::theme_grey() +
    ggplot2::labs(
      x = "Fédération",
      y = "Nombre de Participants",
      fill = "Genre et Tranche d'Âge"
    ) +
    ggplot2::coord_flip()
  
  ggplot2::ggsave(filename = "plot_lise.png", plot_sport, path = here::here("figures"))
  
  # quarto : les données recensent length(unique(data$communes)) communes
}