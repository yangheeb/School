paste(month.abb,1:12)
paste(month.abb,1:12,sep="-")
paste(month.abb,1:12,sep="-",collapse = "-")

#곱하기 표시법?
outer(1:3,1:3)
outer(c(1,2,3),c(1,2,3))

countries<-c("KOR","US","EU")
stat<-c("GDP","POP","Area")

#outer(countries,stat) 
#에러: 수치 또는 복소수형태의 행렬 혹은 벡터 인자가 요구됩니다

#곱하기를 사용하는 것이 아니기에 FUN=paste를 사용. 
#붙이는 구분자를 sep 사용해서 ~ . 조합만 하는걸로 ~ .. 모든 요소의 쌍을 만들어준다 ~
outer(countries,stat,FUN = paste,sep="-")


################### 고객 주문 결과를 보여주는 시나리오 #############################

#case1
customer<-"yangheeb"
buysize<-10
deliveryday<-2

paste("hello",customer,"your order of",buysize,"product(s) will be delivered within",deliveryday)
#sprintf() 사용
sprintf("hello %s, your order of %s product(s) will be delivered within %s",
        customer,buysize,deliveryday)


#case2
customer<-"yangheeb"
buysize<-c(10,8,9)
deliveryday<-c(2,3,7.5)

sprintf("hello %s, your order of %s product(s) will be delivered within %s",
        customer,buysize,deliveryday)
#[1] "hello yangheeb, your order of 10 product(s) will be delivered within 2" 
#[2] "hello yangheeb, your order of 8 product(s) will be delivered within 3"  
#[3] "hello yangheeb, your order of 9 product(s) will be delivered within 7.5"


#case3
customer<-c("yangheeb","taemin","jonghyun")
buysize<-c(10,8,9)
deliveryday<-c(2,3,7.5)

sprintf("hello %s, your order of %s product(s) will be delivered within %s",
        customer,buysize,deliveryday)
#[1] "hello yangheeb, your order of 10 product(s) will be delivered within 2" 
#[2] "hello taemin, your order of 8 product(s) will be delivered within 3"    
#[3] "hello jonghyun, your order of 9 product(s) will be delivered within 7.5"




#%f도 있는데 내가 안한듯?


#시작범위, 종료범위 지정
substr("Text Analytics",start=6,stop=14)
#시작범위만 지정 
substring("Text Analytics",6)

class<-c("Data analytics","Data visualiztion","Data science introduction")
substr(class,1,4)
substring(class,6) #6번째 글자부터가 추출

countries<-c("Korea,KR","United states,US","China,CN")
substring(countries,nchar(countries)-1) 
#"ea" "KR" "US" "CN" // -1이랑 뭔 관련인지는 모르겟음 ..

#앞에 있는 나라만 뽑아보기
substring(countries,1,nchar(countries)-3)  #이거 맞나? 
substr(countries,nchar(countries)-1,nchar(countries))




#############grep()######################################
?islands
head(islands)
colnames(islands)
 
landnames<-names(islands)
landnames

index<-grep(pattern = "New",x=landnames)
index
landnames[index]
landnames[grep(pattern="New",x=landnames)]
grep(pattern="New",x=landnames,value=TRUE)


sub()
gsub()



