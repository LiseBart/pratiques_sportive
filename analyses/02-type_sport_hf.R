# Classement des sport par la partié ----

#Créer un dataset et le modifier avant les analyses 
data_quentin <- trier_quentin(data)

# extraire les valeurs absolue 
classement_hf_sport <- creation_classement_hf_sport(data_quentin)

# Ordonnée les valeur de différence 
data_quentin <- ordonne_quentin(data_quentin)


## Write a plot on figure ----
plot_quentin(data_quentin)
