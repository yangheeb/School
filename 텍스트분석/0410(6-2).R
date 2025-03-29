txt<-"Data Analytics is useful. Data Analytics is also interesting"
words<-c("at","bat","cat","chaenomeloes","chase","cheep","check","cheese","chick","hat")
words2<-c("12 DEC","OK","http://","<TITLE>Time?<TITLE>","12345","Hi there")

#################### 텍스트의 치환 #######################################
sub() #문자열에서 첫 번째로 발견된 패턴만을 대체
gsub() #모든 패턴을 대체

txt<-"Data Analytics is useful. Data Analytics is also interesting"

sub(pattern = "Data", replacement = "Business", x=txt) #txt에서 첫번째 문장 Data만 Business로 바뀜
gsub(pattern = "Data", replacement = "Business", x=txt) #txt에서 모든 패턴 즉 Data단어가 Business로 바뀜
gsub(pattern = "Data",replacement = " ",x=txt) #txt에서 모든 패턴 즉 Data단어가 공백으로 바뀜

#간소화된 코드
gsub("Data","Business",txt)

text2<-c("product.csv","order.csv","customer.csv")
gsub(".csv","",text2) #text2에 있는 벡터 값마다 .csv가 없어진 상태로 출력 


#################### 정규표현식 ############################################
words<-c("at","bat","cat","chaenomeloes","chase","cheep","check","cheese","chick","hat","chasse")

#value의 기본값은 FALSE. value=FALSE 이게 인덱스 출력되는 것. 아님 아예 value를 안 쓰는 방법을 택하면 됨 
grep("che",words,value=TRUE)  
#[1] "cheep"  "check"  "cheese"

grep("a",words,value=TRUE)
grep("at",words,value=TRUE)


################### or 연산 수행 #######################
# or 연산 수행 (1)
#[ch]는 "c" 또는 "h" 중 하나를 나타내는 정규표현식 패턴 ->  "c" 또는 "h"를 포함하는 문자열이 반환 
grep("[ch]",words,value=TRUE)
#########################################################
#[1] "cat"          "chaenomeloes" "chase"       
#[4] "cheep"        "check"        "cheese"      
#[7] "chick"        "hat"          "chasse"  
###########################################################
# or 연산 수행 (2)
grep("che|at",words,value=TRUE)


grep("ch(e|i)ch",words,value = TRUE)
grep("[[:punct:]]", words, value = TRUE)  #구두점 문자

################## 수량자 ?*+ ##################
grep("chas?e",words,value=TRUE) #?바로 앞에 오는 문자 "s"가 0개 또는 1개이어야 함
#chasse에서는 s가 2개이기 때문에 안됨
#아예 없거나 하나만 존재해야함 

grep("chas*e",words,value=TRUE) #* 앞에 있는 문자 =s 가  0개 이상인 것
grep("chas+e",words,value=TRUE) # +앞에 있는 문자가 하나 이상 존재 


#"ch"로 시작하고,
#"a"가 0개 이상이거나 "e"가 0개 이상 나올 수 있고("|")
#"se"로 끝나는 문자열
grep("ch(a*|e*)se",words,value =TRUE)




################## 메타문자 ^$ #############################
grep("^c",words,value =TRUE)

grep("$c",words,value =TRUE)
grep("c$",words,value=TRUE)

grep("$t",words,value =TRUE)
grep("t$",words,value=TRUE)

grep("^c.t$",words,value=TRUE)
grep("^c.*t$",words,value=TRUE)
grep("^[ch]?at", words, value = TRUE)



################## 문자 클래스#############################

words2 <- c("12 Dec", "OK", "http://", "<TITLE>Time?<TITLE>", "12534-45", "Hi there")
words3 <- c("12", "OK", "http://", "<TITLE>Time?<TITLE>", "12345", "Hi there")
grep("\\s", words, value = T)
grep("\\S", words, value = T)
grep("[^[:space:]]", words, value = TRUE)

grep("\\D", words2, value = T)
grep("\\d", words2,  value = T)
grep("[[:alnum:]]", words2, value = TRUE)
grep("[[:alpha:]]", words2, value = TRUE)
grep("[[:digit:]]", words2, value = TRUE)
grep("[^[:digit:]]", words2, value = TRUE)
grep("[[:punct:]]", words2, value = TRUE)

words<-c("min ho:010-2736-3716","haeju:010-123-5644")
words<-strsplit(words,split=":") 
grep("-",words,value=TRUE) 

library(tidyverse)

#문자 클래스 시퀀스

grep("\\w", words2, value = TRUE)

grep("[^\\s]", words2, value = TRUE)
grep("[[:space:]]+", words2, value = TRUE)

grep("\\D+", words2, value = TRUE)





