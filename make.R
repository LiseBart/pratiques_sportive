# Setup project ----

## Install packages ----

devtools::install_deps(upgrade = "never")


## Load packages & functions ----

# plus utiliserlaod_all car pas compatible avec target 
# devtools::load_all()
`%>%` = magrittr::`%>%`



# Run project ----


## Make report ----

#quarto::quarto_render(input          = here::here("index.qmd"), 
#                      execute_params = list(mammals_family = "Canidae"))

## targets ----
# ---- project execution
targets::tar_config_set(
  store  = "outputs/pipeline/",
  script = "_targets.R"
)

targets::tar_make()
targets::tar_visnetwork()
