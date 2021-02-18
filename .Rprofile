message("Hello !")
message("Welcome to this Big Data in Biomedicine session.")

if (grepl("Linux stats3", system("uname -a", intern=T))) {
  if (R.version$version.string != "R version 3.5.3 (2019-03-11)"){
    stop("Please choose R version 3.5.3 using the dropdown menu in the top right corner of RStudio Server.")
  } else {
    message("R version correct: ", R.version$version.string, "\n")
    lib.dir <- "/homes/homedirs18/sghms/bms/shares/bdib/BDiB_2020-21/R/packages_R_3.5.3"
    if (!file.exists(lib.dir)) {
      message(paste("Library folder not found (.Rprofile)"))
    } else {
      .libPaths(c(lib.dir, .libPaths()))
      i <- grep("BDiB_2020-21", .libPaths())
      j <- grep("x86_64-pc-linux-gnu-library", .libPaths())
      k <- grep("lib64/R/library", .libPaths())
      x <- .libPaths()[c(i,j,k)]
      .libPaths(x) # set paths in new order
      message("\nLibrary paths:")
      print(.libPaths())
      rm(i, j, k, x)
    }
    rm(lib.dir)
  }
} else {
  stop("For this session it is preferred if you use RStudio Server Pro at https://stats3.sgul.ac.uk/rstudio/")
}

knitr::opts_chunk$set(engine.path = list(
  r = '/opt/R/R-3.4.3/bin/R'
))

library(rmarkdown)

message("\nSession info:")
gsub("^[ \t]+|\\{.*\\}|\\\\[a-zA-Z]+", "", utils::toLatex(utils::sessionInfo(), locale = FALSE))

