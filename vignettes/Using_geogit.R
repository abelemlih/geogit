## ----setup, include = FALSE----------------------------------------------
library(tidyverse)
library(ggplot2)
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
ggplot(mtcars, aes(x = mpg, y = hp)) + geom_point()

## ---- fig.show='hold'----------------------------------------------------
plot(1:10)
plot(10:1)

## ---- echo=FALSE, results='asis'-----------------------------------------
knitr::kable(head(mtcars, 10))

