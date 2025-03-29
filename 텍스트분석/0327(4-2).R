#################### paste()함수 ########################

a<-c(1,5,9,13,17,21)
a

paste(a)
paste(a,collapse =",")


#################### Apply() 계열 함수 ###############
#배열 또는 행렬에 함수를 적용하는 함수
#각 행 또는 열에 대해 함수를 적용

apply()
lapply()
sapply()
?apply() #apply(X, MARGIN, FUN, ..., simplify = TRUE)




x<-matrix(1:20,4,5) #4행 5열 
x

#margin = 1: 함수를 각 열에 적용합니다.
#margin = 2: 함수를 각 행에 적용합니다.
#margin = c(1, 2): 함수를 행과 열에 모두 적용합니다.


           #차원    #함수 
apply(X=x,MARGIN =1,FUN = max) #열 - 맨 오른쪽
apply(X=x,MARGIN =2,FUN = max) #행 - 맨 아래쪽
apply(X=x,MARGIN =2,FUN = min) #행 - 맨 위
apply(X=x,MARGIN =2,FUN = mean) #행 - 각 행의 평균  
apply(X=x,MARGIN =2,FUN = sum) #각 행의 합계


y<-array(1:24,c(4,3,2)) #4개의 행, 3개의 열, 2개의 행렬
y
#########################################################
#, , 1

#[,1] [,2] [,3]
#[1,]    1    5    9
#[2,]    2    6   10
#[3,]    3    7   11
#[4,]    4    8   12

#, , 2

#[,1] [,2] [,3]
#[1,]   13   17   21
#[2,]   14   18   22
#[3,]   15   19   23
#[4,]   16   20   24
##########################################################

#margin = 1 // 행을 기준으로 병합 
apply(y,1,paste,collapse=",")
#[1] "1,5,9,13,17,21"  "2,6,10,14,18,22"
#[3] "3,7,11,15,19,23" "4,8,12,16,20,24"


#margin = 2 // 열을 기준으로 병합 
apply(y,2,paste,collapse=",")
#[1] "1,2,3,4,13,14,15,16"   
#[2] "5,6,7,8,17,18,19,20"   
#[3] "9,10,11,12,21,22,23,24"



#margin = 3 // 3차원 배열 또는 행렬에 대한 새로운 차원에 대해 함수를 적용
apply(y,3,paste,collapse=",")
#[1] "1,2,3,4,5,6,7,8,9,10,11,12"         
#[2] "13,14,15,16,17,18,19,20,21,22,23,24"


#margin = c(1, 2) // 함수를 행과 열에 모두 적용 
apply(y,c(1,2),paste,collapse=",")
#     [,1]   [,2]   [,3]   
#[1,] "1,13" "5,17" "9,21" 
#[2,] "2,14" "6,18" "10,22"
#[3,] "3,15" "7,19" "11,23"
#[4,] "4,16" "8,20" "12,24"


############### Titanic 데이터셋 #########################
Titanic
##########################################################
#, , Age = Child, Survived = No

#Sex
#Class  Male Female
#1st     0      0
#2nd     0      0
#3rd    35     17
#Crew    0      0

#, , Age = Adult, Survived = No

#Sex
#Class  Male Female
#1st   118      4
#2nd   154     13
#3rd   387     89
#Crew  670      3

#, , Age = Child, Survived = Yes

#Sex
#Class  Male Female
#1st     5      1
#2nd    11     13
#3rd    13     14
#Crew    0      0

#, , Age = Adult, Survived = Yes

#Sex
#Class  Male Female
#1st    57    140
#2nd    14     80
#3rd    75     76
#Crew  192     20

#############################################################
str(Titanic)

#margin = 1 // 행을 기준으로 병합 
apply(Titanic,1,sum)
apply(Titanic,"Class",sum)
# 1st  2nd  3rd Crew 
# 325  285  706  885 


#margin = 2 // 열을 기준으로 병합 
apply(Titanic,2,sum)
#Male Female 
#1731    470


#margin = 3 // Age = Child , Age = Adult 끼리 결합
apply(Titanic,3,sum)
#Child Adult 
#109  2092 


# margin = 4 // Survived = Yes, Survived = No 끼리 결합 
apply(Titanic,4,sum)
#  No  Yes 
#1490  711 

apply(Titanic,c(1,4),sum)
#      Survived
#Class   No Yes
#1st  122 203
#2nd  167 118
#3rd  528 178
#Crew 673 212


####################### 리스트에서의 apply() ############################################
exams<-list(Spring_2020=c(78,60,89,90,96,54),
            Spring_2021=c(85,78,69,90,95),
            Spring_2022=c(98,96,94,89,99,100,87),
            Spring_2023=c(86,98,76,89,57,79))
exams
###################################################
#$Spring_2020
#[1] 78 60 89 90 96 54

#$Spring_2021
#[1] 85 78 69 90 95

#$Spring_2022
#[1]  98  96  94  89  99 100  87

#$Spring_2023
#[1] 86 98 76 89 57 79
#####################################################
lapply(exams,length) #그 결과를 리스트로 반환
sapply(exams,length) #결과를 벡터 혹은 행렬로 변환
####################################################
#Spring_2020 Spring_2021 Spring_2022 
#6           5           7 
#Spring_2023 
#6 
###################################################
sapply(exams,mean)
sapply(exams,sd)
sapply(exams,range)
lapply(exams,range)
######################################
#$Spring_2020
#[1] 54 96

#$Spring_2021
#[1] 69 95

#$Spring_2022
#[1]  87 100

#$Spring_2023
#[1] 57 98

####################### iris 데이터셋 ###################
iris
