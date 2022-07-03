import QtQuick 2.9
import org.kde.plasma.core 2.1
import QtQuick.Controls 2.15
import QtWebEngine 1.8
// test for open weather radar map
// help get rid of cookie message
// tried these seetings with no progress
// persistentCookiesPolicy :NoPersistentCookies // ForcePersistentCookies
// base url to test in browser
// https://openweathermap.org/weathermap?basemap=map&lang=en&cities=false&layer=radar&&zoom=6

Item {
    id:main
    width:600
    height:600
    property var geoLocation:"lat="+geoCode.data["location"]["latitude"]+"&lon="+geoCode.data["location"]["longitude"]
    Item {
        id:radarMap
        width: main.width
        height: 370
        anchors.top:main.top
        anchors.left:main.left
        anchors.topMargin:20
        anchors.leftMargin:20
        clip:true
        WebEngineView {
            anchors.fill: radarMap
            anchors.topMargin:-65 // remove web page header menu

            url:"https://openweathermap.org/weathermap?basemap=map&lang=en&cities=false&layer=radar&"+geoLocation+"&zoom=6"
            profile:  WebEngineProfile{
                //httpUserAgent: "Mozilla/5.0 (X11; Linux x86_64; rv:101.0) Gecko/20100101 Firefox/101.0"
               // httpUserAgent:"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36"
               // httpAcceptLanguage : "en-US,en;q=0.5"
                persistentCookiesPolicy : NoPersistentCookies// ForcePersistentCookies
                //NoPersistentCookies //
            }

            ///onPresentNotification :
            onFeaturePermissionRequested: {
                grantFeaturePermission(securityOrigin, feature, true); // allows map leaflet
                //grantFeaturePermission(securityOrigin, cookie, true); // not working, not sure??
            }
             //CookieManager.setAcceptFileSchemeCookies:false;
            // CookieManager.getInstance().setAcceptThirdPartyCookies(webView, true);


        }
    }

    DataSource {
        id: geoCode
        engine: "geolocation"
        connectedSources: ["location"]
        interval: 1000
        onNewData: {   // get weather after geocode update
            //t1.start
            //getWeather(url1)
            //cloudDescription()
        }
    }
}
