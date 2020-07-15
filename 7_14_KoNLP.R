#install.packages("multilinguer")
#install.packages("rJava")
#install.packages("memoise")
#install.packages("wordcloud")
#Sys.setenv(JAVA_HOME="C:\\Program Files\\Java\\jdk1.8.0_251")
#Sys.getenv("JAVA_HOME")
#update.packages()

library(rJava)
library(multilinguer)
library(KoNLP)
library(stringr)
library(dplyr)
library(wordcloud)
library(RColorBrewer)
library(stringr)

useNIADic()

# testing if packages are installed properly
res <- extractNoun("아버지가 방에 들어가신다")
res 

# read lines from .txt file
txt <- readLines("C:\\Users\\mega\\Desktop\\rwork\\Doit_R_170717\\Data\\hiphop.txt")
head(txt)
tail(txt)

# replacing special characters with blank using regular expression
txt <- str_replace_all(txt, "\\W", " ")
head(txt)
tail(txt)

# extract noun from txt file and count the frequency using table()
nouns <- extractNoun(txt)
wordcount <- table(unlist(nouns))

# convert to dataframe and rename column for better understanding
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word <- rename(df_word, word=Var1, freq=Freq)

# filter rows with more than two words
df_word <- filter(df_word, nchar(word)>=2)

# arrange in descending order
top_20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)

# set color list
pal <- brewer.pal(8, "Dark2")

# set number of words to be shown
set.seed(1234)

# creating a wordcloud
wordcloud(words = df_word$word,
          freq = df_word$freq,
          min.freq = 2,
          max.words = 200,
          random.order = F,
          rot.per = .1,
          scale = c(4,0.3),
          colors = pal)


# ------------------------------------------------------------

txt2 <- "R러브 책으로 R 프로그래밍을 시작하세요~!"
strsplit(txt2, " ")

extractNoun(txt2)

txt3 <- "우리 모두 R라뷰 책으로 정말 재미있게 공부해요"
txt4 <- SimplePos09(txt3)
txt4

txt_n <- str_match(txt4,'([A-Z가-힣]+)/N') # 명사 확인하기
txt_n

#--------------------------------------------------------