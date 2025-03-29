word2<-c("12 Dec","OK","http://","<TITLE>Time?<TITLE>","12345","Hi there")
word3<-c("12","OK","http://","<TITLE>Time?<TITLE>","12345","Hi there")
word2





intro<-c("min ho:010-2736-3716","haeju:010-123-5644")
#################################### 실습 1 #############################################################
#grep(pattern="숫자",word2) -> 여기서 "숫자" 부분에 들어갈 정규표현식?

grep(pattern="[[:digit:]]",word2)  #[1] 1 5
grep(pattern="\\d",word2)  #[1] 1 5

#실제로 단어를 그대로 가지고 오고 싶다면?
#인덱싱이 아닌 실제 단어가 추출됨 
grep(pattern="\\d",word2,value=T)  #[1] "12 Dec" "12345"


#이건 뭘 추출한거지?
grep(pattern="\\D",word2) #[1] 1 2 3 4 6
grep(pattern="[^[:digit:]]",word2)  #[1] 1 2 3 4 6

grep(pattern="\\D",word3,value=T)   #[1] "OK"  "http://"  "<TITLE>Time?<TITLE>" [4] "Hi there" 


#공백만? 공백이? 들어있는 것을 추출 
#뭔가 이거 잘못 적은 듯? 
grep("\\s",word2,value=T) #[1] "12 Dec"   "Hi there" 
grep("\\s",word3,value=T)



#value=T 안 하면 인덱스 추출 
grep("\\w",word2)  #[1] 1 2 3 4 5 6
grep("[[:alnum:]]",word2)  #[1] 1 2 3 4 5 6
grep("[^\\s]",word2)  #[1] 1 2 3 4 5 6



# +를 아까는 수량자? 로 봄
grep("[[:space:]]+",word2)  #[1] 1 6
grep("[[:space:]]*",word2)  #[1] 1 2 3 4 5 6
grep("[[:space:]]{3}",word2) #integer(0)


string<-c("data anlaysis is useful",
          "business anlytics is helpful",
          "visualization of data is interesting")
?grep
index<-grep(pattern="data",string)  #[1] 1 3
string[index] #[1] "data anlaysis is useful"            [2] "visualiztion of data is interesting"
grepl(pattern="data",string)  #[1]  TRUE FALSE  TRUE








################### 패턴 위치 (1) - regexpr() #############################3
regexpr(pattern="data",string)
###########################################
#[1]  1 -1 18
#attr(,"match.length")
#[1]  4 -1  4
#attr(,"index.type")
#[1] "chars"
#attr(,"useBytes")
#[1] TRUE
#########################################################

################## 패턴 위치 (2) - gregexpr() #################################
gregexpr(pattern="data",string)
#list 형태로 쓰인다? 
###################################################################
#[[1]]
#[1] 1
#attr(,"match.length")
#[1] 4
#attr(,"index.type")
#[1] "chars"
#attr(,"useBytes")
#[1] TRUE

#[[2]]
#[1] -1
#attr(,"match.length")
#[1] -1
#attr(,"index.type")
#[1] "chars"
#attr(,"useBytes")
#[1] TRUE

#[[3]]
#[1] 18
#attr(,"match.length")
#[1] 4
#attr(,"index.type")
#[1] "chars"
#attr(,"useBytes")
#[1] TRUE
##################################################################



################## regmatches() #########################################
regmatches(x=string,regexpr(pattern="data",string)) #[1] "data" "data"
regmatches(x=string,gregexpr(pattern="data",string))
#[[1]]
#[1] "data"

#[[2]]
#character(0)

#[[3]]
#[1] "data"


#invert = TRUE
#패턴과 일치하지 않는 부분 문자열을 추출
regmatches(string,regexpr(pattern="data",string),invert = TRUE)
regmatches(string,gregexpr(pattern="data",string),invert = TRUE)
#같은 결과 출력 
#[[1]]
#[1] ""                   
#[2] " anlaysis is useful"

#[[2]]
#[1] "business anlytics is helpful"

#[[3]]
#[1] "visualization of " " is interesting"  



#string에서 3번째에 있는것은 살리고, 앞에있는 데이터 2개를 수정하는 방법?
sub("data","text",string)
gsub("data","text",string)

string


########## unique() 함수 - 중복을 제거  ############################33
strsplit(string,split=" ")
unlist(strsplit(string,split=" "))
unique(unlist(strsplit(string,split=" ")))  

sub("data","",unique(unlist(strsplit(string,split=" "))))

gsub("of","",string) # of가 없어짐
gsub("of|for|is","",unique(unlist(strsplit(string,split=" "))))

sub("date","data",unique(unlist(strsplit(string,split=" "))))
unique(gsub("data","date",unique(unlist(strsplit(string,split=" ")))))
