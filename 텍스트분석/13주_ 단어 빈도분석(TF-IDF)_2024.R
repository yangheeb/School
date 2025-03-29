install.packages("quanteda")

library(quanteda)
data_corpus_inaugural

summary(data_corpus_inaugural)
class(data_corpus_inaugural)  #코퍼스 형태 

library(tidytext)
library(tibble)
library(dplyr)

tidy(data_corpus_inaugural)  #티블 형태의 데이터 프레임 


#일부데이터만 가지고 작업하기 위한 전처리 
us.president.address <- tidy(data_corpus_inaugural) %>% 
  filter(Year > 1990) %>% 
  group_by(President, FirstName) %>% 
  summarise_all(list(~trimws(paste(., collapse = " ")))) %>% #group_by(President, FirstName)작업 이외 변수 
  arrange(Year) %>% 
  ungroup()


us.president.address

library(tm)
?DataframeSource()  # doc_id에 대한 정보 입력 필요

#전처리 작업 
us.president.address <- us.president.address %>% 
  select(text, everything()) %>% 
  add_column(doc_id = 1:nrow(.), .before = 1)  #doc_id가 가장 먼저 옴 // 1부터 순서대로 이름 ㅂ여 

us.president.address


#코퍼스 형태로 만들기 
address.corpus <- VCorpus(DataframeSource(us.president.address))
lapply(address.corpus[1], content)

# ??ó?? 

address.corpus <- tm_map(address.corpus,content_transformer(tolower))
tolower()

address.corpus[[1]]$content


sort(stopwords("english"))

#추가적으로 사용자 정의 불용어 목록을 정의 
Mystopwords <- c(stopwords("english"), c("must", "will", "can", "bless", "america") )

#불용어 제거 
address.corpus <-tm_map(address.corpus, removeWords, Mystopwords)
address.corpus[[1]]$content

#구두점 제거 
address.corpus <-tm_map(address.corpus, removePunctuation)
lapply(address.corpus[1], content)

#숫자자
address.corpus <-tm_map(address.corpus, removeNumbers)
address.corpus <-tm_map(address.corpus, stripWhitespace) #공백 

#앞뒤 공백 제거 
address.corpus <-tm_map(address.corpus, content_transformer(trimws))

#특정 단어 패턴 동일 
address.corpus <- tm_map(address.corpus, content_transformer(gsub),
       pattern = "america|american|americans|americas",
       replacement = "america") # 위에 pattern -> 전부 replacement 단어로 

#DTM
#문서-단어 행렬 생성 
address.dtm <- DocumentTermMatrix(address.corpus)
?DocumentTermMatrix
inspect(address.dtm)

# 용어 빈도 계산
termfreq <- colSums(as.matrix(address.dtm))

#단어의 수 확인 
length(termfreq)

#빈도 높은 상위 및 하위 단어 확인
termfreq[head(order(termfreq, decreasing = TRUE),10)]
termfreq[tail(order(termfreq, decreasing = TRUE),10)]

#특정 빈도 범위의 단어 찾기
findFreqTerms(address.dtm, lowfreq = 40)
findFreqTerms(address.dtm, lowfreq = 50, highfreq = 80)
?findFreqTerms
#findFreqTerms 함수를 사용하여 특정 빈도 범위에 있는 단어를 찾습니다.

library(ggplot2)
class(termfreq)


termfreq.df <- data.frame(word = names(termfreq), frequency= termfreq)
head(termfreq.df)

#빈도가 40 이상인 단어의 빈도를 시각화
ggplot(subset(termfreq.df, frequency >= 40), 
       aes(x=word, y = frequency, fill = word)) +
         geom_col(color = "dimgray") +
         labs(x=NULL, y = "Term Frequency (count)")


ggplot(subset(termfreq.df, frequency >= 40), 
       aes(x=reorder(word, frequency), y = frequency, fill = word)) +
  geom_col(color = "dimgray", width = 0.5, show.legend = FALSE) +
  geom_text(aes(label = frequency), size = 3.5, color = "black", hjust = 0) +
  labs(x=NULL, y = "Term Frequency (count)")+
  coord_flip()

inspect(address.dtm)

Docs(address.dtm)

#문서-단어 행렬의 문서 이름 설정
row.names(address.dtm) <- c("Clinton", "Bush", "Obama", "Trump", "Biden")
Docs(address.dtm)


# ???? Ŭ??????
set.seed(123)

install.packages("wordcloud")
library(wordcloud)
head(termfreq)
wordcloud(words = names(termfreq), freq = termfreq,
          scale = c(3,0.2), min.freq = 10,
          rot.per = 0.1, ramdom.order =FALSE, 
          colors = brewer.pal(6, 'Dark2'))


#tidy 형식으로 변환 후 시각화
address.tf <- tidy(address.dtm)

address.tf <- address.tf %>% 
  mutate(document = factor(document, levels = c("Clinton", "Bush", "Obama", "Trump", "Biden"))) %>% 
  arrange(desc(count)) %>% 
  group_by(document) %>% 
  top_n(n=10, wt = count) %>% 
  ungroup()
address.tf









ggplot(address.tf, 
       aes(x=term, y= count, fill = document)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~document, ncol = 2, scales = "free") +
  labs(x=NULL, y = "Term Frequency count") + 
  coord_flip()

ggplot(address.tf, 
       aes(reorder_within(x=term, by= count, within = document), y= count, fill = document)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~document, ncol = 2, scales = "free") +
  scale_x_reordered() +
  labs(x=NULL, y = "Term Frequency count") + 
  coord_flip()


# TF-IDF계산 후 시각화
#DocumentTermMatrix 함수에 weightTfIdf를 사용하여 TF-IDF를 계산한 후, 상위 10개의 단어를 추출하여 시각화합니다.

address.dtm2 <- DocumentTermMatrix(address.corpus, 
                                   control = list(weighting = weightTfIdf))
?DocumentTermMatrix



inspect(address.dtm2)

row.names(address.dtm2) <- c("Clinton", "Bush", "Obama", "Trump", "Biden")

address.tfidf <- tidy(address.dtm2) %>% 
  mutate(tf_idf = count, count = NULL)


address.tfidf <- address.tfidf %>% 
  mutate(document = factor(document, levels = c("Clinton", "Bush", "Obama", "Trump", "Biden"))) %>% 
  arrange(desc(tf_idf)) %>% 
  group_by(document) %>% 
  top_n(n=10, wt = tf_idf) %>% 
  ungroup()
address.tfidf



ggplot(address.tfidf, 
       aes(reorder_within(x=term, by= tf_idf, within = document), y= tf_idf, fill = document)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~document, ncol = 2, scales = "free") +
  scale_x_reordered() +
  labs(x=NULL, y = "tf_idf") + 
  coord_flip()
