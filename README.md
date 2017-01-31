## ATT Fall Case Competition Code
This folder includes codes and part of sample data used for Big Data AT&T Fall Case Competition. This project is ranked Top 5 in this competition. 

Goal of customer insights project is to identify top customer concerns, analyze customer sentiment related to ATT and provide recommendation strategies for CRM system. This project consumes documents from various social media sources and applies various natural language processing techniques and models. The programming languages in this project are R and Python.

## Summary:
1. Top customer concern by social media feeds (LDA).
2. Customer tweet sentiment analysis and prediction (SVM , TFIDF).
3. Custom ranking algorithm to measure the overall service quarlity of retailer stores in Dallas area.
4. Provide visualized presentation of such findings in CRM recommendation engin on top of Tableu platform.
![alt text][logo]
[logo]:https://github.com/fairypp/ATT_Fall_Case_Competition_Code/blob/master/overall_rank.png

## Project Structure 

/-------R Code   
| |--------Sample Data  
| |--------ATT_LDA.R  
| |--------Corr.R  
| |--------Preprocess.R  
| |--------Sentiment.R  
| |--------TwitterPublicData.R  
| |--------TwitterStreamData.R  
| |--------mystopwords.txt  
|  
|-----Python Code  
| |--------ReadMeForPython.docx
| |--------fetch_google.py
| |--------fetch_yelp.py
| |--------top 100 populated cities in US.txt

### Code notes : 
1) ATT_LDA.R : extract customer service topics by LDA method.
2) Corr.R : compute the correlation matrix of different demographics factors.
3) Preprocess.R	: normalize all collected review ratings and prepare the training corpus for sentiment prediction.
4) Sentiment.R : predict sentiment for tweets by Max Entropy and SVM.
5) TwitterPublicData.R : fetch Twitter history data by Twitter APIs.
6) TwitterStreamData.R : fetch Twitter real-time streaming data by Twitter APIs.

File “mystopwords.txt” is used for text preprocessing.
7) fetch_google.py : fetch Google reviews by Google Search APIs. 
8) fetc_yelp.py : fetch part of Yelp reviews by Yelp APIs.
9) top 100 populated cities in US.txt: Geographic information for US top 100 populated cities.

### Sample Data Notes:



### Limitations and known issues:
Due to Yelp APIs’ limitation, chrome tools is chosen to called Web Scraper to fetch all Yelp reviews from webpages. For the same reason, all reviews are fetched from Facebook. 
Due to time limitation of competetion, custom implementation for web scraping was not developed. 

Input file paths are hardcoded. This can be easily modified to be command line parameter(s). 

We use R to  
(1) fetch twitter history and real-time streaming data;  
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





