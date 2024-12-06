#' @title formatData
#'
#' #' @description 
#' This function clean and format data with new column name
#'
#' @param data a `data.frame` containing observations
#'
#' @return A `data.frame`  
#' 
#' @importFrom tidyr::pivot_longer()

format_data <- function(data) {
  
  # clean col names
  
  colnames(data) <- sapply(colnames(data), function(col) {
    
    # Supprimer les espaces dans les noms de colonnes
    col <- gsub(pattern = " ", replacement = "", x = col, fixed = TRUE)
    
    # Remplacer "-" par "_"
    col <- gsub(pattern = "-", replacement = "_", x = col, fixed = TRUE)
    
  })
  
  return(data)
  
}
