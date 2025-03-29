install.packages("pander")
library(pander)   #다운로드 받았던 패키지를 지금 사용하겠다 ~

#팬더 패키지를 다운받았기에 사용할 수 있는거
openFileInOS("product.csv")
openFileInOS("product-with-no-header.csv")
openFileInOS("product-missing.csv")
openFileInOS("product.txt")
openFileInOS("product-fwf.txt")
openFileInOS("won-dollar.txt")


#read_*()패키지
install.packages("readr")
library(readr)

read.csv(file="product.csv") #대표적 속성일 경우, file 같은 경우.. 생략 가능함 
read_csv(file="product-with-no-header.csv",
         col_names=c("id","name","price"))

read_csv(file="product-missing.csv", na=".") #점으로 되어 있는 product-missing.csv 파일의의 데이터 값을 결측치로 표시 -> NA로 표시됨
#na="9999"라고 표시한다면, 9999에 해당하는 데이터 값이 na로 표시되어 나타남 


#delim의 기능은 뭘까? -> 임의의 구분자 형식
read_delim(file="product.txt",delim=" ") #txt파일과 csv 파일 출력값이 다르던데 ~ ,, 
#이 코드는 공백으로 구분되어 있으니 니가 알아서 잘 불러와라?...

#언더바 사용과 점 사용의 차이점을 알아둘것 -> tibble이라는 3x3 이런 내용이 표시되고, 윈도우 사이즈에 맞게 압축해서 보여준다? 
read_delim("product-with-no-header.csv",delim=",",
           col_names = c("id","name","price")) #delim에 콤마를 두는 것과 공백을 두는 것에 출력값 차이가 있음. 


#fwf는 뭐하는 놈이고,, -> 고정 길이를 갖는 형식. fix-with-format 
#fwf-*()함수 다양한데 ~ 
fwf_empty()
fwf_cols()


read_fwf(file="product-fwf.txt",
         col_positions = fwf_empty(file="product-fwf.txt",
                                   col_names = c("id","name","price")))
#fwf_empty는 공백의 위치를 내가 ~해서 col_positions에 넘겨주고 file 정보에 넘겨줌?


#칸이 몇칸 몇칸으로 구성되어 있는지를 알때 사용 ~ 
read_fwf(file="prodcut-fwf.txt",
         col_positions = fwf_widths(widths = c(5,10,8),
                                    col_names = c("id","name","price")))



#table은 하나 이상의 빈칸으로 구성된 테이블 형식
read_table(file = "product.txt",
           col_names = c("id","name","price"))


#파일을 불러오는 형식 
read_lines(file="won-dollar.txt")  #5개의 요소로 인식. 인스턴스? 가 5줄인듯??. 한줄 한줄씩 불러옴
# 속성값을 가지고 있는데, skip, n_max .. 요런거 가지고 있음
# 함수에 대한 용법을 알기 위해서는 ?read_lines 이 코드를 쳐서 Help 부분을 찾아보기


read_lines_raw(file.path(R.home("doc"),"AUTHORS"),n_max = 2) #2는 걍 내가 넣음..

Orange
library(help = "datasets")

#패키지에 딸려 있는 데이터셋을 사용할 경우, 패키지를 다운. 외부 데이터를 불러서 사용할수도 ~ 

read_file(file="won-dollar.txt") #\r\n 표시가 한줄한줄 표시로 나타내는 듯?? 따로 따로의 요소로 불러오는 구분자 느낌 





#0313 추가
#parse -> 해당하는 부분의 내용을 추출하는 아이. readr 패키지를 깔았기에 사용할 수 있는 ~
parse_number("$100") #100만 추출되는 데이터

