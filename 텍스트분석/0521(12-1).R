family <- c("Mr. 류", "Mr 류민호", "Ms. Ryu", "Mr Ryu") 
x <- grep("Mr\\.?\\s+[가-힣]+", family, perl = TRUE)
x1 <- family[x]
names_only <- gsub("Mr\\.?\\s+", "", x1)
names_only
