import googleplaces
import csv
import json
import decimal
import datetime
import sys;
import time

reload(sys);
sys.setdefaultencoding("utf8")

GOOGLE_API_KEY = "XXXXXX"

def get_google_instance(google_key):
    google_instance = googleplaces.GooglePlaces(google_key)
    return google_instance

google_instance = get_google_instance(GOOGLE_API_KEY)


data = []
f = csv.writer(open("ATT_US_reviews.csv", "wb+"))
# Write CSV Header, If you dont need that, remove this line
f.writerow(["id", "name", "zipcode", "address", "reviews", "time", "rating"])
class DecimalEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, decimal.Decimal):
            return str(obj)
        return json.JSONEncoder.default(self, obj)
		

#use top 3 populated cities in US as an exmaple
cities = []
#New York
cities.append({
        'lat': 40.7127837,
        'lng': -74.0059413
})
#Los Angeles
cities.append({
		'lat': 34.0522342,
		'lng': -118.2436849
})
#Chicago
cities.append({
		'lat': 41.8781136,
		'lng': -87.6297982
})


#search att store information by Google APIs
for city in cities:
	places = google_instance.text_search(
		query='ATT',
		language='en',
		lat_lng=city,
		radius=50000
	)


#traverse fetched att stores and output necessary factors
	company = {}
	id_count = 0
	for place in places.places:
		place.get_details()
		details=place.details
		if "reviews" not in details:
			print "do nothing"
		else:
			name = details["name"]
			address = details["formatted_address"]
			add_list = address.split(",")
			zipcode_list = add_list[len(add_list)-2]
			zipcode_arr = zipcode_list.split()
			if len(zipcode_arr)>=2:
				zipcode=zipcode_arr[1]
			else:
				zipcode='00000'
			if details["reviews"] == []:
				print 'No Data!'
			else:
				for rows in details["reviews"]:
					print rows["aspects"][0]["rating"]
					timevalue = datetime.datetime.fromtimestamp(rows["time"])
					f.writerow([
						id_count,
						name,
						zipcode,
						address,
						rows["text"],
						timevalue,
						rows["aspects"][0]["rating"]
					   ])
					id_count = id_count + 1

	time.sleep(3)