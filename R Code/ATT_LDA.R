
##read the input csv files, and combine them together
##input files include reviews from Dallas-area retail stores 
##and US retail stores in top 100 cities.
att_dallas <- read.csv("sample_data/ATT_dallas_reviews_lvl2.csv")
att_us <- read.csv("sample_data/ATT_US_reviews.csv")

att_dallas <- data.frame(att_dallas$reviews)
names(att_dallas)[1] <- "reviews"

att_us <- data.frame(att_us$reviews)
names(att_us)[1] <- "reviews"

row1 <- nrow(att_dallas)
row2 <- nrow(att_us)

att <- rbind(att_dallas, att_us)

###########################################################
## rawTextProcess: function for review raw data preprocessing
## input: the reviews column of dataframe
## output: preprocessed document term matrix
## use TFIDF to compute words weights and extract key terms
###########################################################
rawTextProcess <- function(my_text)
{
  library(tm)
  library(SnowballC)  
  library(stringr)
  
  docs <- Corpus(VectorSource(my_text))
  #remove weird characters appear in the text
  docs <- tm_map(docs, str_replace_all,"[^[A-Za-z0-9]]", " ")
  docs <- tm_map(docs, removePunctuation)
  docs <- tm_map(docs, removeNumbers)
  docs <- tm_map(docs, tolower)
  docs <- tm_map(docs, removeWords, stopwords("english"))
  docs <- tm_map(docs, stripWhitespace)
  docs <- tm_map(docs, stemDocument) 
  myStopwords <- scan('mystopwords.txt', what='character', comment.char = ';')
  docs <- tm_map(docs, removeWords, myStopwords)
  docs <- tm_map(docs, PlainTextDocument)  
  
  dtm <- DocumentTermMatrix(docs,control=list(weighting=function(x)
    weightTfIdf(x,normalize = FALSE))
  )   
  dtm <- as.matrix(dtm)
  return(dtm)
}

library(RTextTools)
dtm <- rawTextProcess(att$reviews)
cols <- ncol(dtm)
## find the weight of the 1500th word after sorting word weights by decreasing order
v <- sort(colSums(dtm), decreasing=TRUE)
v[1500]
## 170 is got by "v[1500]", this magic number varies based on different data
del_cols <- which(colSums(dtm)<=170)
## remove column of dtm (document term matrix) with weight less than 170
if(length(del_cols)>0){
  dtm <- dtm[,-del_cols]
}
## convert dtm from float to int as topicmodels's LDA requires
dtm[] <- as.integer(dtm)
rows <- nrow(dtm)
## remove rows with entries all equal to 0, otherwise, LDA will fail
del_rows <- which(rowSums(dtm)==0)
if(length(del_rows)>0){
  dtm <- dtm[-del_rows,]
}


###########################################
####  run LDA using package "topicmodels"
###########################################
library(topicmodels)
#Set parameters for Gibbs sampling
burnin <- 0
iter <- 800
thin <- 800
seed <-list(2002,5,63,9999,765)
nstart <- 5
best <- TRUE
#Number of topics
k <- 12

#Run LDA using Gibbs sampling
ldaOut <-LDA(dtm,k, method="Gibbs", control=list(nstart=nstart, seed = seed, best=best, burnin = burnin, iter = iter, thin=thin))

ldaOut.topics <- topics(ldaOut)

#output the first 10 topics terms for each LDA extracted topics
ldaOut.terms <- as.matrix(terms(ldaOut,10))
write.csv(ldaOut.terms,file=paste("LDA",k,"sample_data/TopicsToTerms.csv"))

#deal with those rows with entries all equal to 0
#assign these reviews with topic k+1
att$topics <- k+1
att[-del_rows,"topics"] <- ldaOut.topics

#merge topics column to input dataframe and output new dataframes as csv files
att_dallas <- read.csv("sample_data/ATT_dallas_reviews_lvl2.csv")
att_us <- read.csv("sample_data/ATT_US_reviews.csv")
att_dallas$topics <- att[1:row1,"topics"]
att_us$topics <- att[(row1+1):(row1+row2),"topics"]

write.csv(att_dallas,"sample_data/ATT_dallas_reviews_lvl2_topic.csv",row.names=F)
write.csv(att_us,"sample_data/ATT_US_reviews_topic.csv",row.names=F)
