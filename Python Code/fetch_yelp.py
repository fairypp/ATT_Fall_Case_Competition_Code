import yelp
import csv
import json

YELP_API_KEY = {
    'consumer_key': 'XXXXXX',
    'consumer_secret': 'XXXXXX',
    'access_token_key': 'XXXXXX',
    'access_token_secret': 'XXXXXX',
}

def get_yelp_instance(yelp_key):
    yelp_instance = yelp.Api(**yelp_key)
    return yelp_instance


yelp_instance = get_yelp_instance(YELP_API_KEY)
limit = 10
page = 1
offset = page * limit
para={
	'term': 'at and t',
	'limit': 20,
	'offset': 20,
	'sort': 0,
	'radius_filter': 40000, 
	'location': 'Dallas, TX'
}

yelp_results=yelp_instance.Search(**para)
data=[]

f = csv.writer(open("test.csv", "wb+"))

# Write CSV Header, If you dont need that, remove this line
f.writerow(["id", "name", "categories", "is_closed", "city", "display_address","neighborhoods","postal_code","latitude","longitude", "rating"])


for business in yelp_results.businesses:
    f.writerow([
				business.id,
                business.name,
                json.dumps(business.categories),
                business.is_closed,
                business.location.city,
				json.dumps(business.location.display_address),
				json.dumps(business.location.neighborhoods),
				business.location.postal_code,
				business.location.coordinate['latitude'],
				business.location.coordinate['longitude'],
				business.rating
			   ])
			   

for business in yelp_results.businesses:
	data.append(business)
print data