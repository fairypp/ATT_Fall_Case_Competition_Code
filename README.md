## ATT Fall Case Competition Code
This folder includes codes and part of sample data used for Big Data AT&T Fall Case Competition. This project is ranked Top 5 in this competition. 

Goal of customer insights project is to identify top customer concerns, analyze customer sentiment related to ATT and provide recommendation strategies for CRM system. This project consumes documents from various social media sources and applies various natural language processing techniques and models. The programming languages in this project are R and Python.

### Summary:
1. Top customer concern by social media feeds (LDA).
2. Customer tweet sentiment analysis and prediction (SVM , TFIDF).
3. Custom ranking algorithm to measure the overall service quarlity of retailer stores in Dallas area.
4. Provide visualized presentation of such findings in CRM recommendation engine on top of Tableu platform.
![alt text][logo]
[logo]:https://github.com/fairypp/ATT_Fall_Case_Competition_Code/blob/master/overall_rank.png

### Project Structure:  

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

### Code Notes : 
1) ATT_LDA.R : extract customer service topics by LDA method.  
2) Corr.R : compute the correlation matrix of different demographics factors.  
3) Preprocess.R	: normalize all collected review ratings and prepare the training corpus for sentiment prediction.  
4) Sentiment.R : predict sentiment for tweets by Max Entropy and SVM.  
5) TwitterPublicData.R : fetch Twitter history data by Twitter APIs.  
6) TwitterStreamData.R : fetch Twitter real-time streaming data by Twitter APIs.  

File “mystopwords.txt” is used for text preprocessing.  
7) fetch_google.py : fetch Google reviews by Google Search APIs.  
8) fetch_yelp.py : fetch part of Yelp reviews by Yelp APIs.  
9) top 100 populated cities in US.txt: Geographic information for US top 100 populated cities used in fetch_google.py.  

### Sample Data Notes:
1)	ATT_dallas_rank_YGF.csv : all overall ranks of AT&T retail stores in Dallas area from 3 main social media platforms (Yelp, Google and Facebook), and other information like zipcode, store address, lat and long.    
2)	ATT_dallas_reviews.csv : sample review data of AT&T retail stores in Dallas area got from Yelp, Google and Facebook.  
3)	ATT_US_reviews.csv : sample review data of AT&T retail stores all over US got from Google reviews.  
4)	Demographic.csv : the demographic information we collected for Dallas area.  
5)	realtime_twitter.csv : some sample Twitter streaming data.  
6)	TMobileHelp_twitter_users.csv : some sample Twitter data related users.  
7)	LDA 15 TopicsToTerms.xlsx : LDA-extract customer service topics.  


### Limitations and Known Issues:
Due to Yelp APIs’ limitation, chrome tools is chosen to called Web Scraper to fetch all Yelp reviews from webpages. For the same reason, all reviews are fetched from Facebook.   
Due to time limitation of competetion, custom implementation for web scraping was not developed.   

Input file paths are hardcoded. This can be easily modified to be command line parameter(s). 

