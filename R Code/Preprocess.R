#normalize all review ratings from different platforms to unified scale (1~5)
#for google reviews, review rating is 0~3, we scale rating as follows:
# 0-->1; 1-->3; 2-->4; 3-->5
#use normalized review ratings to determine sentiment: 1~2: negative (-1),
#3: neutral (0), 4~5 positive (1)
#those groundtruth sentiments will be used as the training data to predict the sentiment
#of tweets

att_dallas_review <- read.csv("ATT_dallas_reviews_lvl2.csv")
pos <- which(att_dallas_review$rating>=4)
att_dallas_review[pos,'sentiment'] <- 1 
neg <- which(att_dallas_review$rating<=2)
att_dallas_review[neg,'sentiment'] <- -1 
neur <- which(att_dallas_review$rating==3)
att_dallas_review[neur,'sentiment'] <- 0
write.csv(att_dallas_review, "ATT_dallas_reviews_lvl2.csv")

spr_dallas_review <- read.csv("Sprint_dallas_reviews_lvl2.csv")
pos <- which(spr_dallas_review$rating>=4)
spr_dallas_review[pos,'sentiment'] <- 1 
neg <- which(spr_dallas_review$rating<=2)
spr_dallas_review[neg,'sentiment'] <- -1 
neur <- which(spr_dallas_review$rating==3)
spr_dallas_review[neur,'sentiment'] <- 0
write.csv(spr_dallas_review, "Sprint_dallas_reviews_lvl2.csv")

att_dallas_review <- att_dallas_review[0,]
att_dallas_review <- read.csv("Tmobile_dallas_reviews_lvl2.csv")
pos <- which(att_dallas_review$rating>=4)
att_dallas_review[pos,'sentiment'] <- 1 
neg <- which(att_dallas_review$rating<=2)
att_dallas_review[neg,'sentiment'] <- -1 
neur <- which(att_dallas_review$rating==3)
att_dallas_review[neur,'sentiment'] <- 0
write.csv(att_dallas_review, "Tmobile_dallas_reviews_lvl2.csv")

att_dallas_review <- att_dallas_review[0,]
att_dallas_review <- read.csv("Verizon_dallas_reviews_lvl2.csv")
pos <- which(att_dallas_review$rating>=4)
att_dallas_review[pos,'sentiment'] <- 1 
neg <- which(att_dallas_review$rating<=2)
att_dallas_review[neg,'sentiment'] <- -1 
neur <- which(att_dallas_review$rating==3)
att_dallas_review[neur,'sentiment'] <- 0
write.csv(att_dallas_review, "Verizon_dallas_reviews_lvl2.csv")


us_gl_review <- read.csv("ATT_US_reviews.csv")
us_gl_review[which(us_gl_review$rating==3),"rating"] <- 5
us_gl_review[which(us_gl_review$rating==2),"rating"] <- 4
us_gl_review[which(us_gl_review$rating==1),"rating"] <- 3
us_gl_review[which(us_gl_review$rating==0),"rating"] <- 1
us_gl_review$sentiment <- 1
pos <- which(us_gl_review$rating>=4)
us_gl_review[pos,'sentiment'] <- 1 
neg <- which(us_gl_review$rating<=2)
us_gl_review[neg,'sentiment'] <- -1 
neur <- which(us_gl_review$rating==3)
us_gl_review[neur,'sentiment'] <- 0

del <- which(us_gl_review$reviews=="")
if(length(del)>0){
  us_gl_review <- us_gl_review[-del,]
}
write.csv(us_gl_review, "ATT_US_reviews.csv")

us_gl_review <- us_gl_review[0,]
us_gl_review <- read.csv("Sprint_US_reviews.csv")
us_gl_review[which(us_gl_review$rating==3),"rating"] <- 5
us_gl_review[which(us_gl_review$rating==2),"rating"] <- 4
us_gl_review[which(us_gl_review$rating==1),"rating"] <- 3
us_gl_review[which(us_gl_review$rating==0),"rating"] <- 1
us_gl_review$sentiment <- 1
pos <- which(us_gl_review$rating>=4)
us_gl_review[pos,'sentiment'] <- 1 
neg <- which(us_gl_review$rating<=2)
us_gl_review[neg,'sentiment'] <- -1 
neur <- which(us_gl_review$rating==3)
us_gl_review[neur,'sentiment'] <- 0
del <- which(us_gl_review$reviews=="")
if(length(del)>0){
  us_gl_review <- us_gl_review[-del,]
}
write.csv(us_gl_review, "Sprint_US_reviews.csv")

us_gl_review <- us_gl_review[0,]
us_gl_review <- read.csv("Tmobile_US_reviews.csv")
us_gl_review[which(us_gl_review$rating==3),"rating"] <- 5
us_gl_review[which(us_gl_review$rating==2),"rating"] <- 4
us_gl_review[which(us_gl_review$rating==1),"rating"] <- 3
us_gl_review[which(us_gl_review$rating==0),"rating"] <- 1
us_gl_review$sentiment <- 1
pos <- which(us_gl_review$rating>=4)
us_gl_review[pos,'sentiment'] <- 1 
neg <- which(us_gl_review$rating<=2)
us_gl_review[neg,'sentiment'] <- -1 
neur <- which(us_gl_review$rating==3)
us_gl_review[neur,'sentiment'] <- 0
del <- which(us_gl_review$reviews=="")
if(length(del)>0){
  us_gl_review <- us_gl_review[-del,]
}
write.csv(us_gl_review, "Tmobile_US_reviews.csv")

us_gl_review <- us_gl_review[0,]
us_gl_review <- read.csv("Verizon_US_reviews.csv")
us_gl_review[which(us_gl_review$rating==3),"rating"] <- 5
us_gl_review[which(us_gl_review$rating==2),"rating"] <- 4
us_gl_review[which(us_gl_review$rating==1),"rating"] <- 3
us_gl_review[which(us_gl_review$rating==0),"rating"] <- 1
us_gl_review$sentiment <- 1
pos <- which(us_gl_review$rating>=4)
us_gl_review[pos,'sentiment'] <- 1 
neg <- which(us_gl_review$rating<=2)
us_gl_review[neg,'sentiment'] <- -1 
neur <- which(us_gl_review$rating==3)
us_gl_review[neur,'sentiment'] <- 0
del <- which(us_gl_review$reviews=="")
if(length(del)>0){
  us_gl_review <- us_gl_review[-del,]
}
write.csv(us_gl_review, "Verizon_US_reviews.csv")




