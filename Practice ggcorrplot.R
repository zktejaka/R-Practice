##Kat Tejada's Practice with ggcorrplot charts

###Practicing -> ggcorrplot, 

#LOAD THE PACKAGES
library(ggplot2)
library(corrplot)
library(ggcorrplot)

store <- read.csv("RATINGS.csv")

#CORRELATION
#1.1 FIND AND PLOT CORRELATION BETWEEN RATINGS AND QUANTITY DEMANDED
cor(store$RATINGS, store$QUANTITY_DEMANDED)
plot(store$RATINGS, store$QUANTITY_DEMANDED)

#CORRELATION TEST
#1.2 PEARSON'S CORRELATION 
cor.test(store$RATINGS, store$QUANTITY_DEMANDED)


#CORRELATION MATRIX
#2.1 WORK WITH PRIMARY DATASET
store <- read.csv("UPDATED DEPARTMENTAL STORE.csv")

#2.2 FIND CORRELATION MATRIX
store<-dplyr::select_if(store, is.numeric)
r<-cor(store, use = "complete.obs")
round(r, 2)

#2.3 PLOT THE CORRELATION MATRIX (HEAT MAP)
ggcorrplot(r)


#2.4 PLOT THE SORTED LOWER TRIANGLE
ggcorrplot(r, 
       hc.order = TRUE,
       type = "lower",
       lab = TRUE)

