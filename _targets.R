## Target excecution -----


library(targets) 

targets::tar_source()

list( 
  #Install general data 
  tar_target(name = install_data, load_data(Download)),
  
  #Raw general data
  tar_target(name = general_data, here::here("data","data_2021.csv")),
  
  #Creat the Quentin's dataset and modify it 
  tar_target(name = creat_data_quentin, trier_quentin(install_data)),
  
  #sort the quentin's dataset 
  tar_target(name = quentin_data_sort, ordonne_quentin(creat_data_quentin)),
  
  #Raw wildfinder mammals list
  tar_target(name = creat_plot_quentin,plot_quentin(quentin_data_sort))
  
)
