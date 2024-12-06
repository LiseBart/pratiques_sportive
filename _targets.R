## Target excecution -----


library(targets) 

targets::tar_source()

list( 
  #Install data pantheria
  tar_target(name = install_pantheria, dl_pantheria_data()),
  
  #Install data wildfinder
  tar_target(name = install_wildfinder, dl_wildfinder_data()),
  
  
  #Raw wildfinderecoregion
  tar_target(name = raw_read_wildfinder_ecoregions_list, here::here("data/wildfinder","wildfinder-ecoregions_list.csv")),
  
  #Read wildfinderecoregion
  tar_target(name = read_wildfinder_ecoregions_list, read_eco_list(raw_read_wildfinder_ecoregions_list)),
  
  
  #Raw wildfinder mammals list
  tar_target(name = raw_read_wildfinder_mammals_list, here::here("data/wildfinder","wildfinder-mammals_list.csv")),
  
  #Read wildfinder mammals list
  tar_target(name = read_wildfinder_mammals_list, read_sp_list(raw_read_wildfinder_mammals_list)),
  
  #Select species  
  tar_target(name = save_species, select_species(read_wildfinder_mammals_list, family = "Ursidae")),
  
  
  #Read wildfinder ecoregions species
  tar_target(name = raw_wildfinder_ecoregions_species, here::here("data/wildfinder","wildfinder-ecoregions_species.csv")),
  
  #Read wildfinder ecoregions species
  tar_target(name = read_wildfinder_ecoregions_species, read_sp_eco(raw_wildfinder_ecoregions_species)),
  
  #Merge the tables 
  tar_target(name = merge_table, add_ecoregions(save_species,
                                                read_wildfinder_ecoregions_species,
                                                read_wildfinder_ecoregions_list)),
  
  #Count ecoregion occupation 
  tar_target(name = count_eco, count_ecoregions(merge_table)),
  
  #Plot the histogram of occupation 
  tar_target(name = plot_count_eco, plot_counts(count_eco))
)