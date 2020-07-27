skin <- read.csv("C:\\Users\\mega\\Desktop\\rMLwork\\MLData\\skin.csv", header=T)
skin <- skin[-1]
head(skin)
str(skin)

library(rpart)
tree1 <- rpart(쿠폰반응여부~., data=skin, control=rpart.control(minsplit=2))
plot(tree1, compress = T, uniform = T, margin = 0.1)
text(tree1, use.n=T, col="blue")
tree1

xtabs(~결혼여부 + 쿠폰반응여부, data=skin)
chisq.test(xtabs(~결혼여부 + 쿠폰반응여부, data=skin))

info_gini <- function(x){
  factor_x <- factor(x)
  gini_sum <- 0
  for(str in levels(factor_x)){
    pro <- sum(x==str)/length(x)
    gini_sum <- gini_sum+pro^2
  }
  return (1-gini_sum)
}

first_gini <- info_gini(skin[,"쿠폰반응여부"])

for(str in colnames(skin)[1:5]){
  factors <- levels(skin[[str]])
  
  sum_gini <- 0
  for(str2 in factors){
    text_x <- skin[skin[[str]]==str2,][6]
    sum_gini <- sum_gini+info_gini(text_x[,1])
  }
  cat(str,'---->',sum_gini,'\n')
}

  