install.packages("tm")
library(tm)

?crude
data("crude")
crude
crude$content
crude[1]

crude[[1]]
crude[[1]]$content
crude[[1]]$meta
crude[[1]]$meta$id  #개별 contents에 접근하는 방법


#함수 자체로 접근하는 방법
meta()
content()

meta(crude[[1]])                   #crude[[1]]$meta와 같은 결과
meta(crude[[1]], tag="id")         #crude[[1]]$meta$id와 같은 결과
content(crude[[1]])                #crude[[1]]$content


#########################################################################################################
#문서를 구조화하는 작업 - 코퍼스
#벡터 형태의 텍스트 데이터


text[1]
text[2]

getSources()
VectorSource(text)

#가져온 데이터를 바탕으로 포커스?를 만든다
VectorSource(text)
VCorpus(VectorSource(text))

corp.docs<-VCorpus(VectorSource(text))
corp.docs


meta(corp.docs[[1]],tag="id")

#얘들 둘 차이가 뭘까 
inspect(corp.docs[[1]])
inspect(corp.docs[1])

#############################################################################################################
corp.docs[[1]]
as.character(corp.docs[[1]])
as.character(corp.docs[[2]])
as.character(corp.docs[[3]])  #하나하나 리스트 요소에 접근해서 동일한 함수임을 밝히며 순차적으로 작업하는 함수가 필요 

#apply -> 행과 열에서 동일한 작업을 할때 반복적으로 처리 
?apply
?lapply
#엥 lapply를 사용하는건가?
#lapply 함수는 리스트 또는 벡터에 함수를 적용하여 각 요소에 대한 결과를 리스트로 반환

#문장을 가져올 때는 content 함수를 사용해야 한다?
lapply(corp.docs,as.character) #첫번째 매개변수는 변수, 두번째 매개변수에는 함수를 기입하는 함수임
lapply(corp.docs,content)
content(corp.docs[[1]])
content(corp.docs[[2]])
content(corp.docs[[3]])

lapply(corp.docs,meta)  #이게 안됨 
str(corp.docs[[1]])


#메타를 가져와서 메타중에 id가 1번인 데이터?를 10번으로 바꿔서 넣기 
corp.docs[[1]]$meta$id
corp.docs[[1]]$meta$id<-"10"
corp.docs[[1]]$meta$id


#데이터 바꾸기 2
#tag 속성을 이용함 
meta(corp.docs[[1]],tag="author",type="local")<-"yangheeb"
corp.docs[[1]]$meta$author




######## 실습 1 ##############################################

author_name<-c("MinJeong","Taemin","MinHyun")
meta(corp.docs,tag="author",type="local")<-source
#meta(corp.docs[[1]],tag="author",type="local")<-author_name //이게 잘못된 거라는데 왜 잘못된건지 나도 모르겠음..
lapply(corp.docs,meta) #근데 이것도 author 3개 각각 하나씩 안 들어가져있는데? 첫번째에 몰빵되어 있음

lapply(corp.docs,content)

#리스트를 풀어서 벡터 형태로 바꾸는 것 => unlist. as.vector 써도 됨 
?unlist
unlist(lapply(corp.docs,content))
as.vector(unlist(lapply(corp.docs,content)))

paste(as.vector(unlist(lapply(corp.docs,content))),collapse =". ")
?paste


######################### 9-2 내용 ######################################
lapply(corp.docs,meta)


#새로운 카테고리 추가
category<-c("health","lifestyle","business")
meta(corp.docs,tag="category",type="local")<-category
lapply(corp.docs,meta,tag="category")
lapply(corp.docs,meta)  #카테고리가 추가된 것을 확인할 수 있음

#기존 카테고리 삭제 - origin 지우기 
meta(corp.docs,tag="origin",type="local")<-NULL
lapply(corp.docs,meta,tag="origin")  #NULL로 바뀐것 확인 가능
lapply(corp.docs,meta)  #origin 태그 사라짐 


#meta 데이터에서 특정 조건을 추출하기 - weight|diet 있는거 가져오기 
#tm_filter()
tm_filter(corp.docs, FUN=function(x) #FUN함수가 논리형으로 들어가야해서? grep()에 any()를 씌워준다 
  any(grep("weight|diet",content(x))))  #2documents를 통해 2개의 문자열이 있다는 것을 확인할 수 있음 

#내용 확인하려고 lapply?를 쓴건지... 잘 모르겟음 ..
lapply(tm_filter(corp.docs, FUN=function(x) 
  any(grep("weight|diet",content(x)))),content) #맨 마지막에 인수를 넣어줘야함. content그래서 넣어줌  

#위에서 생성한 text 벡터 데이터 3줄 중에서 2줄만 추출된 것을 확인 가능 

## 클린코드로 다시 정리

corp.docs.filter <- tm_filter(corp.docs, FUN=function(x)
  any(grep("weight|diet",content(x))))

lapply(corp.docs.filter,content)



#meta 정보에서 특정 정보 추출하기
index<- meta(corp.docs,"author")=="yangheeb"| meta(corp.docs,"author")=="New"
lapply(corp.docs[index],content)


#코퍼스 저장?
writeCorpus(corp.docs)
list.files(pattern="\\.txt")



#############################텍스트 정제##########################
getTransformations()
tm_map()  #변환 패키지를 tm_map()과 함께 사용함

#tm 패키지에서 제공하지 않는 함수?를 사용할 때 content_transform을 추가적으로  사용함 
toupper()
tolower()
content_transformer()

lapply(corp.docs,content)
corp.docs<-tm_map(corp.docs,content_transformer(tolower)) #content에 데이터들이 소문자로 변환된 것을 확인 



#불용어 stopwords
stopwords("english")  #정관사나 지시대명사 등이 이에 속해 있음
corp.docs<-tm_map(corp.docs,removeWords,stopwords("english"))  #removewords에는 뒤에 인자가 필요 ~ 그래서 stopwords 나온것 
lapply(corp.docs,content) #불용어 stopwords가 빠진 것을 확인

#corp.docs content 내용안에 있는 url 주소를 지우기
#새로운 ~를 만들어서 제거
myRemoves<-content_transformer(function(x,pattern){
  return(gsub(pattern,"",x))})

corp.docs<-tm_map(corp.docs,myRemoves,"(f|ht)tp\\S+\\s*")
lapply(corp.docs,content)

corp.docs<-tm_map(corp.docs,removePunctuation)
lapply(corp.docs,content)

corp.docs<-tm_map(corp.docs,removeNumbers)
lapply(corp.docs,content)

corp.docs<-tm_map(corp.docs,stripWhitespace)  #공백이 줄었음 
lapply(corp.docs,content)

corp.docs<-tm_map(corp.docs,content_transformer(trimws))  #문장 시작 끝 공백 줄어드는?
lapply(corp.docs,content)

corp.docs<-tm_map(corp.docs,stemDocument)  #뭔가 없어짐?
lapply(corp.docs,content)
