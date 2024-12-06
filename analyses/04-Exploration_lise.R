# Clean data

data_grpd <- format_data(data)

# nb participants par Fédé

# make heatmap proportion sportifs par région/dép

# histo participants par tranche d'âge

# comparaison F H pas tranche d'ages -> ratio H F par tranche d'age ?
# evolution du ration H F en fonction de la tranche d'age

# cluster sport par sexe

# bar plot par fédé -> extraire les plus grosses fédé
#data_grpd %>%
#  dplyr::group_by(Fédération) %>%
#  dplyr::summarise(Total = sum(Total)) %>%
#  ggplot2::ggplot(ggplot2::aes(x = reorder(Fédération, -Total), y = Total, fill = Fédération)) +
#  ggplot2::geom_bar(stat = "identity") +
#  ggplot2::coord_flip() +
#  ggplot2::theme_minimal() +
#  ggplot2::theme(legend.position = "none") +
#  ggplot2::labs(title = "Participants par Fédération", x = "Fédération", y = "Total")


# en fonction de la pré analyse de quentin qui sort les sports avec le moins de parité : 
# extraire automatiquement les sports
# ex : foot : répartition des participants par tranche d'age et par genre dans la fédé

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
