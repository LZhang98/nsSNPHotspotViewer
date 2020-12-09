#' Run associated Shiny webpage application
#'
#' Provides the user with a visual interface with which to explore the population data
#' and display any genes of interest.
#'
#' @import shiny
#'
#' @export
#'
#' @references
#' Winston Chang, Joe Cheng, JJ Allaire, Yihui Xie and Jonathan McPherson (2020). shiny: Web
#'     Application Framework for R. R package version 1.5.0. https://CRAN.R-project.org/package=shiny
#' @examples
#' runViewer()
runViewer <- function() {
    appDir <- system.file("../inst/shiny-scripts/app.R", package="nsSNPHotspotViewer")
    shiny::runApp(appDir, display.mode = "normal")
    return()
}
