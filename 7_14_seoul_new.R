setwd("C:\\Users\\mega\\Desktop\\rwork\\data\\R_data")
dat <- readLines("seoul_new.txt")
class(dat)
str(dat)

library(KoNLP)
library(wordcloud)

dat2 <- sapply(dat, extractNoun, USE.NAMES = F)
dat2
str(dat2)

#test
#num <- list(1:5, c(6,7,8))
#num

head(unlist(dat2), 10)
dat3 <- unlist(dat2)

dat4 <- gsub("\\d","", dat3)
dat4 <- gsub("서울시", "", dat4)
dat4 <- gsub("서울", "", dat4)
dat4 <- gsub("요청", "", dat4)
dat4 <- gsub("제안", "", dat4)
dat4 <- gsub("-", "", dat4)
dat4 <- gsub("님", "", dat4)
dat4 <- gsub("OO", "", dat4)
dat4

write(unlist(dat4), "seoul_2.txt")

dat5 <- read.table("seoul_2.txt")
head(dat5)
nrow(dat5)

wordcount <- table(dat5)

head(sort(wordcount, decreasing=T), 20)

library(RColorBrewer)
palete <- brewer.pal(9, "Set3")

wordcloud(names(wordcount),
          freq=wordcount,
          scale=c(5,1),
          rot.per=0.25,
          min.freq=1,
          random.order=F,
          random.color=T,
          colors=palete)

legend(0.3,1,
       "서울시 응답소 요청사항 분석",
       cex=0.8,
       fill=NA,
       border=NA,
       bg="white",
       text.col="red",
       text.font=2,
       box.col="red")
#-------------------------------------------------------------------