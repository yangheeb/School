install.packages(c("pander", "XML"))
install.packages("pander")
install.packages(c("RCurl", "stringr", "readr", "XML", "rvest"))
install.packages('rvest')
install.packages('stringr')

# 실습 웹페이지 생성

html.string <- c(
  '<!DOCTYPE html>',
  '<html>',
  '<title>Movie Quotes</title>',
  '</html>',
  '<body>',
  '<h1>Famous Quotes from Movies</h1>',
  '<div time="1h 39min" genre="drama" lang="english" date="December/16/1970">',
  '<h2>Ali MacGraw as Jennifer Cavilleri</h2>',
  '<p><i>Love means never having to say you\'re sorry.</i></p>',
  '<p><b>Movie: </b>Love Story</p>',
  '</div>',
  '<div time="2h 22min" genre="comedy" date="June/23/1994">',
  '<h2>Tom Hanks as Forrest Gump</h2>',
  "<p><i>My mama always said, 'Life was like a box of chocolates; you never know what you\'re gonna get.'</i></p>",
  "<p><i>Mama says, 'Stupid is as stupid does.'</i></p>",
  '<p><b>Movie: </b><a href="http://www.imdb.com/title/tt0109830/?ref_=nv_sr_1">Forrest Gump</a></p>',
  '</div>',
  '<p>',
  '<b>Sources:</b><br>',
  '<a href="http://www.afi.com/"><i>American Film Institute</i></a><br>',
  '<a href="http://www.hollywoodreporter.com/"><i>Hollywood Reporters</i></a>',
  '</p>',
  '</body>',
  '</html>'
)

writeLines(html.string, "moviequotes.html")

library(pander)
openFileInOS("moviequotes.html")


# 파싱을 통해 html/xml 문서를 dom 트리 구조로 만들어주기
library(XML)
quotes <- htmlParse("moviequotes.html")
quotes


##### 노드셋 추출 연습: 영화 대사 포함된 노드셋만 추출

# 절대경로만 사용
xpathSApply(doc=quotes, path="/html/body/div/p/i")

# 상대경로 사용
xpathSApply(quotes, "//body//p/i")

# 보다 간단한 방법도 가능
xpathSApply(quotes, "//p/i")

# 와일드카드 *: 임의의 노드 대체
xpathSApply(quotes, "//div/*/i")
xpathSApply(quotes, "//div/node()/i")




######################### 영화 정보 크롤링@IMDB #########################


url <- "https://www.imdb.com/title/tt6166392/?ref_=nv_sr_srsg_0_tt_5_nm_3_q_wonka"


library(rvest)

html <- read_html(url)

####### 파싱된 문서로부터 데이터 추출

# 기사 제목 추출
title <- html %>% html_nodes(xpath = "//span[@class='hero__primary-text']") %>% html_text()
title

# 개봉년도
year <- html %>% html_nodes(xpath= "//a[@class='ipc-link ipc-link--baseAlt ipc-link--inherit-color']") %>% html_text()

year<- html %>% html_nodes(xpath= "//*[@id='__next']/main/div/section[1]/section/div[3]/section/section/div[2]/div[1]/ul/li[1]/a") %>% html_text()


# 평점은??

grade<- html %>% html_nodes(xpath="//*[@id='__next']/main/div/section[1]/section/div[3]/section/section/div[3]/div[2]/div[2]/div[1]/div/div[1]/a") %>% html_text()
grade

# 영화 줄거리??
summary<- html %>% html_nodes(xpath ="//*[@id='__next']/main/div/section[1]/div/section/div/div[1]/section[6]/div[2]/div[1]/div/div/div") %>% html_text()
summary

#//*[@id="__next"]/main/div/section[1]/div/section/div/div[1]/section[6]/div[2]/div[1]/div/div/div

###### 댓글 추출

url_comment = "https://www.imdb.com/title/tt6166392/reviews/?ref_=tt_ql_2"
html<-read_html(url_comment)


#댓글 수
count<-html %>% html_nodes(xpath ="//*[@id='main']/section/div[2]/div[1]/div/span") %>% html_text()
count

#텍스트 데이터 지우기
gsub('[^0-9]','',count)
gsub('[a-zA-Z, ]','',count)
gsub('\\D','',count)


#리뷰 추출
review<-html%>%html_nodes(xpath="//div[@class='text show-more__control']") %>% html_text()
review
str(review)


#작성자 id
id<-html%>%html_nodes(xpath="//span[@class='display-name-link']/a")%>% html_text()

id2<-html%>%html_nodes(xpath="//span[@class='display-name-link']")%>% html_text()
id2


#날짜추출
date<-html%>%html_nodes(xpath="//span[@class='review-date']")%>% html_text()
date

install.packages("lubridate")
library(lubridate)

date<-dmy(date)
date


#데이터 프레임 만들기
datad=data.frame(id,date,summary,review)
data1

