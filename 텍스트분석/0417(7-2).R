library(stringr)

string<-c("data anlaysis is useful",
          "business anlytics is helpful",
          "visualization of data is interesting")



######### str_detect() - grepl()과 동일한 기능 ###################

str_detect(string=string,pattern = "data")  
#[1]  TRUE FALSE  TRUE 
#"data"라는 글자의 유무를 알려줌 

str_detect(string,"DATA")  #[1] FALSE FALSE FALSE

#ignore_case = TRUE를 사용하면서 맨 위에랑 동일한 결과가 나옴 
str_detect(string,fixed("DATA",ignore_case = TRUE))
#[1]  TRUE FALSE  TRUE

str_detect(c("aby","acy","a.y"),"a.y")  #일치 여부 확인 
str_detect(c("aby","acy","a.y"),"a\\.y")
#[1] FALSE FALSE  TRUE

#fixed("a.y")
str_detect(c("aby","acy","a.y"),fixed("a.y"))  #정확한 일치 여부 판단 
#[1] FALSE FALSE  TRUE



######### str_locate() - 위치 추출 ##############################
str_locate(string,"data") #마지막만 나왔음 
str_locate_all(string,"data")


######### str_extract() - 문자열 추출 ####################
#regmatches()와 같은 기능 

str_extract_all(string,"data",simplify=TRUE) #행렬 또는 벡터 형식
str_extract_all(string,"data")  #리스트 형태 
str_extract(string,"data")      #문자열 형태 그대로 
#[1] "data" NA     "data"

unlist(str_extract_all(string,"data")) #리스트 형태를 문자로 반환하는데 
# 위에랑 차이점은 [1] "data" "data" 이렇게 출력됨 



########### sentences에 stringr() 활용하기 ####################

sentiments5<-sentences[1:5]
#[1] "The birch canoe slid on the smooth planks." 
#[2] "Glue the sheet to the dark blue background."
#[3] "It's easy to tell the depth of a well."     
#[4] "These days a chicken leg is a rare dish."   
#[5] "Rice is often served in round bowls."  

str_extract_all(sentiments5,"(a|A|the|The)(\\w+)")  #리스트 형태 
# 그 글자가 시작되는 부분 부터 한 단어로씩만 추출
###############################################################
#[[1]]
#[1] "anoe" "anks"

#[[2]]
#[1] "ark"       "ackground"

#[[3]]
#[1] "asy"

#[[4]]
#[1] "These" "ays"   "are"  

#[[5]]
#character(0)
#str_extract(string,"data")   
################################################################

str_extract(sentiments5,"(a|A|the|The)(\\w+)")
#[1] "anoe"  "ark"   "asy"   "These" NA    

str_match(sentiments5,"(a|A|the|The)(\\w+)")  #벡터로? 
str_match_all(sentiments5,"(a|A|the|The)(\\w+)")


#### str_replace() 치환 #################
str_replace(string,"data","text") #데이터 -> 텍스트 로 치환 
str_replace_all(string,"data","text")



########### 분할 #########################

str_split(string," ")
str_split(sentiments5," ")
unlist(str_split(sentiments5," "))
unique(unlist(str_split(sentiments5," ")))
str_split(sentiments5," ",n=5,simplify=TRUE) #행렬 또는 벡터 형식


############### 추가 기능 ####################
str_length(string)
str_count(string)
#위에 둘이 같은 값

str_count(string,"data")
str_count(string,"\\w+")  # \\w+는 하나 이상의 문자, 숫자 및 밑줄(_)로 이루어진 "단어"


############## str_pad()
mon<-1:12
str_pad(mon,width = 2,side="left",pad="0")
#[1] "01" "02" "03" "04" "05" "06" "07" "08"
#[9] "09" "10" "11" "12"

string_pad<-str_pad(string,width = max(str_length(string)),
                    side="both",pad="0")
string_pad
#[1] "000000data anlaysis is useful0000000"
#[2] "0000business anlytics is helpful0000"
#[3] "visualization of data is interesting"

########str_trim()
str_trim(string_pad,side = "both")
