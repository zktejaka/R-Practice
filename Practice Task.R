##Kat Tejada's Basic Data transformation & Statistical Interpretation Practice

require(dplyr)

#LOAD THE DATASET
store <- read.csv("UPDATED DEPARTMENTAL STORE.csv")

#PART 1 : DATA TRANSFORMATION

#i.GET THE INFORMATION OF THE COLUMNS 4-10
store1 <- select(store, 4:10)

#ii.WHERE PRODUCT_CATEGORY IS 'household'
store2 <- filter(store1, PRODUCT_TYPE == 'household')

#iii.ARRANGED IN ASCENDING ORDER OF QUANTITY_DEMANDED. 
store3 <- arrange(store2, QUANTITY_DEMANDED)
View(store3)



#PART 2 : STATISTICAL INTERPRETATION

#i. FIND THE AVERAGE AND SUMMATION OF QUANTITY_DEMANDED
store4 <- group_by(store3, PRODUCT_CATEGORY)

#ii. GROUPED BY PRODUCT CATEGORY
summarise(store3, AVERAGE = mean (QUANTITY_DEMANDED), SUM = sum(QUANTITY_DEMANDED))


