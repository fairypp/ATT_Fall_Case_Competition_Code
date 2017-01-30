## ATT Fall Case Competition Code
This folder includes codes and part of sample data used for Big Data AT&T Fall Case Competition.
We win Top5.
## Summary:
1. Led AT&T store performance analysis to extract customer service insights by establishing analysis strategies.  
2. Generated 15 customer concerns by clustering 50,000+ reviews from 4 social media platforms with LDA.  
3. Predicted customer tweet sentiments by employing SVM and document term matrix (TF-IDF is the weight factor).  
4. Designed a service ranking algorithm and visualized findings by utilizing 10 Tableau interactive stories to provide Customer Relationship Management recommendations.  

Our codes are mainly written by R and Python.

We use R to (1) fetch twitter history and real-time streaming data;  
(2) preprocess fetched raw data from 4 main social media platforms (including Yelp, Google, Facebook and Twitter);   
(3) do Latent Dirichlet Allocation (LDA) for extracted document term matrix;   
(4) Word count and SVM based sentiment prediction.  

There are 6 R code files included under the folder “R Code”:  
1)	ATT_LDA.R is used to extract customer service topics by LDA method.  
2)	Corr.R is used to compute the correlation matrix of different demographics factors.  
3)	Preprocess.R is used to normalized all collected review ratings and prepare the training corpus for sentiment prediction.  
4)	Sentiment.R is used to predict sentiment for tweets by Max Entropy and SVM.  
5)	TwitterPublicData.R is used to fetch Twitter history data by Twitter APIs.  
6)	TwitterStreamData.R is used to fetch Twitter real-time streaming data by Twitter APIs.  

File “mystopwords.txt” is used for text preprocessing.

There are 7 sample data files included under the folder “Sample_Data”:  
1)	ATT_dallas_rank_YGF.csv includes all overall ranks of AT&T retail stores in Dallas area from 3 main social media platforms (Yelp, Google and Facebook), and other information like zipcode, store address, lat and long.    
2)	ATT_dallas_reviews.csv includes sample review data of AT&T retail stores in Dallas area got from Yelp, Google and Facebook.  
3)	ATT_US_reviews.csv includes sample review data of AT&T retail stores all over US got from Google reviews.  
4)	Demographic.csv includes the demographic information we collected for Dallas area.  
5)	realtime_twitter.csv has some sample Twitter streaming data.  
6)	TMobileHelp_twitter_users.csv has some sample Twitter data related users.  
7)	LDA 15 TopicsToTerms.xlsx includes the LDA-extract customer service topics.  

We use Python to (1) fetch Google reviews by Google Search APIs; (2) fetch part of Yelp reviews by Yelp APIs.  

Due to Yelp APIs’ limitation, we finally use a chrome tools called Web Scraper to fetch all Yelp reviews from webpages. We also physically fetch all reviews from Facebook due to its API limitation. For this part, you can use any other web scraping tools or codes to finish the data collection job. We just don't have enough time to write or find a more powerful one to collect data.

The input file paths are directly written in the codes. If you want to test those codes, you need to change input file paths from codes by correct paths.


