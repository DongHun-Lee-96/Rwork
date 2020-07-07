library(KoNLP)
library(dplyr)
library(stringr)

useNIADic()

txt <- readLines("C:\\Users\\mega\\Desktop\\rwork\\Doit_R_170717\\Data\\hiphop.txt")
txt <- str_remove_all(txt, "\\W")
head(txt)

extractNoun("대한민국의 영토는 한반도와 그 부속도서서로 한다")
nouns <- extractNoun(txt)
wordcount <- table(unlist(nouns))
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word <- rename(df_word, word = Var1, freq = Freq)
df_word <- filter(df_word, nchar(word)>=2)

top_20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)
top_20
