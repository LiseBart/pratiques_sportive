## Target excecution -----


library(targets) 
library(magrittr)
library(tidyr)

tar_source()

list( 
  
  #Install general data 
  tar_target(name = install_data, load_data()),
  
  #Raw general data
  tar_target(name = general_data, here::here("data","data_2021.csv")),
  
  #Creat the Quentin's dataset and modify it 
  tar_target(name = creat_data_quentin, trier_quentin(install_data)),
  
  #sort the quentin's dataset 
  tar_target(name = quentin_data_sort, ordonne_quentin(creat_data_quentin)),
  
  #Creat Quentin Plot 
  tar_target(name = creat_plot_quentin,plot_quentin(quentin_data_sort)),
  
  #Creat classement_hf_sport
  tar_target(name = creat_classement_hf_sport,plot_quentin(creat_data_quentin)),
  
  #Creat plot lise
  tar_target(name = creat_plot_lise,make_plot(install_data,creat_classement_hf_sport)),
  
  #Creat data set Hippo
  tar_target(name = creat_data_hippo,sum_remove(install_data)),
  
  #Creat graph set Hippo
  tar_target(name = creat_graph_hippo,fct_graph_hippo(creat_data_hippo))
)

