quiz <- c("Diamond Shamrock Corp said that\neffective today it had cut its contract prices for crude oil by\n1.50 dlrs a barrel.\n    The reduction brings its posted price for West Texas\nIntermediate to 16.00 dlrs a barrel, the copany said.\n    \"The price reduction today was made in the light of falling\noil product prices and a weak crude oil market,\" a company\nspokeswoman said.\n    Diamond is the latest in a line of U.S. oil companies that\nhave cut its contract, or posted, prices over the last two days\nciting weak oil markets.\n Reuter",
          "OPEC may be forced to meet before a\nscheduled June session to readdress its production cutting\nagreement if the organization wants to halt the current slide\nin oil prices, oil industry analysts said.\n    \"The movement to higher oil prices was never to be as easy\nas OPEC thought. They may need an emergency meeting to sort out\nthe problems,\" said Daniel Yergin, director of Cambridge Energy\nResearch Associates, CERA.\n    Analysts and oil industry sources said the problem OPEC\nfaces is excess oil supply in world oil markets.\n    \"OPEC's problem is not a price problem but a production\nissue and must be addressed in that way,\" said Paul Mlotok, oil\nanalyst with Salomon Brothers Inc.\n    He said the market's earlier optimism about OPEC and its\nability to keep production under control have given way to a\npessimistic outlook that the organization must address soon if\nit wishes to regain the initiative in oil prices.\n    But some other analysts were uncertain that even an\nemergency meeting would address the problem of OPEC production\nabove the 15.8 mln bpd quota set last December.\n    \"OPEC has to learn that in a buyers market you cannot have\ndeemed quotas, fixed prices and set differentials,\" said the\nregional manager for one of the major oil companies who spoke\non condition that he not be named. \"The market is now trying to\nteach them that lesson again,\" he added.\n    David T. Mizrahi, editor of Mideast reports, expects OPEC\nto meet before June, although not immediately. However, he is\nnot optimistic that OPEC can address its principal problems.\n    \"They will not meet now as they try to take advantage of the\nwinter demand to sell their oil, but in late March and April\nwhen demand slackens,\" Mizrahi said.\n    But Mizrahi said that OPEC is unlikely to do anything more\nthan reiterate its agreement to keep output at 15.8 mln bpd.\"\n    Analysts said that the next two months will be critical for\nOPEC's ability to hold together prices and output.\n    \"OPEC must hold to its pact for the next six to eight weeks\nsince buyers will come back into the market then,\" said Dillard\nSpriggs of Petroleum Analysis Ltd in New York.\n    But Bijan Moussavar-Rahmani of Harvard University's Energy\nand Environment Policy Center said that the demand for OPEC oil\nhas been rising through the first quarter and this may have\nprompted excesses in its production.\n    \"Demand for their (OPEC) oil is clearly above 15.8 mln bpd\nand is probably closer to 17 mln bpd or higher now so what we\nare seeing characterized as cheating is OPEC meeting this\ndemand through current production,\" he told Reuters in a\ntelephone interview.\n Reuter")

#crude는 코퍼스 형태임 -> 그 중에서 content에 접근하면 됨 
crude
quiz<-c(crude[[1]]$content,crude[[2]]$content)
quiz


#형태 변환 
#벡터의 형태를 다시 코퍼스로

quiz <- c("Diamond Shamrock Corp said that\neffective today it had cut its contract prices for crude oil by\n1.50 dlrs a barrel.\n    The reduction brings its posted price for West Texas\nIntermediate to 16.00 dlrs a barrel, the copany said.\n    \"The price reduction today was made in the light of falling\noil product prices and a weak crude oil market,\" a company\nspokeswoman said.\n    Diamond is the latest in a line of U.S. oil companies that\nhave cut its contract, or posted, prices over the last two days\nciting weak oil markets.\n Reuter",
          "OPEC may be forced to meet before a\nscheduled June session to readdress its production cutting\nagreement if the organization wants to halt the current slide\nin oil prices, oil industry analysts said.\n    \"The movement to higher oil prices was never to be as easy\nas OPEC thought. They may need an emergency meeting to sort out\nthe problems,\" said Daniel Yergin, director of Cambridge Energy\nResearch Associates, CERA.\n    Analysts and oil industry sources said the problem OPEC\nfaces is excess oil supply in world oil markets.\n    \"OPEC's problem is not a price problem but a production\nissue and must be addressed in that way,\" said Paul Mlotok, oil\nanalyst with Salomon Brothers Inc.\n    He said the market's earlier optimism about OPEC and its\nability to keep production under control have given way to a\npessimistic outlook that the organization must address soon if\nit wishes to regain the initiative in oil prices.\n    But some other analysts were uncertain that even an\nemergency meeting would address the problem of OPEC production\nabove the 15.8 mln bpd quota set last December.\n    \"OPEC has to learn that in a buyers market you cannot have\ndeemed quotas, fixed prices and set differentials,\" said the\nregional manager for one of the major oil companies who spoke\non condition that he not be named. \"The market is now trying to\nteach them that lesson again,\" he added.\n    David T. Mizrahi, editor of Mideast reports, expects OPEC\nto meet before June, although not immediately. However, he is\nnot optimistic that OPEC can address its principal problems.\n    \"They will not meet now as they try to take advantage of the\nwinter demand to sell their oil, but in late March and April\nwhen demand slackens,\" Mizrahi said.\n    But Mizrahi said that OPEC is unlikely to do anything more\nthan reiterate its agreement to keep output at 15.8 mln bpd.\"\n    Analysts said that the next two months will be critical for\nOPEC's ability to hold together prices and output.\n    \"OPEC must hold to its pact for the next six to eight weeks\nsince buyers will come back into the market then,\" said Dillard\nSpriggs of Petroleum Analysis Ltd in New York.\n    But Bijan Moussavar-Rahmani of Harvard University's Energy\nand Environment Policy Center said that the demand for OPEC oil\nhas been rising through the first quarter and this may have\nprompted excesses in its production.\n    \"Demand for their (OPEC) oil is clearly above 15.8 mln bpd\nand is probably closer to 17 mln bpd or higher now so what we\nare seeing characterized as cheating is OPEC meeting this\ndemand through current production,\" he told Reuters in a\ntelephone interview.\n Reuter")

VectorSource(quiz)
corp.docs<-VCorpus(VectorSource(quiz))

lapply(corp.docs,content)
lapply(corp.docs,meta)  #7개의 항목 


#기존 카테고리 삭제 
meta(corp.docs,tag="datetimestamp",type="local")<-NULL
meta(corp.docs,tag="description",type="local")<-NULL
meta(corp.docs,tag="heading",type="local")<-NULL
meta(corp.docs,tag="origin",type="local")<-NULL
lapply(corp.docs,meta,tag="author")


#meta에 있는 author에 정보 추가 
author_name<-c("Ryu min ho","Baek Min Jeong")
meta(corp.docs,tag="author",type="local")<-author_name
lapply(corp.docs,meta)


#OPEC이 들어간 거 추출은 되는데 이게 2번 document인지 그 2값만 처리하는 방법이 뭔지 모르겠음 // 이거에 대한 내용은 찾아봐야겟음
corp.docs.filter <- tm_filter(corp.docs, FUN=function(x)
  any(grep("OPEC",content(x))))

lapply(corp.docs.filter,content)


#####################################################################################################################################
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

#####################################################################################################################################
############# 대소문자, 불용어.. 순으로 텍스트 정제 프로세스 (전처리) // \n문자는 문장 바뀜을 의미하기에 이것도 삭제 ################

corp.docs<-tm_map(corp.docs,content_transformer(tolower))
corp.docs<-tm_map(corp.docs,removeWords,stopwords("english"))

#새로운 ~를 만들어서 제거
#함수를 만드는 연습
#입력받은 숫자 x,y 2개를 더해서 return하는 함수를 만들어 보는 연습을 해볼것 
myRemoves<-content_transformer(function(x,pattern)  #return 전에 뭐를 더 넣는 것 같은 느낌이긴 함? 아닌가?  뭐 어쨌든 x+y값이 return 되게끔 해서 만들어 보기 
  {return(gsub(pattern,"",x))})
corp.docs<-tm_map(corp.docs,myRemoves," \n")
lapply(corp.docs,content)


corp.docs<-tm_map(corp.docs,removePunctuation)
lapply(corp.docs,content)

corp.docs<-tm_map(corp.docs,removeNumbers)
lapply(corp.docs,content)

corp.docs<-tm_map(corp.docs,stripWhitespace)  #공백이 줄었음 
lapply(corp.docs,content)

corp.docs<-tm_map(corp.docs,content_transformer(trimws))  #문장 시작 끝 공백 줄어드는?
lapply(corp.docs,content)

corp.docs<-tm_map(corp.docs,stemDocument) 
lapply(corp.docs,content)


###opec만 대문자로 바꾸기
corp.docs<-tm_map(corp.docs,content_transformer(gsub),
                  pattern="opec",replacement="OPEC")
lapply(corp.docs,content)



#corpus와 tidy-text는 연결되어 있는 것이라고 보면됨. 완전하게 다른 것은 아님
