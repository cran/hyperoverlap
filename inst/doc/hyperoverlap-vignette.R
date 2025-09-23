## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(knitr)
library(rgl)
knit_hooks$set(webgl = hook_webgl)

if (!requireNamespace("rmarkdown", quietly = TRUE) ||
!rmarkdown::pandoc_available("1.14")) {
warning(call. = FALSE, "These vignettes assume rmarkdown and pandoc
version 1.14. These were not found. Older versions will not work.")
knitr::knit_exit()
}

## ----results='show'-----------------------------------------------------------
test1 <- iris[which(iris$Species!="versicolor"),c(1:3,5)]
test2 <- iris[which(iris$Species!="setosa"),c(1:3,5)]
test3 <- iris[which(iris$Species!="versicolor"),]
test4 <- iris[which(iris$Species!="setosa"),]
test5 <- iris

## ----results='show'-----------------------------------------------------------
library(hyperoverlap)
setosa_virginica3d <- hyperoverlap_detect(test1[,1:3], test1$Species)
versicolor_virginica3d <- hyperoverlap_detect(test2[,1:3], test2$Species)

## ----results='show', fig.height=5,fig.width=7, webgl=TRUE, fig.align="center"----
setosa_virginica3d@result             #gives us the result: overlap or non-overlap?
versicolor_virginica3d@result

setosa_virginica3d@shape              #for the non-overlapping pair, was the decision boundary linear or curvilinear? 


hyperoverlap_plot(setosa_virginica3d) #plot the data and the decision boundary in 3d

## ----results='show', fig.height=5,fig.width=7, webgl=TRUE, fig.align="center"----
hyperoverlap_plot(versicolor_virginica3d) 

## ----results='show'-----------------------------------------------------------
setosa_virginica4d <- hyperoverlap_detect(test3[,1:4], test3$Species)
versicolor_virginica4d <- hyperoverlap_detect(test4[,1:4], test4$Species)

## ----results='show',  fig.height=4,fig.width=5, fig.show='hold', fig.align='center'----
setosa_virginica4d@result             #gives us the result: overlap or non-overlap?
versicolor_virginica4d@result

setosa_virginica4d@shape              #for the non-overlapping pair, was the decision boundary linear or curvilinear? 

transformed_data <- hyperoverlap_lda(setosa_virginica4d)  #plots the best two dimensions for visualising overlap
transformed_data <- hyperoverlap_lda(versicolor_virginica4d) 

## ----results='show',  fig.height=5,fig.width=7, webgl = hook_webgl,fig.align="center"----
rgl.close()  #close previous device
transformed_data <- hyperoverlap_lda(setosa_virginica4d, visualise3d=TRUE) 

## ----results='show',  fig.height=5,fig.width=7, webgl = hook_webgl,fig.align="center"----
rgl.close()  #close previous device
transformed_data <- hyperoverlap_lda(versicolor_virginica4d, visualise3d=TRUE) #plots the best three dimensions for visualising overlap

## ----results='show', fig.dim=c(5,3),fig.align="center"------------------------
all_spp <- hyperoverlap_set(test5[,1:4],test5$Species)
all_spp_plot <- hyperoverlap_pairs_plot(all_spp)
all_spp_plot

