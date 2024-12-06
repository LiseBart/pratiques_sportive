# Install devtools if needed
if (system.file(package = 'devtools') == "") {
  install.packages("devtools", repos = "https://pbil.univ-lyon1.fr/CRAN/")
}

# Install packages if needed
devtools::install_deps()

# Attach packages
#devtools::load_all()

#RUN PROJECT


## targets ----
# ---- project execution
targets::tar_config_set(
  store  = "outputs/pipeline/",
  script = "_targets.R"
)

targets::tar_make()
targets::tar_visnetwork()
