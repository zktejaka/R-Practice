##Kat Tejada's Practice with ggplot charts

###Practicing -> geom_col, geom_point, geom_line, geom_histogram, 

#LOAD THE PACKAGES
require(dplyr)
require(ggplot2)

store <-read.csv("UPDATED DEPARTMENTAL STORE.csv")


##COLUMN PLOT
#1.1. PLOT FOR AVERAGE_QUANTITY & PRODUCT_TYPE
store %>% group_by(PRODUCT_TYPE) %>%
  summarise(AVERAGE = mean (QUANTITY_DEMANDED)) %>%
  ggplot(aes(x = PRODUCT_TYPE, y = AVERAGE)) + geom_col(width = 0.6, fill = "red") +
  theme(text = element_text(size = 9))

#1.2. PLOT FOR AVERAGE_NET_PROFIT & PRODUCT_TYPE
store %>% group_by(PRODUCT_TYPE) %>% 
  summarise(AVERAGE_NET_PROFIT=mean(NET_PROFIT)) %>%
  ggplot(aes(x = PRODUCT_TYPE, y = AVERAGE_NET_PROFIT)) + geom_col(width = 0.6, fill = "light blue") +
  theme(text = element_text(size = 9))


##SCATTER PLOT
#2.1. PLOT FOR NET_PROFIT & COMPANY 
store %>%
  ggplot(aes(x = COMPANY, y = NET_PROFIT, color = PRODUCT_CATEGORY)) + geom_point()

#2.2. PLOT FOR PROFIT  & QUANTITY_DEMANDED WHERE PRODUCT_TYPE == "beauty products"
store %>% filter(PRODUCT_TYPE == "beauty products") %>%
  ggplot(aes(x = QUANTITY_DEMANDED, y = PROFIT, color = PRODUCT_CATEGORY)) + geom_point()


##LINE PLOT
#3.1. PLOT FOR  PRICE-DEMAND RELATIONSHIP (AVERAGE_SELLING_PRICE VS QUANTITY_DEMANDED)
ggplot(store, aes(x = QUANTITY_DEMANDED, y = SELLING_PRICE)) + geom_line(color = "PURPLE")

#3.2. PLOT FOR AVERAGE_NET_PROFIT & COMPANY
store %>% group_by(PRODUCT_TYPE, COMPANY) %>% 
  summarise(AVERAGE_NET_PROFIT=mean(NET_PROFIT, na.rm=TRUE)) %>%
  ggplot(aes(x=PRODUCT_TYPE, y=AVERAGE_NET_PROFIT, group=COMPANY, color=COMPANY))+
  geom_line()+ theme(text= element_text(size=9.5))


##HISTOGRAM 
#4.1. HISTOGRAM FOR PROFIT_PERCENT OF PRODUCT_CATEGORY
store %>%
  ggplot(aes(x = PROFIT_PERCENT, fill = PRODUCT_CATEGORY)) + geom_histogram(binwidth = 30)

#4.2. HISTOGRAM FOR QUANTITY_DEMANDED OF PRODUCT_CATEGORY WHERE PRODUCT_TYPE IS "snacks"
store %>%
  filter(PRODUCT_TYPE == "snacks") %>%
  ggplot(aes(x=QUANTITY_DEMANDED, fill=PRODUCT_CATEGORY))+geom_histogram(binwidth = 30)


#PIE CHART
#5.1 MAKE A PIE CHART FOR EACH HYGIENE PRODUCT'S QUANTITY DEMANDED.
#PREPARE REQUIRED DATA
store1 <-  filter(store, PRODUCT_TYPE=="hygiene")%>%
  group_by(PRODUCT_CATEGORY)%>%
  summarise(QUANTITY_DEMANDED=sum(QUANTITY_DEMANDED))

#5.2 CALCULATE PERCENTAGE OF EACH PRODUCT
store2 <- store1 %>% 
  arrange(desc(PRODUCT_CATEGORY)) %>%
  mutate(percentage=round(QUANTITY_DEMANDED*100/sum(QUANTITY_DEMANDED))) %>% 
  mutate(y_pos = cumsum(percentage)-0.5*percentage)

#5.3 CREATE THE PIE CHART
store2 %>%
  ggplot(aes(x = "", percentage, fill = PRODUCT_CATEGORY)) +
  geom_bar(width = 1, stat = "identity" , color = "white", alpha = .5) +
  coord_polar("y", start = 0) +
  geom_text(aes(y = y_pos, label = paste0(percentage, "%")), color = "black") +
  scale_fill_manual(values = rainbow(7)) + theme_void()


#DONUT
#6.1 MAKE A DONUT FOR THE SAME DATA
store2 %>%
  ggplot(aes(x = 2, percentage, fill = PRODUCT_CATEGORY)) +
  geom_bar(stat = "identity" , color = "white", alpha = .5) +
  coord_polar(theta = "y", start = 0) +
  geom_text(aes(y = y_pos, label = paste0(percentage, "%")), color = "black") +
  scale_fill_manual(values = rainbow(7)) + theme_void() + xlim(0.6, 2.6)


#COXCOMB CHART 
#7.1 MAKE A COXCOMB CHART  FOR THE SAME DATA
store2 %>% 
  ggplot(aes(PRODUCT_CATEGORY, QUANTITY_DEMANDED, fill=PRODUCT_CATEGORY)) + 
  geom_bar(stat = "identity") + 
  coord_polar("x", start = 0, direction = -1) +
  xlab("DIFFERENT HYGIENE PRODUCTS") +
  ylab("QUANTITY")
