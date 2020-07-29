library(ggvis)
iris %>% 
  ggvis(~Petal.Length,~Petal.Width, fill=~factor(Species)) %>%
  layer_points()

library(class) # k = 1 일 때
set.seed(1234)

idx<-sample(1:NROW(iris),0.7*NROW(iris))
iris.train=iris[idx,]
iris.test=iris[-idx,]

iris_model<-knn(train=iris.train[,-5],
                test=iris.test[,-5],
                cl=iris.train$Species, k=3
)

summary(iris_model)
table(iris_model,iris.test$Species)
