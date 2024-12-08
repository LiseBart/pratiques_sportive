#' @title formatData
#'
#' #' @description 
#' This function clean and format data with new column name
#'
#' @param data a `data.frame` containing observations
#' 
#' @classement_hf_sport a `vector` containing absolute disparities in athlete genders 
#'
#' @return A `data.frame`  
#' 
#' @importFrom tidyr::pivot_longer()

format_data <- function(data, vecteur_sport = classement_hf_sport) {
  
  # clean col names
  
  colnames(data) <- sapply(colnames(data), function(col) {
    
    # Supprimer les espaces dans les noms de colonnes
    col <- gsub(pattern = " ", replacement = "", x = col, fixed = TRUE)
    
    # Remplacer "-" par "_"
    col <- gsub(pattern = "-", replacement = "_", x = col, fixed = TRUE)
    
  })
  
  
  # keep only data in France
  data <- data[data$Statutgéo == "1.Champ geoc",]
  
  
  # put ages in one column
  
  data_long <- data %>%
    tidyr::pivot_longer(starts_with(c("F_","H_")), # gather all columns starting by "F-" or "H-"
                        names_to = c("Genre", "Tranche_Age"), 
                        names_sep = "_", # Column gathering old column names
                 values_to = "count") # Column gathering values

  
  # Regroupement par Fédération, Genre, et Tranche d'âge
  data_summary <- data_long %>%
    dplyr::group_by(Fédération, Genre, Tranche_Age) %>%
    dplyr::summarise(Total = sum(count, na.rm = TRUE)) %>%
    dplyr::ungroup()
  
  # keep data with known age
  data_summary <- data_summary[data_summary$Tranche_Age != "NR",]
  
  
  # create 3 age classes
  data_summary$class_Age <- sapply(data_summary$Tranche_Age, function (code) {
    if (code %in% c("1à4ans", "5à9ans", "10à14ans", "15à19ans", "20à24ans")) {
      "jeunes"
    } else if (code %in% c("25à29ans", "30à34ans", "35à39ans", "40à44ans", "45à49ans", "50à54ans","55à59ans")) {
      "adultes"
    } else if (code %in% c("60à64ans","65à69ans","70à74ans","75à79ans","80à99ans")) {
      "Seniors"
    }
  })

  
  data_summary$Tranche_Age <- gsub(pattern= "à", replacement= "_", x= data_summary$Tranche_Age, fixed = T)
  
  
  data_summary <- data_summary[data_summary$Fédération %in% head(vecteur_sport,10),]
  
  return(data_summary)
  
}
