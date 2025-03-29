?lower.tri
m2 <- matrix(1:20, 4, 5)
m2 <- matrix(1:20, 4, 5, byrow=T)
m2
lower.tri(m2)
lower.tri(m2,diag=T)
m2[lower.tri(m2)] <- NA
m2

m2[upper.tri(m2)]<-NA
m2


#문자를 표현하는 문자표현식 방법


p1 <- "You come at four in the afternoon, then at three I shall bebine to be happy"
p2 <- "One runs the irst of weeping a litter, if one lets himself be tamed"
p3 <- "What makes the desert beautiful is that somewhere it hides a well"

littleprince<-c(p1,p2,p3)
littleprince

a<-strsplit(littleprince,split=" ")[[3]][[8]]
a<-"anywhere"
strsplit(littleprince,split=" ")

unlist(strsplit(littleprince,split=" "))

#paste()함수
#컬럼 수가 다를때는 부족한 부분에 있는거 앞으로 다시 돌아가서 사용  