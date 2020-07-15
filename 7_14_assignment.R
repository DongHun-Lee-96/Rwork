setwd("C:\\Users\\mega\\Desktop\\rwork\\data\\R_data")

library(KoNLP)
library(stringr)
library(wordcloud)
library(RColorBrewer)
library(dplyr)
useSejongDic()

mergeUserDic(data.frame(readLines("제주도여행지.txt"), "ncn"))

dat <- readLines("jeju.txt")
head(dat,20)
str(dat)

dat2 <- str_replace_all(dat, "\\W", " ")
dat2 <- str_replace_all(dat2, "제주", " ")
dat2 <- str_replace_all(dat2, "숙소", " ")
dat2 <- str_replace_all(dat2, "시간", " ")
dat2 <- str_replace_all(dat2, "여행", " ")
head(dat,30)

nouns <- extractNoun(dat2)
str(nouns)

wordcount <- table(unlist(nouns))
head(wordcount,30)

df_wordcount <- as.data.frame(wordcount, stringsAsFactors = F)

df_wordcount <- filter(df_wordcount, nchar(Var1) >= 2)

top <- df_wordcount %>%
  arrange(desc(Freq))
head(top)

pal <- brewer.pal(8, "Dark2")

wordcloud(words = top$Var,
          freq = top$Freq,
          min.freq = 2,
          max.words = 200,
          random.order = F,
          rot.per = .1,
          scale = c(3,0.3),
          colors = pal)

#------------------------------

library(KoNLP)
library(wordcloud)
library(stringr)
useSejongDic()
mergeUserDic(data.frame(readLines("제주도여행지.txt"), "ncn"))
txt <- readLines("jeju.txt")
place <- sapply(txt,extractNoun,USE.NAMES = F)
place

head(unlist(place),30)
cdata<-unlist(place)
place <- str_replace_all(cdata,"[^[:alpha:]]","")

place <- gsub(" ","",place)
txt <- readLines("제주도여행코스gsub.txt")
txt

cnt_txt <- length(txt)
cnt_txt
i<-1
for(i in 1:cnt_txt){
  place <- gsub((txt[i]),"",place)
}
place
place <- Filter(function(x) {nchar(x) >= 2}, place)
write(unlist(place),"jeju_2.txt")
rev <- read.table("jeju_2.txt")
nrow(rev)
wordcount <- table(rev)
head(sort(wordcount,decreasing = T),30)

library(RColorBrewer)
palete <- brewer.pal(8,"Dark2")
wordcloud(names(wordcount),freq=wordcount,scale=c(4,0.3),rot.per=0.1,min.freq=2,random.order=F, colors=palete) 
legend(0.3,1 ,"제주도 추천 여행 코스 분석",cex=0.8,fill=NA,border=NA,bg="white",text.col="red",text.font=2,box.col="red") 


