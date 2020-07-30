library(arules)
library(arulesViz)
data(Groceries)
Groceries
str(Groceries)
inspect(Groceries[1:10])
summary(Groceries)

sort(itemFrequency(Groceries,type="absolute"),decreasing = T)

itemFrequencyPlot(Groceries,topN=10,type="absolute")
itemFrequencyPlot(Groceries,topN=10,type="relative")

apriori(Groceries) #support=0.1, confidence=0.8 data type must be transaction

# support=0.005, confidence=0.5,, support can be changed depend on the number of transactions
# support decreases when N increases, adjust support value that fits the data set properly
result_rules<-apriori(Groceries, parameter=list(support=0.005,confidence=0.5,minlen=2))
result_rules
summary(result_rules) # {lhs} --> {rhs}
inspect(result_rules[1:20])

plot(result_rules,method="graph",control=list(type="items"))
     
plot(result_rules,method="grouped")
