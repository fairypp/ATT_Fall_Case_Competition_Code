##########################################################################
# fetchDallasTweets: function to fetch Twitter history data by Twitter APIs
#                    in Dallas area
# input: query--keyword for query, num--# of tweets to fetch
#        lang--language, geocode--geo-information
# output: fectched tweets
##########################################################################
fetchDallasTweets <- function(query, num, lang, geocode) # return a data frame
{
  # extract tweets by R package "twitteR" and twitter's API
  library(twitteR)
  # Declare Twitter API Credentials
  api_key <- "XXXXXX" # From dev.twitter.com
  api_secret <- "XXXXXX" # From dev.twitter.com
  token <- "XXXXXX" # From dev.twitter.com
  token_secret <- "XXXXXX" # From dev.twitter.com
  
  # Create Twitter Connection
  setup_twitter_oauth(api_key, api_secret, token, token_secret)
  
  # Run Twitter Search and fetch data from twitter. Format is searchTwitter("Search Terms", n=100, lang="en", geocode="lat,lng", also accepts since and until)
  rawTweets <- searchTwitter(query, n=num, lang=lang, geocode=geocode, resultType="recent")
  # Transform tweets list into a data frame
  rawTweets <- twListToDF(rawTweets)
}

#fetch tweets located in Dallas
#set '32.777955,-96.798340' as the center of Dallas, and 30mi as the search radius
rawTweetsKPPos <- fetchDallasTweets(query = "@ATTcares", num = 500, lang="en", geocode='32.777955,-96.798340,30mi')
write.csv(rawTweetsKPPos, file = "ATTCares_twitter.csv")

##########################################################################
# fetchUSTweets: function to fetch Twitter history data by Twitter APIs
#                all across US
# input: query--keyword for query, num--# of tweets to fetch
#        lang--language
# output: fectched tweets
##########################################################################
fetchTweetsUS <- function(query, num, lang) # return a data frame
{
  # extract tweets by related R package and twitter's API
  library(twitteR)
  # Declare Twitter API Credentials
  api_key <- "XXXXXX" # From dev.twitter.com
  api_secret <- "XXXXXX" # From dev.twitter.com
  token <- "XXXXXX" # From dev.twitter.com
  token_secret <- "XXXXXX" # From dev.twitter.com
  
  # Create Twitter Connection
  setup_twitter_oauth(api_key, api_secret, token, token_secret)
  
  # Run Twitter Search and fetch data from twitter. Format is searchTwitter("Search Terms", n=100, lang="en", geocode="lat,lng", also accepts since and until)
  rawTweets <- searchTwitter(query, n=num, lang=lang, resultType="recent")
  # Transform tweets list into a data frame
  rawTweets <- twListToDF(rawTweets)
}
#fetch tweets allover US and save them into a csv file
rawTweetsKPPos <- fetchTweetsUS(query = "@ATTcares", num = 2000, lang="en")
write.csv(rawTweetsKPPos, file = "ATTCares_twitter_US.csv")

#re-read tweets and fetch user information by function lookupUsers
name_data <- read.csv("ATTCares_twitter.csv")
screen_name <- unique(name_data$screenName)
screen_name <- as.vector(screen_name)
users <- lookupUsers(screen_name)
#extract user's location and name from fetch user information
locations <- sapply(users, "[[", "location")
names <- sapply(users, "[[", "name")#screenName
screen_names <- sapply(users, "[[", "screenName")
locations <- data.frame(locations)
names <- data.frame(names)
screen_names <- data.frame(screen_names)
userss <- cbind(names,locations)
userss <- cbind(screen_names,userss)
userss <- userss[,c(1,2,3)]
write.csv(userss, file = "ATTCares_twitter_users.csv", row.names = FALSE)

