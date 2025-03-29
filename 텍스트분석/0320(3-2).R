#검색하는 기능 - ?state 
?state  #state {datasets}를 통해 내장되어 있는 함수임을 알수 있음
state.abb
state.area
state.center
state.division
state.name
state.region
state.x77

state #내장함수이기 때문에 오류나는 것이 맞음 
str(state.x77)





#문자열 벡터를 factor로 바꾸어서 사용 -> stringsAsFactors = T
us.state<-data.frame(state.abb,state.name,state.region,state.area,
                     stringsAsFactors = F) 

#여기서는 F를 썼기 떄문에 factor로 안 바꾸고, 벡터->데이터프레임으로 
#원본 데이터 형태인 데이터 프레임 형식을 유지하기 위해 F 쓰는 듯 



us.state   #행과 열을 지정해주는 ? 뭐가 필요하다고??
str(us.state) #데이터 프레임 




############ 데이터 프레임에서 인덱싱 추출 --> matrix 형태  [행,열]######################

#us.state 데이터 프레임의 state.region 때문에 열이 팩터로 지정. 아니었으면 백터의 형태일것임 
#레벨에는 "Northeast", "South", "North Central", "West"가 있음을 나타냄 
#펙터라서 Levels가 존재하는 것임

us.state[10,3] #[1] South // Levels: Northeast South North Central West

#데이터 변경 
us.state[10,3]<-"West"
us.state[10,3] #[1] West // Levels: Northeast South North Central West
#South가 West로 바뀜 

#### 차이점(1)#################################
#두 번째 열의 데이터 벡터 형태 추출 - 문자열 자체가 추출

us.state[ , 2]  #" " 형태로 글자가 출력됨 
us.state[[2]] 
us.state[["state.name"]]
us.state$state.name

#문자열 자체로 나옴. [[]]는 요소에 대한 접근이기에 
#[1] "Alabama"        "Alaska"   이런식


#### 차이점(2)##################################
#데이터 프레임 행을 선택하는 것처럼 보임
#결과는 근데 데이터 프레임 맞음 

us.state[2] 
us.state[ , 2,drop=FALSE]

#2개를 추출하고 싶을 때 - 밑에 2개 같은 결과값임 
us.state[ ,c(2,3)] 
us.state[c(2,3)]

us.state[c("state.name","state.area")]   
us.state[,c("state.name","state.area")]  #matrix 형태 인덱싱

####################################################

us.state[["state.name"]]
us.state$state.name
us.state[ ,"state.name"] #3개가 똑같아보이지만, 차이점은 있음.. ?? 이 부분 필기 더 적을것 



us.state[c("state.name","state.area")]
us.state[,c("state.name","state.area")]






############# contition based indexing ########################

state.x77
class(state.x77)  #기존에는 "matrix" "array" 



#메드릭스 -> 데이터 프레임로 전환
#as.data.frame()을 사용

states<-as.data.frame(state.x77) 
states
class(states)     #"data.frame"


############### 데이터프레임에서 행의 이름을 뽑아오기 #####################

row.names(states)


############## 데이터프레임에 새로운 열 추가 #############################

#states라는 데이터프레임에 Name이라는 열 추가
states$Name<-row.names(states)
head(states)

############## 기존의 행 이름 데이터를 없애기 ###################################

row.names(states)<-NULL
states #행 이름 전부 없어지고 그 자리에 숫자 번호로 바뀜 


############### 데이터 프레임에서 조건에 만족하는 데이터 추출  #######################################
#50개의 데이터 중에서 일부만 추출하기


#states$Income은 문자열 자체가 출력됨. 6315 이런식 
rich.states<-states[states$Income>5000,
                    c("Name","Income")]


rich.states


large.states<-states[states$Area>10000,
                     c("Name","Area")]
large.states





############### merge 함수 ################################################
############### 사용법 ###########################################
#states[원래 여기에 조건 하나만 넣었다?,]
#merge 함수의 디폴드값 
## Default S3 method:
#merge(x, y, ...)

## S3 method for class 'data.frame'
#merge(x, y, by = intersect(names(x), names(y)),
#      by.x = by, by.y = by, all = FALSE, all.x = all, all.y = all,
#      sort = TRUE, suffixes = c(".x",".y"), no.dups = TRUE,
#      incomparables = NULL, ...)

#########################################
merge(rich.states, large.states) #inner join
merge(rich.states, large.states, all.x =TRUE, key="Name") #left join 
merge(rich.states, large.states, all.x =FALSE, key="Name") #right join 




