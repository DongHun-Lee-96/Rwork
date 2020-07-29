######## hierarchical clust #################
library(ggplot2)
data(diamonds)
head(diamonds)
str(diamonds)

t<-sample(1:nrow(diamonds), 1000)

test<-diamonds[t,]
dim(test)
test

mydia<-test[c("price","carat","depth","table")]

result<-hclust(dist(mydia),method="ave") #거리값을 이용핚 계층적 군집화

plot(result, hang=-1)

################## k means clustering #########################

result2 <- kmeans(mydia,3) #군집수 =3
names(result2)
result2

g1<-subset(mydia, result2$cluster==1)
summary(g1)

g2<-subset(mydia, result2$cluster==2)
summary(g2)

g3<-subset(mydia, result2$cluster==3)
summary(g3)

str(mydia)

mydia$cluster<-result2$cluster
head(mydia)

cor(mydia[,-5], method="pearson")
plot(mydia[,-5])
plot(mydia$carat, mydia$price,col=mydia$cluster)
