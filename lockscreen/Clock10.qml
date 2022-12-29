// custom clock for plasma lockscreen ala windows 10 style
// shows time,weather,events, in lower left corner
// /usr/lib/x86_64-linux-gnu/libexec/kscreenlocker_greet --testing --theme $HOME/.local/share/plasma/look-and-feel/MyBreeze

import QtQuick 2.9
import QtQuick.Layouts 1.5
import QtQuick.Controls 1.1
import org.kde.plasma.core 2.1

Item {
    id:clock10
    property string font_color:"whitesmoke"
    property string font_style1:"Michroma"
    property string font_style2:"SF Pro Display"
    property var url2:"/tmp/weather.json"
    property double startTime: 0
    property int secondsElapsed: 0
    // property var url2:"https://api.darksky.net/forecast/522dc5d7c682775779e3e83d68fd0161/29.69,-95.04?exclude=minutely,flags"

    //property var weather:{}
    property var weatherIcon:""
    property var warnings:""
    property var conditions:""
    property var alertText:""
    property int today:Qt.formatDate(timeSource.data["Local"]["DateTime"],"MMdd")
    property string nth:getOrdinal(Qt.formatDate(timeSource.data["Local"]["DateTime"],"d"))

    property int h:info.height

    Events {id:dates}

    function getWeather(url){  // get weather info
        var xhr = new XMLHttpRequest();
        var weather={};
        xhr.open("GET", url); // set Method and url
        xhr.responseType = 'json';
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.onreadystatechange = function () {
            if(xhr.readyState == 4){ // if request_status == DONE
                if (xhr.status == 200) {
                    weather = JSON.parse(xhr.responseText);
                    processWeatherData(weather);
                    weather=null;
                    xhr.responseText=null;
                    xhr=null;
                }
            }
            return
        }
        xhr.send(); // begin the request
        return
    }

function getOrdinal(n) {            // assigns superfix to date
    var s=["th","st","nd","rd"],
    v=n%100;
    return (s[(v-20)%10]||s[v]||s[0]);
}

function processWeatherData(weather) {
    weatherIcon="../icons/"+weather.currently.icon+".png"
    warnings=weather.hasOwnProperty("alerts") ? true:false // check if alert exists
    conditions=Math.round(weather.currently.temperature)+"° "+weather.currently.summary+"\n"+weather.hourly.summary+"\n"+Math.round(weather.daily.data[0].temperatureLow)+"° | "+Math.round(weather.daily.data[0].temperatureHigh)+"°"
    alertText=warnings ? Math.round(weather.currently.temperature)+"°  "+"  ⚠️  "+weather.alerts[0].title+"\n"+weather.hourly.summary+"\n "+Math.round(weather.daily.data[0].temperatureLow)+"° | "+Math.round(weather.daily.data[0].temperatureHigh)+"°" : "None"
   weather=null;
   return null;
}

ColumnLayout{
    id:info
    spacing:2
    anchors.top:clock10.top
    anchors.topMargin:-5

    Text {
        id:time
        bottomPadding:1
        leftPadding:-10
        text: Qt.formatTime(timeSource.data["Local"]["DateTime"],"h:mm ap").replace("am", "").replace("pm", "")
        color: font_color
        font.pointSize: 56
        font.family: font_style1
        antialiasing:true
    }
    Text {
        id:date
        topPadding:-10
        bottomPadding:2
        textFormat: Text.RichText
        text: Qt.formatDate(timeSource.data["Local"]["DateTime"],"dddd, MMMM  d") +"<sup>"+nth+"</sup>"
        color:font_color
        font.pointSize: 20
        font.family: font_style2
        antialiasing:true
    }

    Text {
        id:ev
        text:dates.events[today]
        //anchors.right:date.right
        //anchors.rightMargin:20
        //Layout.fillWidth:false
        color:font_color
        antialiasing : true
        font.pointSize: 16
        font.family: font_style2
        visible: dates.events[today] === undefined ? false : true
        height: ev.visible ? date.height*1.5 : 0  // hide events if blank
    }

    Row {
        spacing:10
        topPadding:10

        Image {
            id: wIcon
            cache: false
            source:weatherIcon
            smooth: true
            sourceSize.width: 64
            sourceSize.height: 64
        }

        Text {
            id:currentConditions
            bottomPadding:5
            leftPadding:20
            lineHeight :1.25
            text:warnings ? alertText : conditions
            font.family: font_style2
            font.pointSize: 16
            color:font_color
            antialiasing : true
        }
    }
}

function timeChanged() {
        if(startTime==0)
        {
            startTime = new Date().getTime(); //returns the number of milliseconds since the epoch (1970-01-01T00:00:00Z);
        }
        var currentTime = new Date().getTime();
        secondsElapsed = (currentTime-startTime)/1000;
        return secondsElapsed
    }

property var timerTemp: Timer {                  // timer to trigger update for weather temperature
    id: timerTemp
    interval: 20 * 60 * 1000 // every 20 minutes
    running: true
    repeat:  true
    triggeredOnStart:true
    onTriggered: {
        getWeather(url2);
        startTime=0;      // restart time for suspend check
    }
}

property var suspendTimer: Timer{                  // timer to trigger update after wake from suspend mode
    id: suspend

    interval: 20*1000 ///delay 20 secs for suspend to resume
    running: false
    repeat:  false
    onTriggered: {
        getWeather(url2);
        startTime=0;
        timerTemp.restart(); // resets starTime, timerTemp interval
        }
}

DataSource {
    id: timeSource
    engine: "time"
    connectedSources: ["Local"]
    interval: 900
    onNewData:  (timeChanged()>1210) ?  suspendTimer.start():suspendTimer.stop()
    }
    // onLocationChanged: timer.restart()
}
