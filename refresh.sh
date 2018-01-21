#!/bin/bash

# This script should be called periodically via cron. It is responsible for caching a local copy of
# the raw tracker data.  
# Future improvement ideas: 
#  * Monitor nginx access log; only execute the cURL request if the webpage was accessed within the
#    last few minutes
#  * Use timestamp diffs to avoid loading the entire pokemon/gym list with each request.  This is how
#    the main tracker works.  Must track request/response tokens and, likely, match the request rate 
#    of the main tracker.  
ROOT=/opt/pogo-maps/out/
FILE1=${ROOT}/current
FILE2=${ROOT}/new

# This command simulates the initial, uncached request for all pokemon and gyms within the given
# geofence, in JSON format.  Adjustments to this request and the paths in ./html/watched.php may 
# be required when interfacing with a different tracker.  
# You can modify the xxLat and xxLng values to limit the scan to a specific area.  This will speed up
# response times and decrease the load on the main tracker's servers.
curl "https://va-rv.pogoalerts.net/raw_data" -X POST -d "pokemon=true&pokestops=false&gyms=true&scanned=false&spawnpoints=false&swLat=37.14854841461745&swLng=-80.30267741484784&neLat=37.407798965654194&neLng=-79.64349772734784&reids=&eids=" -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36" -H "Pragma: no-cache" -H "Cache-Control: no-cache" | egrep -v "^<" > ${FILE2}

# The file receiving cURL's output is locked while the command is running.  Since it is often 10-12MB in size,
# downloading can take a few seconds. Saving to a temporary file and moving it minimizes the risk of 
# concurrency issues.  
mv ${FILE2} ${FILE1}
