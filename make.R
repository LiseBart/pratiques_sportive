# Install devtools if needed
if (system.file(package = 'devtools') == "") {
  install.packages("devtools", repos = "https://pbil.univ-lyon1.fr/CRAN/")
}

# Install packages if needed
devtools::install_deps()

# Attach packages
#devtools::load_all()
`%>%` = magrittr::`%>%`

#RUN PROJECT

# Load data

source(here::here("analyses","01-Load_data.R"))

source(here::here("analyses","04-Exploration_lise.R"))


## targets ----
# ---- project execution
targets::tar_config_set(
  store  = "outputs/pipeline/",
  script = "_targets.R"
)

targets::tar_make()
targets::tar_visnetwork()
