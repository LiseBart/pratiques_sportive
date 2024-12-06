#Fonction pour nettoyer le tableau de données et ne garder que les données nécessaires à l'analyse hippo

sum_remove <- function(data_1){

  #somme de toutes les classes d'âge femme (avec NR)
  data_1$sum_femme <- rowSums(data_1[, 10:27])
  #somme de toutes les classes d'âge homme (avec NR)
  data_1$sum_homme <- rowSums(data_1[,28:45])
  #on enlève les colonnes classes d'âge
  data_1 <- subset(data_1,select=-c(10:46))
  #on enlève les 5 premières colonnes
  data_1 <- subset(data_1,select=-c(1:5))
  #on enlève les 4 premières colonnes
  data_1 <- subset(data_1,select=-c(2:4))
  
  #j'enlève les catégories étrangers
  data_1 <- subset(data_1,Région != "Etranger")
  #j'enlève les catégories NR dans Région
  data_1 <- subset(data_1,Région != "NR - Non réparti")
  
  #je veux additionner toutes les villes par région
  result <- aggregate(cbind(Total, sum_femme, sum_homme) ~ Région, data = data_1, FUN = sum)
  
  #création d'une colonne : proportion de femmes
  result$prop_femme <- result$sum_femme/result$Total
  
  #je garde juste les colonnes région et prop femme
  result <- subset(result,select=c(1,5))
  
  #trier par ordre croissant
  result_sorted <-result[order(result$prop_femme),]
  
  return(result_sorted)
}