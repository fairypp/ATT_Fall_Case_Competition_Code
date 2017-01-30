# We use the package "streamR" which is designed to connect to the Twitter Streaming API.
# Packages are loaded into R with the command library() 
library(streamR)


#All twitter fetching begins from the following line:
#"my_oauth.Rdata" stored my oauth information for connection twitter APIs
load("my_oauth.Rdata")

file = "tweets.json"
follow = NULL
#the location info is a bounding box with two diagnal pointa
#for dallas southwest and northeast
#lat 32.65881247, long: -97.04555357, 33.19043248, -96.51763916
#loc (long, lat,long,lat)
loc = c(-97.04555357, 32.65881247, -96.51763916, 33.19043248)
lang = NULL
minutes = 5
time = 60*minutes
tweets = NULL
filterStream(file.name = file, 
             track = "attcares",
             follow = NULL, 
             locations = NULL, 
             language = "en",
             timeout = time, 
             tweets = tweets, 
             oauth = my_oauth,
             verbose = TRUE)

tweets.df <- parseTweets(file)
library(stringr)
tweets.df$hashtags <- str_extract(tweets.df$text, "@ATTCares")
index <- which(tweets.df$hashtags=='@ATTCares')
tweets.df <- tweets.df[index,]
write.csv(tweets.df, file = "realtime_twitter.csv")
