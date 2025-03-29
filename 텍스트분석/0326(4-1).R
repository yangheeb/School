?mtcars
str(mtcars)  #데이터 프레임 
head(mtcars,5)

#행 이름 변수가 어떤것이 있는지 추출 
colnames(mtcars)
names(mtcars)

#열 이름 추출 
rownames(mtcars)

#######################################################################################################################
### subset()함수  

# 실습 1. mpg>30 인것을 골라서 추출해보기
subset(mtcars,subset=mpg>30,
       select=mpg)

######################################################################################################################
# 실습 2. 평균 이상인 사람을 추려서 이름 확인해보고 싶은 교수님
subset(mtcars,subset=mpg>mean(mpg),
       select=mpg)

# mean(mpg)이거는 사용이 안됨 --> 어느 데이터에 있는 mpg인지 알 수 없음
# mean(mtcars$mpg)라고 사용할 것
mean(mtcars$mpg)

######################################################################################################################
# 실습 3. cyl=4 and am=0, c(mpg,hp,wt,am) 조건 만족해서 추려낼것 

subset(mtcars, cyl == 4 & am == 0, 
       select = c(mpg, hp, wt, am))   #근데 이게 이 코드가 맞음?

######################################################################################################################
# 실습 4. subset을 사용 안하고 위 실습 3 조건을 추출하는 법
mtcars[mtcars$cyl == 4 & mtcars$am == 0, c("mpg", "hp", "wt", "am")]

######################################################################################################################

?USArrests
View(USArrests)
head(subset(USArrests,select=-UrbanPop))  #UrbanPop만 빼고 추출
cor(subset(USArrests,select=-UrbanPop))   #변수들 간의 상관관계 
cor(subset(USArrests,select=-c(UrbanPop,Rape)))   #Rape 상관관계도 빠진 것을 확인할 수 있음


#######################################################################################################################
#tibble()
#data.frame(), as.data.frame()
#tibble(), as_tibble()

install.packages("tibble")
library(tibble)
v1<-c("A001","A002","A003")
v2<-c("마우스","키보드","USB")
v3<-c(30000,35000,40000)

data.frame(id=v1,name=v2,price=v3)  #기존 데이터프레임을 만드는 방법
tibble(id=v1,name=v2,price=v3)      #티블을 사용함

iris
class(iris)  #데이터프레임
str(iris)
as_tibble(iris)  #보여주는 크기에 따라서 적절하게 행 조절해 보여줌 

tibble(id=c(1:3),
       data=list(tibble(x=1,y=2),
                 tibble(x=4,5, y=6:7),
                 tibble(x=10)))                   #교수님이 잘못 만든 모양


tibble(id=c(1:3),
       data=list(tibble(x=1,y=2),
                 tibble(x=c(4,5), y=6:7),
                 tibble(x=10)))


data.frame(data=list(tibble(x=1,y=2),     
                     tibble(x=4,5, y=6:7),
                     tibble(x=10)))            #나는 뭘 뽑아온거지? 


tb<-tibble(id=c(1:3),
       data=list(tibble(x=1,y=2),
                 tibble(x=c(4,5), y=6:7),
                 tibble(x=10)))
tb[[2]][[2]]

## 교수님 답 2x2 추출
tb$data[2]   #근데 내 답이랑 답은 똑같긴 함
tb$data[[2]]


######################################################################################################

install.packages("Lahman")
library(Lahman)
Batting
str(Batting)
head(Batting,6)

Batting.tbl<-as_tibble(Batting)
print(Batting.tbl)
print(Batting.tbl,n=50)  #head 함수에서는 tbl이 n=50 개 처럼은 안 먹힘. print 사용해야함 

###################################################################################################
