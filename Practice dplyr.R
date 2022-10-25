##Kat Tejada's Practice with Common Dplyr Commands

###Practicing -> filter(), slice(), arrange(), select(), mutate(). summarize(), group_by()


install.packages("dplyr")
require(dplyr)

#LOAD THE DATASET
store <-read.csv("MY DEPARTMENTAL STORE .csv")
#VIEW THE DATASET
View(store)
glimpse(store)



#1.filter()

##1.1.GET THE INFORMATION OF THE PRODUCT WHERE TO PRODUCT_TYPE IS 'beauty products'
beautyStore <- filter(store, PRODUCT_TYPE == "beauty products")
View(beautyStore)

###1.2. GET THE INFORMATION OF THE PRODUCT WHERE IT BELONGS TO COMPANY S or M
companyStore <- filter(store, COMPANY %in% c("S", "M") )
View(companyStore)


#2. slice() 

##2.1 GET THE DETAILS OF FIRST 10 ROWS
show10store <- store %>% slice(1:10)
View(show10store)

###2.2 GET THE DETAILS OF FIRST 6 ROWS
show6store<-store %>% slice_head(n = 6)
View(show6store)


#3.arrange()

##3.1.ARRANGE THE DATASET IN ASCENDING ORDER OF QUANTITTY DEMANDED
sortStore <- arrange(store, QUANTITY_DEMANDED)
View(sortStore)

##3.2. ARRANGE THE DATASET IN DESCENDING ORDER OF SELLING PRICE
sortStore2 <- arrange(store, desc(SELLING_PRICE))
View(sortStore2)


#4.select() 

##4.1. GET THE INFORMATION OF COLUMNS SELLING_PRICE,COMPANY
selectStore <- select(store, SELLING_PRICE, COMPANY)
View(selectStore)

##4.2.GET THE INFORMATION OF COLUMNS 2 & 5
selectStore <- select(store, c(2,5))
View(selectStore)

##4.3. GET THE INFORMATION OF COLUMNS 2 TO 5
selectStore <- select(store, 2:5 )
View(selectStore)

##4.4. GET THE INFORMATION OF COLUMNS STARTING WITH P
selectStore <- select(store, starts_with("P"))
View(selectStore)

##4.5. GET THE INFORMATION OF COLUMNS ENDING WITH E
selectStore<- select(store, ends_with("E"))
View(selectStore)


#5.mutate()

##5.1. ADD A COLUMN TO SHOW THE PROFIT
mutateStore1 <- mutate(store, PROFIT=SELLING_PRICE - COST_PRICE)
View(mutateStore1)

##5.2. ADD A COLUMN TO SHOW THE PROFIT PERCENT
mutateStore2 <- mutate(mutateStore1, PROFIT_PERCENT= PROFIT/COST_PRICE*100)
View(mutateStore2)

##5.3. ADD A COLUMN TO SHOW THE NET PROFIT
mutateStore3<- mutate(mutateStore2, NET_PROFIT=PROFIT*QUANTITY_DEMANDED)
View(mutateStore3)

##5.4.LET'S SAVE THE UPDATED FILE
write.table(mutateStore3, file = "UPDATED DEPARTMENTAL STORE.csv", sep=",")



##LOAD THE UPDATED DATASET
updatedStore <- read.csv("UPDATED DEPARTMENTAL STORE.csv")


#6.summarize()

#Find the following descriptive statistics for the net profit.

##6.1.Find the AVERAGE/mean 
summarise(updatedStore, AVG = mean(NET_PROFIT))

##6.2.Find the SUMMATION 
summarise(updatedStore, SUM = sum(NET_PROFIT ))

##6.3.Find the MINIMUM and MAXIMUM 
summarise(updatedStore, MIN = min(NET_PROFIT),  MAX = max(NET_PROFIT))

##6.4. Find the median 
summarise(updatedStore, MEDIAN = median(NET_PROFIT))

##6.5. Find the variance 
summarise(updatedStore, VARIANCE = var(NET_PROFIT))

##6.6. Find the standard deviation 
summarise(updatedStore, STANDARD_DEVIATION = sd(NET_PROFIT))

##6.7. Find the summary 
summarise(updatedStore, SUMMARY = summary(NET_PROFIT))

##6.8. Find the quantile 
summarise(updatedStore, QUANTILE = quantile(NET_PROFIT))

##6.9. Find the range
summarise(updatedStore, RANGE = range(NET_PROFIT))


# 7.group_by().
# It is used to group data

# Sort the data grouped by PRODUCT_TYPE
groupByStore <- group_by(updatedStore, PRODUCT_TYPE)

#Find the following descriptive statistics for the net profit for the sorted data.

##7.1.Find the AVERAGE/mean 
summarise(groupByStore, AVG = mean(NET_PROFIT))

##7.2.Find the SUMMATION 
summarise(groupByStore,SUM = sum(NET_PROFIT ))

##7.3.Find the MINIMUM and MAXIMUM 
summarise(groupByStore, MIN = min(NET_PROFIT), MAX = max(NET_PROFIT))

##7.4. Find the median 
summarise(groupByStore, MEDIAN = median(NET_PROFIT))

##7.5. Find the variance 
summarise(groupByStore, VARIANCE = var(NET_PROFIT))

##7.6. Find the standard deviation 
summarise(groupByStore, STANDARD_DEVIATION = sd(NET_PROFIT))

##7.7. Find the range
summarise(groupByStore, RANGE = range(NET_PROFIT))

