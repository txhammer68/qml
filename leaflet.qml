import QtQuick 2.8
import QtWebEngine 1.5

Item {
	width: 1056
	height: 800
// test for weather map not working

Item {
	id:itm1
	anchors.top:root.top
	anchors.left:root.left
	width:512
	height:400
	WebEngineView {
		anchors.fill: parent
		url: "http://mapshakers.com/projects/leaflet-pulse-icon/"
	}
}


	Item {
		id:itm2
		anchors.top:itm1.bottom
		anchors.left:root.left
		width:512
		height:400
	WebEngineView {
		anchors.fill: parent
		url: "https://openweathermap.org/weathermap?basemap=map&lang=en&cities=false&layer=radar&lat=29.6915&lon=-95.0474&zoom=9"
		//https://openweathermap.org/weathermap?basemap=map&cities=true&layer=temperature&lat=51.4552&lon=-0.1816&zoom=5
		profile:  WebEngineProfile{
                           httpUserAgent: "Mozilla/5.0 (X11; Linux x86_64; rv:100.0) Gecko/20100101 Firefox/100.0"
                           httpAcceptLanguage : "en-US,en;q=0.5"
                           //AllowPersistentCookies:true // not working
                }
	}
	}
}
