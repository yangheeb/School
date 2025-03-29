# 텍스트 벡터 생성 
text <- c("Crash dieting is not the best way to lose weight. http://bbc.in/1G0J4Agg",
          "A vegetarian diet excludes all animal flesh (meat, poultry, seafood).",
          "Economists surveyed by Refinitiv expect the economy added 160,000 jobs.")

library(tm)

# 텍스트 전처리 

#Verctor를 통해 코퍼스 형태로 만든다 
corpus.docs <- VCorpus(VectorSource(text))
lapply(corpus.docs, meta)      #코퍼스에서 meta 부분 확인 
lapply(corpus.docs, content)   #코퍼스에서 content 부분 확인

#tm에 없는 함수라 content_transformer 사용 ＝＞ 전처리 하기
corpus.docs <- tm_map(corpus.docs, content_transformer(tolower)) #소문자 변환

#stopwords 통해 불용어 제거
corpus.docs <- tm_map(corpus.docs, removeWords, stopwords('english')) 

#특정 패턴을 가지는 문자를 gsub로 추출해 변수로 저장 
myRemove <- content_transformer(function(x, pattern) 
{return(gsub(pattern,"",x))})

#없애기 
corpus.docs <- tm_map(corpus.docs, myRemove, "(f|ht)tp\\S+\\s*") #함수를 이용한 url 제거 pus.docs <- tm_map(corpus.docs, removePunctuation) #????문장부호 삭제 corpus.docs, content)
corpus.d
corpus.docs[[1]]$content.docs <- tm_m <-orpus.docs, removeNumbers) #???? ??�숫자 삭제
corpus.docs <- tm_map(corpus.docs, stripWhitespace) #여백 삭제 tm_map(corpus.docs, content_transformer(trimws)) #?ؽ?Ʈ ?յ??? ??텍스트 앞뒤 없애기 ap(corpus.docs, stemDocument) #? ????
corpus.doc어간 추출 ap(corpus.docs, content_transformer(gsub),
                      pattern='economist', replacement='economi') #???Ǿ? ó??

corpus.동의어 처리 me
######### DTM #########
ntTermMatrix(corpus.docs, 
                   control = list(wordLengths = c(2,Inf)))

nTerms(corpus.dtm)  #단어 2개 이상 -> 리스트 형태로 
n#이렇게 되면 3개의 document (=맨위에서 생성한거 3개), terms 19개 생김 
# Non-/sparse entries: 20/37 -> 총 3x19=57에서 

Docs(corpus.dtm)
T  # 총 단어 수 
nDocs(corpus.dtm)   # 총 문서 수 Docs(corpus.dtm)
r   #어떤 단어들이 포함되는지 ow.names(corpus.dt  # [1] "1" "2" "3"m
#docs에 이름 부여 
) <- c("BBC", "CNN", "FoX")

inspect(corpus.dtm)

#term 일부 보기 
inspect(corpus.dtm[1
#term만 일부 보기 -> 10:19
:3 ,10:19])



### Tidy text ?????? ?????? ?? 
t 형식의 데이터 셋 이용해서 ~ eting is not the best way to lose weight. http://bbc.in/1G0J4Agg",
          "A vegetarian diet excludes all animal flesh (meat, poultry, seafood).",
          "Economists surveyed by Refinitiv expect the economy added 160,000 jobs.")
source <- c("BBC", "CNN", "FOX")

library(dplyr)
library(tidytext)
library(SnowballC)

text.df <- tibble(so
# 벡터 -> 티블 형태로 만듦 
urce=source, text=text)
text.df

text.df$text <- gsub("(f|ht)tp\\S+\\s*", "", text.df$text) #url ??��
text.df$text <-삭제 \d+", "", text.df$text) #???? ??��
tidy.docs <- t숫자 삭제  
unnest_tokens(output=word, input=text) %>%  #??ūȭ 
  anti_join(stop_wor토큰화 -> word로 바뀜 ="word") %>%  #?ҿ??? ????�� Ȱ???? ?ҿ??? 불용어 사전을 활용한 불용어 제거  ???? 
tidy.docs$word <- gsub("\어간 추출 t
idy.docs$word) #????��??
tidy.docs$word <- gsub("eco공백 제거 onomi", tidy.docs$word) #???Ǿ? ó??


tidy.dtm <- tidy.docs %>% 동의어 처리 e, word) ocs

tidy.d%>% 
  cast_dtm(document = source, term = word, value = n)
tidy.dtm

Terms(tidy.dtm)
Docs(tidy.dtm)
inspect(tidy.dtm[1:2,3:5])
tidy.dtm <-as.data.frame(inspect(tidy.dt






m))

tidy(tidy.dtm)

tidy.dtm <- as.data.frame(tidy.dtm)
tity.tdm <- t(tidy.dtm)






















