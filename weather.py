#!/usr/bin/env python2

import json, os.path, time
from urllib import urlopen
from math import exp

lat   = os.environ['LOCATION_LAT']
lon   = os.environ['LOCATION_LON']
cache = "~/.weather.json"
days  = 3

degree_fahr= u'\N{DEGREE SIGN}F'


# allow ~/ expansion
cache = os.path.expanduser(cache)

def download_weather():
    url = "http://forecast.weather.gov/MapClick.php?lat=" + lat + "&lon=" + lon + "&FcstType=json"

    response = urlopen(url)
    data = response.read()
    
    fo = open(cache, "wb")
    fo.write(data);
    fo.close()

    return data
    
def degrees_to_cardinal(d):
    #dirs = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE",
    #        "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
    #        
    #ix = int((d + 11.25)/22.5)
    #return dirs[ix % 16]
    
    dirs = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
    
    ix = int((d + 23)/45)
    return dirs[ix % 8]
    
    
def wind_chill(temp, mph):
    c1 = 35.74
    c2 = 0.6215
    c3 = 35.75
    c4 = 0.4275

    if temp <= 50 and mph > 3:
        wc = c1 + (c2 * temp) - (c3 * pow(mph, 0.16)) + (c4 * temp * pow(mph, 0.16))
        return int(round(wc, 0))
    
    else:
        return None

def heat_index(temp, humid):
    c1 = -42.379
    c2 = 2.04901523
    c3 = 10.14333127
    c4 = -0.22475541
    c5 = -6.83783 * pow(10, -3)
    c6 = -5.481717 * pow(10, -2)
    c7 = 1.22874 * pow(10, -3)
    c8 = 8.5282 * pow(10, -4)
    c9 = -1.99 * pow(10, -6)

    if temp >= 80 and humid >= 40:
    
        hi = c1 + (c2 * temp) + \
        (c3 * humid) + \
        (c4 * temp * humid) + \
        (c5 * pow(temp, 2)) + \
        (c6 * pow(humid, 2)) + \
        (c7 * pow(temp, 2) * humid) + \
        (c8 * temp * pow(humid, 2)) + \
        (c9 * pow(temp, 2) * pow(humid, 2))
        
        return int(round(hi, 0))
    
    else:
        return None

def cardinal_to_arrows(d):
    if d == "N":  return u"\u2191"
    if d == "NE": return u"\u2197"
    if d == "E":  return u"\u2192"
    if d == "SE": return u"\u2198"
    if d == "S":  return u"\u2193"
    if d == "SW": return u"\u2199"
    if d == "W":  return u"\u2190"
    if d == "NW": return u"\u2196"


if os.path.exists(cache):
    now   = time.time()
    mtime = os.path.getmtime(cache)
    
    if now - mtime > 60 * 60:
        data = download_weather()
    else:
        data = open(cache, 'r')
        data = data.read()
else:
    data = download_weather()



data = json.loads(data)

# Currently
mph = data["currentobservation"]["Winds"]
direction = int(data["currentobservation"]["Windd"])

temp = int(data["currentobservation"]["Temp"])
humidity = int(data["currentobservation"]["Relh"])


print "Currently"
print "---------"
print "Temp:       " + data["currentobservation"]["Temp"] + degree_fahr
print "Humidity:   " + str(humidity) + "%"

hi = heat_index(temp, humidity)
if hi is not None:
    print "Heat Index: " + str(hi) + degree_fahr
    
print "Weather:    " + data["currentobservation"]["Weather"]

print "Wind:       " + mph + cardinal_to_arrows(degrees_to_cardinal(direction))

wc = wind_chill(temp, mph)
if wc is not None:
    print "Wind Chill: " + str(wc) + degree_fahr

# new line
print

# Future Forcast
temps = data["data"]["temperature"]
temps = [temps[x:x+2] for x in range(0, len(temps), 2)]

count = 0
for i in range(len(data["time"]["startPeriodName"])):

    day = data["time"]["startPeriodName"][i]

    if day.find(" Night") == -1:
        temps[i].sort()
        low  = temps[i][0]
        high = temps[i][1]
    
        
        forcast = data["data"]["weather"][i]
        
        #remove_list = ['Likely', 'Slight', 'Chance', 'Snow/', 'Rain/', 'Areas', 'Mostly', 'Partly']
        #word_list = forcast.split()
        #forcast = ' '.join([x for x in word_list if x not in remove_list])
        #forcast = forcast.replace('then', '->')


        print day
        print ''.rjust(len(day), '-')

        print "Temp:    " + low + degree_fahr + " - " + high + degree_fahr
        print "Forcast: " + forcast
        
        percip = data["data"]["pop"][i]
        if percip is not None:
            print "Percip:  " + percip + "%"

        # new line
        print

    count += 1
    if count > days: 
        break

