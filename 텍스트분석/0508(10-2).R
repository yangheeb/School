text <- c("Crash dieting is not the best way to lose weight. http://bbc.in/1G0J4Agg",
          "A vegetar$ian diet excludes all animal flesh (meat, poultry, seafood).",
          "Economists surveyed by Refinitiv expect the economy added 160,000 jobs.")

source<-c("BBC","FOX","CNN")



#source와 text 열을 가진 tibble 객체를 생성
library(dplyr)
text.df<-tibble(source=source, text=text) 
text.df
class(text.df)

#tokenization
library(tidytext)
?unnest_tokens()  #Split a column into tokens
unnest_tokens(tbl=text.df, output = word, input=text)

#############usage###########################################
#unnest_tokens(
#  tbl,
#  output,
#  input,
#  token = "words",
#  format = c("text", "man", "latex", "html", "xml"),
#  to_lower = TRUE,
#  drop = TRUE,
#  collapse = NULL,
#  ...
#)

#######데이터 프레임 행 더보기 #################################

# text.df는 데이터 프레임, text는 텍스트 열을 나타냅니다.
result <- unnest_tokens(tbl = text.df, output = word, input = text)
# 처음 10개의 결과만 출력
print(result, n = 10)

###################################################################

head(iris)
iris%>%head(10)  #iris 데이터에서 10개 추출

#text.df 데이터프레임에서 text 열의 텍스트를 단어로 분할하여 tidy.docs 데이터프레임에 저장
tidy.docs<-text.df %>%
  unnest_tokens(input=text, output = word)  #input이맨 위에서 정의한 text 내용, output이 word

#데이터프레임이나 다른 객체의 !!모든 행!!을 출력하라는 명령
print(tidy.docs,n=Inf) 

#source 열을 기준으로 그룹화하고, 각 그룹별로 단어의 수를 계산한 후 그 결과를 내림차순으로 정렬
tidy.docs %>% count(source) %>% arrange(desc(n)) 

#################### 불필요한 단어 제거 - stop_words #######################
?anti_join #첫 번째 데이터프레임에는 있지만 두 번째 데이터프레임에는 없는 행만을 반환

stop_words

#stop_words 데이터프레임에 있는 불용어를 제외한 단어들을 반환
#2가지 방법 
anti_join(tidy.docs,stop_words,by="word")  #by 매개변수는 두 데이터프레임을 연결하는 열을 지정. 여기서는 word 열을 기준 
tidy.docs<-tidy.docs%>%anti_join(stop_words,by="word")
tidy.docs

#제외하고 싶은 특정 단어 리스트를 만들어 tibble로 표현   
word.removed<-tibble(word=c("http","bbc.in","1g0j4agg"))
word.removed

tidy.docs<-tidy.docs%>%anti_join(word.removed,by="word")  #by 매개변수는 두 데이터프레임을 연결하는 열을 지정. 여기서는 word 열을 기준 
tidy.docs

tidy.docs$word


#################### 특정 단어 찾기 - grep() ###################
#정규 표현식을 사용하여 tidy.docs 데이터프레임의 word 열에서 숫자를 포함한 단어를 찾기 

#"\\d": 숫자를 나타내는 정규 표현식. 이는 0부터 9까지의 어떤 숫자 한 개를 의미
# +: 앞의 패턴이 하나 이상의 문자열로 나타나는 것을 의미
# --> "\\d+"은 하나 이상의 !!숫자로 이루어진 문자열!! 을 찾음

grep("\\d+",tidy.docs$word) # grep(): 문자열에서 패턴을 검색하고 해당 패턴이 일치하는 !!위치(인덱스)를 반환!!하는 함수
#grep() 함수에서 반환되는 인덱스 번호는 1이 아니라 0부터 시작 => 그래서 해당 출력값이 20임 !!
#위에서 토큰화를 한 것을 바탕으로 160,000이라는 숫자로 이루어진 문자열의 인덱스가 20인거임. 그래서 grep을 통해 20이 출력됨 

#반환된 인덱스를 사용하여 해당 행을 데이터프레임에서 제거
tidy.docs<-tidy.docs[-grep("\\d+",tidy.docs$word),] #tidy.docs<-tidy.docs[integer(0),] = tidy.docs$word 열에 숫자를 포함하는 단어가 없어서 해당 단어의 인덱스를 찾을 수 없는 경우
tidy.docs


#################### 문자열에서 패턴을 찾아 다른 문자열로 대체하는 데 사용 - gsub() #########################
#"\\(f|ht\\)tp\\S+\\s*"는 정규 표현식

#\\(f|ht\\)tp는 "http", "https", "ftp"와 같은 문자열을 찾음
#\\S+는 공백이 아닌 문자(즉, URL)를 찾음 
#\\s*는 공백 문자(스페이스, 탭, 개행)을 찾음 
#빈 문자열 ""은 찾은 패턴을 대체할 문자열로, 여기서는 URL을 제거하기 위해 아무 것도 대체하지 않는 것을 의미

text.df$text<-gsub("(f|ht)tp\\S+\\s*", "",text.df$text)
text.df$text

#\\d+ 패턴을 사용하여 숫자를 찾아 제거
#"\\d+"는 하나 이상의 숫자로 이루어진 문자열을 찾는 정규 표현식
text.df$text<-gsub("\\d+","",text.df$text)
text.df$text


##토큰화 시킨 tidy.docs에서 gsub()를 이용해 다른 문자열로 대체 

tidy.docs<-text.df%>%
  unnest_tokens(input=text,output =word)
tidy.docs

tidy.docs<-tidy.docs %>% anti_join(stop_words,by="word")
tidy.docs

#"ian"을 ""로 대체
tidy.docs$word<-gsub("ian","",tidy.docs$word)
tidy.docs$word


#"economists"를 "economy"로 대체 
tidy.docs$word<-gsub("economists","economy",tidy.docs$word)
tidy.docs$word


###################
library(tm)
#VectorSource()함수는 tm패키지에 있는 VCorpus()함수와 함께 사용됨 
#VectorSource(text)는 tm 패키지에서 사용되는 텍스트 데이터 구조를 만들기 위한 입력으로 사용

corpus.docs<-VCorpus(VectorSource(text))  #텍스트를 커널러리(corpus) 객체로 변환
corpus.docs

################### corp.docs 안에 있는 내용 찾는 법 ################
corp.docs[[1]]
corp.docs[[1]]$content
corp.docs[[1]]$meta

#위에랑 밑에랑 똑같다네 
meta(corp.docs[[1]])
content(corp.docs[[1]])
corp.docs[[1]]$meta$id

##########################################################

#corpus.docs에 있는 각 문서에 대해 "author" 메타데이터를 설정. 위에서 입력해뒀는 source의 값이 각각의 author에 들어감 
meta(corpus.docs,tag="author",type="local")<-source

lapply(corpus.docs,meta)

#unnest_tokens(output,input) --> 텍스트를 단어로 분할하고, 결과를 word 열에 저장
#source라는 이름의 새로운 열을 만들고, 해당 열에는 문서의 작성자 정보를 포함
#그리고 word 열은 분할된 단어를 포함하도록 선택

tidy(corpus.docs)%>% unnest_tokens(word,text) %>% select(source=author,word)

