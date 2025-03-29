#수업 ppt

name<-c("KIM", "LEE", "HAN", "SHIN", "PARK")
gender<-as.factor(c("M", "F", "M", "M", "F"))  #팩터 형태로 바꿈
math<-c(100, 80, 75, 95, 65)
english<-c(80, 100, 60, 70, 80)
korean<-c(50, 70, 80, 100, 100)
attend<-c(T, F, T, T, F)
a<-data.frame(name, gender, math, english, korean, attend, stringsAsFactors=T)
# 만들어 둔 벡터를 데이터 프레임으로 결합 (stringsAsFactors: 문자형 중 규칙적인 패턴을 찾아 범주형으로 인식하는 옵션) 
a
list()
data.frame()
name
gender   #levels에 F M 이라고 등장함 !! factor의 차이점임 ~ 
math
english


# rbind(기존 데이터 프레임, 추가할 데이터 프레임): 행 추가 // 행을 기준으로 붙이는 작업 // 
name<-c("JANG", "JEONG")
gender<-as.factor(c("M", "F"))
math<-c(100, 80)
english<-c(80, 100)
korean<-c(50, 70)
attend<-c(T, F)

b<-data.frame(name, gender, math, english, korean, attend)  #새로운 데이터프레임 b 생성
b
c<-rbind(a, b) # rbind(기존 데이터 프레임, 추가할 데이터 프레임): 행 추가
c



# cbind(기존 데이터 프레임, 추가할 데이터 프레임 or 벡터)
social<-c(100, 80, 50, 65, 70)
science<-c(80, 55, 75, 60, 100)
d<-cbind(a, social, science) # cbind(기존 데이터 프레임, 추가할 데이터 프레임 or 벡터)
d


e
e<-transform(a, social=c(100, 80, 50, 65, 70), science=c(80, 55, 75, 60, 100))
# transform(기존 데이터 프레임, 추가할 열 이름=데이터)

name<-c("LEE", "KIM", "HAN", "SHIN", "PARK")
japanese<-c(100, 60, 70, 20, 50)
f<-data.frame(name, japanese)   #f라는 데이터프레임 새롭게 생성// japanese가 새롭게 등장함 !!
f

#여기서 원래 a 데이터 프레임과 cbind(a,japanese)를 한다면,,
#데이터프레임이 합쳐지기는 함 !!
#다만 a와 japanese 정렬 순서가 다르게 되었더라면 !! 데이터 값에서 큰 오류가 발생함 ~~~~



# 그래서 새롭게 등장한 개념 !!
# merge (기존 데이터 프레임, 추가할 데이터 프레임, key=“기준으로 할 열 제목“)
g<-merge(a, f, key="name")  #name이란걸 기준으로 해서 니가 자동적으로 붙여줘 ~~ 
g  #name 정렬 순서가 달라진 것을 확인할 수 있었다 


####################################################################################################
#실습예제1
df1<-data.frame(sex="female",month=1,weight=3.5)
df1

df2<-data.frame(sex="male",month=3,weight=3.5)
df3<-data.frame(sex="female",month=4,weight=7.5)
df4<-data.frame(sex="male",month=1,weight=4.5)
df5<-data.frame(sex="female",month=5,weight=5.5)

lst<-list(df1,df2,df3,df4,df5)    #맨 밑에 실습했던것이랑 차이가 뭔지 다시 한번 볼것 !!
class(lst)

lst[[1]]
lst[[2]]

rbind(lst[[3]],lst[[5]])
#rbind(lst[[3]],lst[[4]],lst[[5]])와 같이 반복적 작업이 계속 생겨나가는 문제 발생 !!
##for문과 동일한 작업을 하는 간편한 기능은 없을까 ?? 

##여기에 대한 해결책 --> do.call()
#순차적으로 동일한 작업을 하는 ??

do.call(rbind,lst)
do1<-do.call(rbind,lst)
class(do1)  #데이터프레임으로 형태가 만들어짐 !! 

#####################################################################################################
#실습예제2
lst1<-list(sex="female",month=1,weight=3.5)
lst2<-list(sex="male",month=3,weight=3.5)
lst3<-list(sex="female",month=4,weight=7.5)
lst4<-list(sex="male",month=1,weight=4.5)
lst5<-list(sex="female",month=5,weight=5.5)

list(lst1,lst2,lst3,lst4,lst5)  #데이터프레임보다 모양 더 복잡하노 ~ 리스트 안에 리스트가 들어가는 형태임 ~
lst<-list(lst1,lst2,lst3,lst4,lst5) #진짜 하나 하나씩 엔터 쳐서 다 출력됨
lst[[1]]  #se, month, weight 각각 엔터 쳐서 따로 따로 나옴 
lst[[2]]
class(lst[[2]]) #list가 반환

##리스트 -> 데이터프레임으로 변환하는 법 !! --> as.data.frame()
as.data.frame(lst[[1]])  
#리스트 형태에서는 데이터들이 아래로 향하지만, 데이터프레임에서는 옆으로 합쳐지는 것을 확인할 수 있다 !! 

as.data.frame(lst[[2]]) 
as.data.frame(lst[[3]]) 
as.data.frame(lst[[4]]) 
as.data.frame(lst[[5]]) 

#lapply(lst,as.data.frame)
#lapply가 위에 저 거지같은 귀찮음들을 한번에 해결할 수 있음
lapply(lst,as.data.frame)
lst_sub<-lapply(lst,as.data.frame)
class(lst_sub)

do.call(rbind,lst_sub)  #한번에 다 합쳐침 !!
aa<-do.call(rbind,lapply(lst,as.data.frame))  
class(aa)        
######################################################################################################



a$name # 데이터 프레임 a에서 name 행만 추출
a[,1:2] # 데이터 프레임 a에서 1~2번째 열만 추출 (범위 없이 단일로도 사용 가능)
a[2:3,] # 데이터 프레임 a에서 2~3번째 행만 추출 (범위 없이 단일로도 사용 가능)
a[2:3, 1:2] # 데이터 프레임 a에서 2~3번째 행, 1~2번째 열만 추출 (범위 없이 단일로도 사용 가능)
a[-1,] # 데이터 프레임 a에서 1번째 행을 제외한 모든 행 추출 (범위로도 사용 가능) 


a[a$math>=70,] # 데이터 프레임 a에서 math가 70 이상인 행만 추출 (cf. >=: 이상, >: 초과)
a[a$name=="KIM",] # 데이터 프레임 a에서 name이 KIM인 행만 추출 (cf. a==b: 동치, a=b: b를 a에 할당)
a[a$english<90,] # 데이터 프레임 a에서 english가 90 미만인 행만 추출 (cf. <=: 이하, <: 미만)
a[a$math>=70&a$korean>=70,] # 데이터 프레임 a에서 math가 70 이상이고 korean이 70 이상인 행만 추출 (&: and)
a[a$math<90|a$korean<90] # 데이터 프레임 a에서 math가 90 미만이거나 korean이 90 미만인 행만 추출 (|: or)


h<-subset(a, select=c(name, math, korean), subset=(math>=50 & korean>=70))
# 데이터 프레임 a에서 math가 50 이상, Korean이 70이상인 데이터 중에서 name, math, korean 열만 추출
# subset(데이터 프레임, select=c(열 제목 or 번호), subset=(조건)
h







##############################################################################################

#수업시간 코드
list(id="A001",name="Mouse",price=30000) #제목명과 값이 전부 각각 출력됨
product<-list(id="A001",name="Mouse",price=30000) #alt+'-'
product

product[[3]]  #30000이라는 숫자만 추출됨
product$price

product[[2]] #Mouse라는 값만 추출됨

#데이터값 변경
product[[3]]<-40000  #40000이라는 변수를 할당하면 됨
product

product$name<-"Keyboard"
product


#(에러1)product[[3]]<-30000,40000 // 2개의 데이터값을 넣으려면 항상 combine을 사용해서 넣어야함
product[[3]]<-c(30000,40000)
product

#(에러2)대괄호를 하나만 사용할때. 리스트 인덱싱할때. 데이터값을 변경할 경우
#여러 개의 데이터값을 넣으려면 항상 combine을 사용할 것 
#product[3]<-c(30000,40000,50000)



#실습1
a<-list(day=list("Mon","Tue","Wed","Thr","Fri","Sat","Sun"),count=list(400,500,600,700,800,900))

names<-c("Mon","Tue","Wed","Thr","Fri","Sat","Sun")
value<-c(400,500,600,700,800,900,1000)

b<-list(c(names,value)) #난 하다가 망햇음... // 
# 음 근데 난 combine을 사용해서 했는데, 답안 코드랑 어떤 모양으로 다른지 눈으로 다시 확인해볼것



#실습1-코드
names<-c("Mon","Tue","Wed","Thr","Fri","Sat","Sun")
value<-c(400,500,600,700,800,900,1000)
t.d<-list()
t.d[names]<-value

t.d1<-list()
#t.d1[[names]]<-value //에러
t.d
list(names,value)  #내가 위에서 했던것과 차이가 있음을 확인


#리스트에서의 비교연산자 사용
t.d<750   #true, false로 값을 반환하는 것을 확인할 수 있음

t.d.h<-t.d[t.d>=750]

#비교 연산자를 사용해서 원하는 값의 데이터를 뽑아서 추출한 후 변수에 저장하는 과정 
t.d[t.d>=750]  #얘는 조건식을 바꿨음


t.d[t.d<750]<-NULL
t.d

#############################################################################################
