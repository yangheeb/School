#list 형태. matrix는 숫자만 되지만, list는 여러 유형
#array는 3차원 데이터, dataframe은 여러 유형이 가능함함

a<-list("top",c(2,4,6),c(T,F,T))
a
b<-list(name=c("Minsu","Minchul"),cnt=2,age=c(2,6))
b
c<-list(c("Abe","Bob","Caro","Deb"),c("Weight","height"))  #속성이름을 넣지 않았을때
c
names(c)<-c("Row","Columns")
c



product<-list("A001","Mouse",30000)
product
product[1]  #product에 접근하기 위해서 사용. 대괄호가 1개일 경우
product[[1]]  #대괄호가 2개일 경우 


sales_price<-product[[3]]*0.8
sales_price
# sales_price1<-product[3]*0.8 // 이게 왜 안되는지에 대해 적을 것 !! 


product[c(1,3)] #1,3번째 내용이 출력됨됨
product[c(F,T,T)] #F인 첫번째 데이터만 빼고 출력됨 
product[-2] #-는 제외하고라는 의미 ~

lst<-list(id="A001", name="Mouse", price=30000) #행에 이름이 부여됩니다 
lst[[3]]
lst$price #위에와 같은 데이터가 추출.. 행에 이름을 부여했기 때문에 달러 표시해서 사용할수도 ~
lst[["price"]]  #이렇게 찾을때는 따옴표를 사용할것


#과제 !! 
a<-list(one=1,two=2,three=list(alpha=3.1,beta=3.2)) #three 부분이 중첩된 것을 파악할 수 있음.. three에 alpha값 출력해보기 
a[[3]][[1]] #출력하면 alpha 제목은 없지만 값은 추출됨.. 이게 대괄호 2개 사용의 특징임 


#이건가? 중첩 리스트
a1<-list(one=1,two=2,three=c(alpha=3.1,beta=3.2))
a1[3][1] #이거는 alpha랑 beta값이 다 출력됨. 데이터명이 같이 출력됨
a1$three[1]



b<-list("성명"=list("백민정","이태민","황민현"),"생년월일"=list(020215,930723,950809),"나이"=list(23,32,30))
b[[3]][[1]]




#R에서는 벡터의 유형, 매트릭스 유형, 데이터프레임, 리스트(주머니 개념)
