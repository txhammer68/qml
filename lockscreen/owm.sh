#!/bin/bash
url="https://api.openweathermap.org/data/2.5/onecall?"
url1="&units=imperial&appid=5819a34c58f8f07bc282820ca08948f1"
loc="lat=29.65&lon=-95.04"
url2=${url}${loc}${url1}
# echo $url2
curl -s --retry-all-errors --retry 3 --retry-delay 5 -X GET $url2 -H  "accept: application/json" -o /tmp/owm.json
exit
