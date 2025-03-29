##############################################################
fox.says <- " It is only with the HEART that one can See Rightly"
fox.said <- "what is essential is invisible to the eye"
p1 <- "You come at four in the afternoon, then at three I shall bebine to be happy"
p2 <- "One runs the irst of weeping a litter, if one lets himself be tamed"
p3 <- "What makes the desert beautiful is that somewhere it hides a well"
fox.said <- " WHAT IS ESSENTIAL is invisible to the Eye"
txt<- "Data Analytics is useful. Data Analytics is also interesting"
words <- c("at", "bat", "cat", "chaenomeloes", "chase", 
           "cheep", "check", "cheese", "chick", "hat")
words2 <- c("12 Dec", "OK", "http://", "<TITLE>Time?<TITLE>", "12345", "Hi there")

##############################################################################################
x<-"We have a dream" 
class(x)
nchar(x) #길이를 return
length(x)


y<-c("We","have","a","dream")
y

length(y)
nchar(y)  #각각의 요소 길이를 return
nchar(y[4])

letters
sort(letters,decreasing=T)

################################################################################################

tolower()
toupper()

tolower(fox.says)
toupper(fox.says)


####################### 문자열 text split - strsplit() ; 텍스트 분할 #####################################

#strsplit(fox.said) <- 이거 에러남
#strsplit(fox.said)에서 다음과 같은 에러가 발생했습니다:
#기본값이 없는 인수 "split"가 누락되어 있습니다. --> split라는 속성값을 써주어서 무엇을 기준으로 분할할지 명시 


strsplit(fox.said,split="") # 글자 결과가 하나하나씩 다 나눠짐
strsplit(fox.said,split=" ")  #split에 공백 안 두니까 글자 결과가 하나하나씩 다 나눠짐

####################################
#[[1]]
#[1] "what"      "is"        "essential"
#[4] "is"        "invisible" "to"            #리스트 형태!! 
#[7] "the"       "eye"
#######################################
class(strsplit(fox.said,split=""))
class(strsplit(fox.said,split=" ")) 
#텍스트 분할하면 !!리스트 형태!!로 저장됨 
#여러 형태,길이의 데이터를 수용 가능한 리스트이기에 class가 list인것을 수용하려는 것 같음



#strsplit은 리스트 형태이니까 -> 리스트 인덱싱 
strsplit(fox.said,split=" ")[[1]][[1]] #[1] "what"
strsplit(fox.said,split=" ")[[1]][5]   #[1] "invisible"





###################### unlist #################################################################

#strsplit(fox.said,split=" ")해서 리스트 형태 되었던 것을 roll-back 시켜서 원래의 문자인 벡터 형태로 돌려놓는 함수

fox.said.words<-unlist(strsplit(fox.said,split=" ")) 
fox.said.words

####################################
#[1] "what"      "is"        "essential"
#[4] "is"        "invisible" "to"          # 리스트 풀어줌 !! 
#[7] "the"       "eye"   
######################################

fox.said.words[5]  #[1] "invisible"
strsplit(fox.said,split=" ")[1]
#[[1]]
#[1] "what"      "is"        "essential"
#[4] "is"        "invisible" "to"       
#[7] "the"       "eye"  
## 전체 리스트가 출력 








############## 백터 strsplit() #####################################


littleprince<-c(p1,p2,p3)
littleprince

strsplit(littleprince,split=" ")   #분할해서 리스트 형태 
#[[1]]
#[1] "You"        "come"       "at"        
#[4] "four"       "in"         "the"       
#[7] "afternoon," "then"       "at"        
#[10] "three"      "I"          "shall"     
#[13] "bebine"     "to"         "be"        
#[16] "happy"     

#[[2]]
#[1] "One"     "runs"    "the"     "irst"   
#[5] "of"      "weeping" "a"       "litter,"
#[9] "if"      "one"     "lets"    "himself"
#[13] "be"      "tamed"  

#[[3]]
#[1] "What"      "makes"     "the"      
#[4] "desert"    "beautiful" "is"       
#[7] "that"      "somewhere" "it"       
#[10] "hides"     "a"         "well" 


unlist(strsplit(littleprince,split=" "))  #리스트를 푸는 형태 -> 전부 문자열 
#[1] "You"        "come"       "at"        
#[4] "four"       "in"         "the"       
#[7] "afternoon," "then"       "at"        
#[10] "three"      "I"          "shall"     
#[13] "bebine"     "to"         "be"        
#[16] "happy"      "One"        "runs"      
#[19] "the"        "irst"       "of"        
#[22] "weeping"    "a"          "litter,"   
#[25] "if"         "one"        "lets"      
#[28] "himself"    "be"         "tamed"     
#[31] "What"       "makes"      "the"       
#[34] "desert"     "beautiful"  "is"        
#[37] "that"       "somewhere"  "it"        
#[40] "hides"      "a"          "well"

tolower(unlist(strsplit(littleprince,split=" ")))
#이 결과에서 중복되는 단어를 지우고 싶을때?

#unique()함수를 사용 
unique(tolower(unlist(strsplit(littleprince,split=" "))))

###################################################################################################

paste("Everyone","wants","to","fly",collapse = "-")
paste("Everyone","wants","to","fly",sep="")
paste("Everyone","wants","to","fly",sep=":")

unlist(strsplit(littleprince,split=" "))
paste(unlist(strsplit(littleprince,split=" ")))  #차이 없음?
paste(unlist(strsplit(littleprince,split=" ")),collapse = "-")
paste(unlist(strsplit(littleprince,split=" ")),sep="-") #안됨


heroes<-c("백민정","이태민","황민현","김종현")
colors<-c("빨강","파랑","노랑","녹색")

paste(heroes,colors,sep = ":")  #따옴표가 각각 존재. heroes와 colors 사이에 :가 위치함 
paste(heroes,colors,collapse  = ":")  #따옴표? 통으로 다 털어버린다?? 따옴표가 지금 하나만 존재함


########################################################################################################

#뭐라고한거임 ㅋㅋㅋ 지혼자 궁시렁 거리면 요청사항을 어케 다 알아들음 ㅋㅋㅋㅋ

