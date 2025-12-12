# Load Packages -----

library(brandr)
library(downlit)
library(ggplot2)
library(here)
library(httpgd) # github.com/nx10/httpgd
library(knitr)
library(magrittr)
library(quartor) # github.com/danielvartan/quartor
library(ragg)
library(showtext)
library(sysfonts)
library(xml2)

# Set General Options -----

options(
  dplyr.print_min = 6,
  dplyr.print_max = 6,
  pillar.max_footer_lines = 2,
  pillar.min_chars = 15,
  scipen = 10,
  digits = 10,
  stringr.view_n = 6,
  pillar.bold = TRUE,
  width = 77 # 80 - 3 for #> comment
)

# Set Variables -----

set.seed(2025)

# Set `knitr`` -----

clean_cache() |> suppressWarnings()

opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  root.dir = here(),
  dev = "ragg_png",
  dev.args = list(bg = "transparent"),
  fig.showtext = TRUE
)

# Set `brandr` -----

options(BRANDR_BRAND_YML = here("_brand.yml"))

brandr_options <- list(
  "BRANDR_COLOR_SEQUENTIAL" = get_brand_color(c("primary", "secondary")),
  "BRANDR_COLOR_DIVERGING" = get_brand_color(c(
    "primary",
    "white",
    "secondary"
  )),
  "BRANDR_COLOR_QUALITATIVE" = c(
    get_brand_color("primary"),
    get_brand_color("secondary"),
    get_brand_color("tertiary"),
    get_brand_color("light-green"),
    get_brand_color("dark-red"),
    get_brand_color("black")
  )
)

for (i in seq_along(brandr_options)) {
  options(brandr_options[i])
}

# Set `showtext` -----

sysfonts::font_paths(here("ttf"))

sysfonts::font_add(
  family = "poppins",
  regular = here("ttf", "poppins-regular.ttf"),
  bold = here("ttf", "poppins-bold.ttf"),
  italic = here("ttf", "poppins-italic.ttf"),
  bolditalic = here("ttf", "poppins-bolditalic.ttf"),
  symbol = NULL
)

showtext::showtext_auto()

# Set `ggplot2` -----

theme_set(
  theme_bw() +
    theme(
      text = element_text(
        color = get_brand_color("black"),
        family = "poppins",
        face = "plain"
      ),
      panel.background = element_rect(fill = "transparent"),
      plot.background = element_rect(
        fill = "transparent",
        color = NA
      ),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      legend.background = element_rect(fill = "transparent"),
      legend.box.background = element_rect(
        fill = "transparent",
        color = NA
      ),
      legend.frame = element_blank(),
      legend.ticks = element_line(color = "white")
    )
)

# Run `rbbt` -----

#' **IMPORTANT**
#'
#' Leave this code commented out unless you need to regenerate the bibliography
#' for Quarto documents from Zotero using Better BibTeX. This code cannot be run
#' in the CI/CD pipeline because it depends on having Zotero installed locally
#' with Better BibTeX configured.
#'
#' Uncheck the option "Apply title-casing to titles" in Zotero Better BibTeX
#' preferences (Edit > Settings > Better BibTeX > Miscellaneous).
#'
#' (2024-08-25)
#' This function should work with any version of BetterBibTeX (BBT) for Zotero.
#' Verify if @wmoldham PR was merged in the `rbbt` package (see issue #47
#' <https://github.com/paleolimbot/rbbt/issues/47>). If not, install `rbbt` from
#' @wmoldham fork `remotes::install_github("wmoldham/rbbt", force = TRUE)`.

# bbt_write_quarto_bib(
#   bib_file = here("references.bib"),
#   dir = c("."),
#   pattern = "\\.qmd$",
#   wd = here()
# )
