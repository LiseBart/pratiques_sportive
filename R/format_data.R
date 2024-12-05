#' @title formatData
#'
#' #' @description 
#' This function clean and format data with new column name
#'
#' @param x a `tibble` (or `data.frame`). The output of [add_ecoregions()].
#'
#' @return A `tibble` with the following two columns: `sci_name` and 
#' `n_ecoregions`.
#' 
#' @importFrom rlang .data


format_data <- function(data) {
  
  # delete space in column names
  
  colnames(data) <- sapply(colnames(data), function(col) {
    gsub(pattern= " ", replacement= "", x= col, fixed = T)}
    )

  return(data)
  
}