# Classement des sport par la partié ----

## Fusion des colonnes ages 
data_quentin <- data
data_quentin$femme_tot <- rowSums(data_quentin[, 10:27])
data_quentin$femme_tot <- rowSums(data_quentin[, 28:45])

#Supprimer les lignes inutiles 
data_quentin <- data_quentin[,-(28:45)]
data_quentin <- data_quentin[,-(10:27)]
