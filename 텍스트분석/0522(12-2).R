text <- c("Crash dieting is not the best way to lose weight. http://bbc.in/1G0J4Agg",
          "A vegetar$ian diet excludes all animal flesh (meat, poultry, seafood).",
          "Economists surveyed by Refinitiv expect the economy added 160,000 jobs.")

library(tm)

#텍스트 전처리

corpus.docs<-VCorpus(VectorSource(text))
corpus.docs

lapply(corpus.docs,meta)
lapply(corpus.docs,content)

corpus.docs<-tm_map(corpus.docs,content_transformer(tolower))  #소문자 변환 
corpus.docs<-tm_map(corpus.docs,removeWords,stopwords('english'))  #불용어 제거거

myRemove<-content_transformer(function(x,pattern)  #특정 패턴을 가지는 문자열 
  {return(gsub(pattern,"",x))})

corpus.docs<-tm_map(corpus.docs,myRemove,"(f|ht)tp\\S+\\s*")
corpus.docs<-tm_map(corpus.docs,removePunctuation)  #문장부호 삭제 

lapply(corpus.docs,content)
corpus.docs[[1]]$content

corpus.docs<-tm_map(corpus.docs,removeNumbers)  #숫자 삭제 
corpus.docs<-tm_map(corpus.docs,stripWhitespace)  #공백이 줄었음 
corpus.docs<-tm_map(corpus.docs,content_transformer(trimws))  #문장 시작 끝 공백 줄어드는?
corpus.docs<-tm_map(corpus.docs,stemDocument)  #어간 추출 
corpus.docs<-tm_map(corpus.docs,content_transformer(gsub),
                    pattern='economist',replacement='economi')  #동의어 처리 


#34분쯤부터 
corpus.dtm<-DocumentTermMatrix(corpus.docs,
                               control = list(wordLengths=c(2,Inf)))
nTerms(corpus.dtm)  #19
nDocs(corpus.dtm)   #3

Terms(corpus.dtm)   #단어 추출
Docs(corpus.dtm)   #[1] "1" "2" "3"

row.names(corpus.dtm)<-c("BBC","CNN","FOX")


inspect(corpus.dtm)
inspect(corpus.dtm[1:3,10:19])



################## Tidy Text 형식의 데이터 셋 ###########
text <- c("Crash dieting is not the best way to lose weight. http://bbc.in/1G0J4Agg",
          "A vegetar$ian diet excludes all animal flesh (meat, poultry, seafood).",
          "Economists surveyed by Refinitiv expect the economy added 160,000 jobs.")
source<-c("BBC","CNN","FOX")

library(dplyr)
library(tidytext)
library(SnowballC)

text.df<-tibble(source=source,text=text)
text.df<-gsub("(f|ht)tp\\S+\\s*","",text.df$text)  #url 삭제
text.df<-gsub("\\d+","",text.df$text)

tidy.do
