library(caret)#R3.5.0가능

idx <- createDataPartition(iris$Species, p=0.7, list=F)

iris_train <- iris[idx, ] #생성된 읶덱스를 이용, 70%의 비율로 학습용 데이터 세트 추출
iris_test <- iris[-idx, ] #생성된 읶덱스를 이용, 30%의 비율로 평가용 데이터 세트 추출

table(iris_train$Species)
table(iris_test$Species)

library(rpart) #의사결정트리 기법을 사용하기 위핚 rpart 패키지 로딩
library(rpart.plot)
library(rattle)
rpart.result<-rpart(Species~., iris_train) #훈련데이터 통합 모형 적합
rpart.result
rpart.plot(rpart.result)

rpart.pred<-predict(rpart.result, iris_test, type="class") #테스트 데이터 이용 평가
rpart.pred
table(rpart.pred, iris_test$Species) #분류 결과도출


library(e1071)
confusionMatrix(rpart.pred, iris_test$Species)
