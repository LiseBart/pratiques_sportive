#copie le jeu de données
data_1 <- data

format_data <- function(data) {
  # delete space in column names
  colnames(data) <- sapply(colnames(data), function(col) {
    gsub(pattern= " ", replacement= "", x= col, fixed = T)}
  )
  return(data)
}

data_1 <- format_data(data_1)

#somme de toutes les classes d'âge femme (avec NR)
data_1$sum_femme <- rowSums(data_1[, 10:27])
#somme de toutes les classes d'âge homme (avec NR)
data_1$sum_homme <- rowSums(data_1[,28:45])
#on enlève les colonnes classes d'âge
data_1 <- subset(data_1,select=-c(10:46))
#on enlève les 4 premières colonnes
data_1 <- subset(data_1,select=-c(1:4))
#je veux additionner toutes les villes par région
data_1 <- data_1[data_1$]