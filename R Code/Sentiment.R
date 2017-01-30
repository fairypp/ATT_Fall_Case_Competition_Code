

#combine all collected review data as trainning set
att_dallas_df <- read.csv("ATT_dallas_reviews_lvl2.csv")
spr_dallas_df <- read.csv("Sprint_dallas_reviews_lvl2.csv")
tmo_dallas_df <- read.csv("Tmobile_dallas_reviews_lvl2.csv")
ver_dallas_df <- read.csv("Verizon_dallas_reviews_lvl2.csv")
att_us_df <- read.csv("ATT_US_reviews.csv")
spr_us_df <- read.csv("Sprint_US_reviews.csv")
tmo_us_df <- read.csv("Tmobile_US_reviews.csv")
ver_us_df <- read.csv("Verizon_US_reviews.csv")
att_dallas_df <- att_dallas_df[,c("reviews","sentiment")]
spr_dallas_df <- spr_dallas_df[,c("reviews","sentiment")]
tmo_dallas_df <- tmo_dallas_df[,c("reviews","sentiment")]
ver_dallas_df <- ver_dallas_df[,c("reviews","sentiment")]

att_us_df <- att_us_df[,c("reviews","sentiment")]
spr_us_df <- spr_us_df[,c("reviews","sentiment")]
tmo_us_df <- tmo_us_df[,c("reviews","sentiment")]
ver_us_df <- ver_us_df[,c("reviews","sentiment")]

#use row bind to stack all reviews and sentiments from different telecom-companies together
review_all <- rbind(att_dallas_df,spr_dallas_df)
review_all <- rbind(review_all,tmo_dallas_df)
review_all <- rbind(review_all,ver_dallas_df)
review_all <- rbind(review_all,att_us_df)
review_all <- rbind(review_all,spr_us_df)
review_all <- rbind(review_all,tmo_us_df)
review_all <- rbind(review_all,ver_us_df)

#remove those null reviews
del <- which((review_all$reviews)=="")
if(length(del)>0){
  final_review <- final_review[-del,]
  final_review <- data.frame(final_review)
}

att_tw_df <- read.csv("ATTCares_twitter.csv")
dtv_tw_df <- read.csv("DIRECTVService_twitter.csv")
tmo_tw_df <- read.csv("TMobileHelp_twitter.csv")
vs_tw_df <- read.csv("VerizonSupport_twitter.csv")
vzw_tw_df <- read.csv("VZWSupport_twitter.csv")
spr_tw_df <- read.csv("sprintcare_twitter.csv")

att_tw_df <- data.frame(att_tw_df[,c("text")])
dtv_tw_df <- data.frame(dtv_tw_df[,"text"])
tmo_tw_df <- data.frame(tmo_tw_df[,"text"])
vs_tw_df <- data.frame(vs_tw_df[,"text"])
vzw_tw_df <- data.frame(vzw_tw_df[,"text"])
spr_tw_df <- data.frame(spr_tw_df[,"text"])
att_rows <- nrow(att_tw_df)
dtv_rows <- nrow(dtv_tw_df)
tmo_rows <- nrow(tmo_tw_df)
vs_rows <- nrow(vs_tw_df)
vzw_rows <- nrow(vzw_tw_df)
spr_rows <- nrow(spr_tw_df)

names(att_tw_df)[1] <- "text"
names(dtv_tw_df)[1] <- "text"
names(tmo_tw_df)[1] <- "text"
names(vs_tw_df)[1] <- "text"
names(vzw_tw_df)[1] <- "text"
names(spr_tw_df)[1] <- "text"

tw_all <- rbind(att_tw_df,dtv_tw_df)
tw_all <- rbind(tw_all,tmo_tw_df)
tw_all <- rbind(tw_all,vs_tw_df)
tw_all <- rbind(tw_all,vzw_tw_df)
tw_all <- rbind(tw_all,spr_tw_df)

text_r <- data.frame(review_all$reviews)
tw_r <- data.frame(tw_all$text)
train_rows <- nrow(text_r)
predict_rows <- nrow(tw_r)
names(text_r)[1] <- "reviews"
names(tw_r)[1] <- "reviews"
train_text <- rbind(text_r, tw_r)
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
##################################################
# The following comments part can be used for bigram term matrix extraction
  ##################################################
#  BigramTokenizer <-
#    function(x)
#      unlist(lapply(ngrams(words(x), 2), paste, collapse = " "), use.names = FALSE)
  
#  dtm <- DocumentTermMatrix(docs, control = list(tokenize = BigramTokenizer,
#                                                 weighting=function(x)weightTfIdf(x,normalize = FALSE)
#  ))    
  
  dtm <- as.matrix(dtm)
  return(dtm)
  
}

library(RTextTools)
mat <- rawTextProcess(train_text$reviews)
cols <- ncol(mat)
v <- sort(colSums(mat), decreasing=TRUE)
## find the weight of the 1000th word after sorting word weights by decreasing order
head(v,1000)
## 113.9 is got by "v[1000]", this magic number varies based on different data
del_cols <- which(colSums(mat)<=113.9)
if(length(del_cols)>0){
  mat <- mat[,-del_cols]
}

#use 2 models to train our reviews corpus: max entropy and SVM
container = create_container(mat, (review_all[,2]),
                             trainSize=1:train_rows,virgin=FALSE)
models = train_models(container, algorithms=c("MAXENT" , "SVM")) #, "RF"

#this is just used to get the validate accuracy
test_con <- create_container(mat,review_all[,2],testSize = 10000:train_rows,virgin = FALSE)
results = classify_models(test_con, models)
table(review_all[10000:train_rows, 2], results[,"MAXENTROPY_LABEL"])
table(review_all[10000:train_rows, 2], results[,"SVM_LABEL"])
# recall accuracy
recall_accuracy((as.factor(review_all[10000:33229, 2])), results[,"MAXENTROPY_LABEL"])
recall_accuracy((as.factor(review_all[10000:33229, 2])), results[,"SVM_LABEL"])

#set the prediction container, and predict sentiments for tweets
tw_container <- create_container(mat,labels=rep(0,predict_rows),testSize = (train_rows+1):(train_rows+predict_rows),virgin = FALSE)
results = classify_models(tw_container, models)
#organize the predicted results
att_tw_df <- read.csv("ATTCares_twitter.csv")
dtv_tw_df <- read.csv("DIRECTVService_twitter.csv")
tmo_tw_df <- read.csv("TMobileHelp_twitter.csv")
vs_tw_df <- read.csv("VerizonSupport_twitter.csv")
vzw_tw_df <- read.csv("VZWSupport_twitter.csv")
spr_tw_df <- read.csv("sprintcare_twitter.csv")

att_tw_df$sentiment <- results[1:att_rows,"MAXENTROPY_LABEL"]
att_tw_df$sentiment_svm <- results[1:att_rows,"SVM_LABEL"]
write.csv(att_tw_df,"ATTCares_twitter.csv")

dtv_tw_df$sentiment <- results[(att_rows+1):(att_rows+dtv_rows),"MAXENTROPY_LABEL"]
dtv_tw_df$sentiment_svm <- results[(att_rows+1):(att_rows+dtv_rows),"SVM_LABEL"]
write.csv(dtv_tw_df,"DIRECTVService_twitter.csv")

stacked_rows <- att_rows+dtv_rows
tmo_tw_df$sentiment <- results[(stacked_rows+1):(stacked_rows+tmo_rows),"MAXENTROPY_LABEL"]
tmo_tw_df$sentiment_svm <- results[(stacked_rows+1):(stacked_rows+tmo_rows),"SVM_LABEL"]
write.csv(tmo_tw_df,"TMobileHelp_twitter.csv")

stacked_rows <- stacked_rows+tmo_rows
vs_tw_df$sentiment <- results[(stacked_rows+1):(stacked_rows+vs_rows),"MAXENTROPY_LABEL"]
vs_tw_df$sentiment_svm <- results[(stacked_rows+1):(stacked_rows+vs_rows),"SVM_LABEL"]
write.csv(vs_tw_df,"VerizonSupport_twitter.csv")

stacked_rows <- stacked_rows+vs_rows
vzw_tw_df$sentiment <- results[(stacked_rows+1):(stacked_rows+vzw_rows),"MAXENTROPY_LABEL"]
vzw_tw_df$sentiment_svm <- results[(stacked_rows+1):(stacked_rows+vzw_rows),"SVM_LABEL"]
write.csv(vzw_tw_df,"VZWSupport_twitter.csv")

stacked_rows <- stacked_rows+vzw_rows
spr_tw_df$sentiment <- results[(stacked_rows+1):(stacked_rows+spr_rows),"MAXENTROPY_LABEL"]
spr_tw_df$sentiment_svm <- results[(stacked_rows+1):(stacked_rows+spr_rows),"SVM_LABEL"]
write.csv(spr_tw_df,"sprintcare_twitter.csv")



