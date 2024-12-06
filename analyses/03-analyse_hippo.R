#Nettoyage du tableau de données et analyse afin d'afficher le classement des régions
# en fonction de la proportion de femmes parmis les sportifs
# Sortie : barplot fichier png

#copie le jeu de données
data_1 <- data


format_data_2 <- function(data) {
  
  # clean col names
  
  colnames(data) <- sapply(colnames(data), function(col) {
    
    # Supprimer les espaces dans les noms de colonnes
    col <- gsub(pattern = " ", replacement = "", x = col, fixed = TRUE)
    
    # Remplacer "-" par "_"
    col <- gsub(pattern = "-", replacement = "_", x = col, fixed = TRUE)
    
  })
  
  return(data)
  
}

#supprime les espaces dans les titres des colonnes
data_1 <- format_data_2(data_1)

#nettoie et sélectionne uniquement les données nécessaires au graphe
result_sorted <- sum_remove(data_1)

#histogramme avec légendes
png("figures/barplot_large.png", width = 1200, height = 800)
par(mar = c(12, 4, 4, 2))  # Grandes marges
barplot(result_sorted$prop_femme, 
        names.arg = result_sorted$Région, 
        las = 2, 
        xlab = "", 
        ylab = "Proportion de femmes sportives", 
        cex.names = 1)
dev.off()

