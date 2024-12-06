#' @title load_data
#'
#' #' @description 
#' Dowlaod and read a dataset find on "https://www.data.gouv.fr/fr/datasets/r/b62c05d2-6b45-44e0-80a4-6e10e3f14ec6"
#'
#' @param x already_dl True or False
#'
#' @return the read table 
#' 
#' @importFrom format_data()
#' 


load_data <- function(already_dl){
  ### Load data
  
  # Download data from url
  
  ## set url to download data
  
  url = "https://www.data.gouv.fr/fr/datasets/r/b62c05d2-6b45-44e0-80a4-6e10e3f14ec6"
  
  # path to save data
  dest_file <- here::here("data","data_2021.csv")
  
  # download
  options(timeout = 1000)
  
  if (already_dl & !file.exists(dest_file)) {
    utils::download.file(url      = url,
                         destfile = dest_file,
                         mode     = "wb")
  }
  
  # Read Data
  data <- data.table::fread(dest_file, sep=";")
  
  # Return
  return(data)
}
