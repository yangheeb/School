############### paste() 함수 ################################

paste(month.abb,1:12)                               #[1] "Jan 1"  "Feb 2"  "Mar 3"  "Apr 4"  "May 5"  "Jun 6"  "Jul 7"  "Aug 8"  "Sep 9"  "Oct 10" "Nov 11" "Dec 12"
paste(month.abb,1:12,sep = "_")                     #[1] "Jan_1"  "Feb_2"  "Mar_3"  "Apr_4"  "May_5"  "Jun_6"  "Jul_7"  "Aug_8"  "Sep_9"  "Oct_10" "Nov_11" "Dec_12"
paste(month.abb,1:12,sep = "-",collapse = "_")      #[1] "Jan-1_Feb-2_Mar-3_Apr-4_May-5_Jun-6_Jul-7_Aug-8_Sep-9_Oct-10_Nov-11_Dec-12"
paste(month.abb,1:12,sep = "-",collapse = " ")      #[1] "Jan-1 Feb-2 Mar-3 Apr-4 May-5 Jun-6 Jul-7 Aug-8 Sep-9 Oct-10 Nov-11 Dec-12"


outer(1:3,1:3)
outer(c(1,2,3),c(1,2,3))
#     [,1] [,2] [,3]
#[1,]    1    2    3
#[2,]    2    4    6
#[3,]    3    6    9


countries<-c("KOR","US","EU")
stat<-c("GDP","Pop","Area")
outer(countries,stat,FUN=paste,sep="-")
#     [,1]      [,2]      [,3]      
#[1,] "KOR-GDP" "KOR-Pop" "KOR-Area"
#[2,] "US-GDP"  "US-Pop"  "US-Area" 
#[3,] "EU-GDP"  "EU-Pop"  "EU-Area" 



## 고객 주문 결과를 보여주는 시나리오

customer<-"yangheeb"
buysize<-10
deliveryday<-3

paste("hello",customer,", your order of",buysize,
      "product(s) will be delivered within",deliveryday)



#################### sprint() 함수 ##################################################

sprintf("hello %s, your order of %s product(s) will be delivered within %s",   #%s 해서 안에 들어갈 수 있게 된건가?
        customer,buysize,deliveryday)

customer1<-c("Taemin","Jonghyun")
buysize1<-c(10,8,9)
deliveryday1<-c(2,3,7,5)


#이거 왜 에러가 나는거야 ? 
sprintf("hello %s, your order of %s product(s) will be delivered within %s",   #%s 해서 안에 들어갈 수 있게 된건가?
        customer1,buysize1,deliveryday1)




#################### substr() 함수 - 시작과 끝값 설정해서 추출 #####################################################

substr("Text Analytics",start=1,stop=4)  # [1] "Text"
substr("Text Analytics",start=6,stop=14) #[1] "Analytics"

#substring() - 문자열에서 특정 범위의 문자열을 추출하는 데 사용. 시작점만 설정 
substring("Text Analytics",6) #[1] "Analytics"
substring("Text Analytics",5) #[1] " Analytics"

countries<-c("Korea, KR","United states, US","china,CN")
substring(countries,nchar(countries)-1)

#nchar() - 문자열 길이 반환
nchar(countries)-1 



################### grep() 함수 - 특정 패턴에서 일부분 추출  #################################################################################

?islands
head(islands)


# grep() - 패턴이 발견된 문자열의 인덱스를 반환
landnames<-names(islands)
a<-grep(pattern="New",x=landnames)

#인덱스에 있는 내용 추출 
matching_strings <- landnames[a]
matching_strings

grep(pattern="New",x=landnames,value=TRUE)
grep(pattern=" ",x=landnames,value=TRUE)

