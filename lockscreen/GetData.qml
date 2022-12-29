import QtQuick 2.9
import org.kde.plasma.core 2.1

Item {
    id:getInfo

    property var url2:"/tmp/weather.json"
    property var url3:"/tmp/gmail.txt"
    property var symbols:"symbols=^DJI,^IXIC,^GSPC,CL=F,GC=F,^TNX"
    property var url1:"https://query1.finance.yahoo.com/v8/finance/spark?"+symbols+"&range=1d&interval=15m&indicators=close&includeTimestamps=false&includePrePost=false&corsDomain=finance.yahoo.com&.tsrc=finance&format=json"
    property var finClose:[]
    property var finPrevClose:[]
    property var finSymbols:["^DJI","^IXIC","^GSPC","CL=F","GC=F","^TNX"] //6
    //property var curDate:Qt.formatDate(new Date(),"ddd")
    property var curDate:Qt.formatDate(timeSource.data["Local"]["DateTime"],"ddd")
    property var curTime:Qt.formatDate(timeSource.data["Local"]["DateTime"],"hh:mm")
    //property var curTime: Qt.formatTime(new Date(),"hh:mm")
    property var days:["Mon","Tue","Wed","Thu","Fri"]
    property var mstartTime:'08:35'
    property var mendTime:'15:30'

    //property var weather:{}
    property var gmail:0
    property double startTime: 0
    property int secondsElapsed: 0
    property var forecastDays:[]
    property var forecastIcons:[]
    property var forecastRains:[]
    property var forecastTemps:[]
    property var weatherIcon:""
    property var weatherWarnings:""
    property var weatherConditions:""
    property var weatherAlertText:""

    //property var url4:"http://site.api.espn.com/apis/site/v2/sports/baseball/mlb/scoreboard"
    property var url4:"https://site.api.espn.com/apis/site/v2/sports/basketball/nba/scoreboard"
    property var key:0
    //property var favTeam:"Houston Astros"
    property var favTeam:"Houston Rockets"

    property var gameStatusState:""
    property var gameStatusDetail:""
    property var gameStatusDescription:""
    property var gamePeriod:""
    property var gameDate:""
    property var gameHeadline:""
    property var gameboxScoresURL:""
    property var homeTeamName:""
    property var homeTeamAbrev:""
    property var homeTeamLogo:""
    property var homeTeamScore:""
    property var homeTeamRecord:""
    property var awayTeamName:""
    property var awayTeamAbrev:""
    property var awayTeamLogo:""
    property var awayTeamScore:""
    property var awayTeamRecord:""


    function processWeatherData(weather) {
        var d1=[];
        var i1=[];
        var r1=[];
        var t1=[];
        // current conditions data
        weatherIcon="../icons/"+weather.currently.icon+".png";
        weatherWarnings=weather.hasOwnProperty("alerts") ? true:false // check if alert exists
        weatherConditions=Math.round(weather.currently.temperature)+"° "+weather.currently.summary;
        weatherAlertText=weatherWarnings ? Math.round(weather.currently.temperature)+"°  "+"  ⚠️  "+weather.alerts[0].title+"\n"+weather.hourly.summary : "None";

         for (var index = 0; index < Object.keys(weather.daily.data).length; index++) {
            //forecast data
            d1[index]=Qt.formatDate(new Date(weather.daily.data[index].time*1000)," ddd ");
            i1[index]="../icons/"+weather.daily.data[index].icon+".png";
            r1[index]=Math.round(weather.daily.data[index].precipProbability*100/10)*10+"% ";
            t1[index]=Math.round(weather.daily.data[index].temperatureLow)+"° | "+Math.round(weather.daily.data[index].temperatureHigh)+"°";
         }
         forecastDays=d1;
         forecastIcons=i1;
         forecastRains=r1;
         forecastTemps=t1;
         d1=null;
         i1=null;
         r1=null;
         t1=null;
         weather=null;
         // json data is large, get rid of hourly data, try to improve performance, prob overkill...
         return null;
    }

    function processGameData (scores) {
        if (Object.keys(scores.events).length > 0 ) { // check if any data exists
            for (var i = 0; i < Object.keys(scores.events).length; i++) {
                if (scores.events[key].competitions[0].competitors[0].team.displayName===favTeam)  {
                    key=i
                    break;
                }
                else if (scores.events[key].competitions[0].competitors[1].team.displayName===favTeam)  {
                    key=i
                    break;
                }
            key=0 // else no fav team game, pick first available game.
        }
        gameStatusState=scores.events[key].competitions[0].status.type.state;
        gameStatusDetail=scores.events[key].competitions[0].status.type.detail;
        gameStatusDescription=scores.events[key].competitions[0].status.type.description;
        gamePeriod=scores.events[key].competitions[0].status.period;
        gameDate=scores.events[key].competitions[0].date;
        gameHeadline=scores.events[key].competitions[0].hasOwnProperty("headlines") ? scores.events[key].competitions[0].headlines[0].shortLinkText : ""
        gameboxScoresURL=scores.events[key].links[0].href;
        homeTeamName=scores.events[key].competitions[0].competitors[0].team.displayName;
        homeTeamAbrev=scores.events[key].competitions[0].competitors[0].team.abbreviation;
        homeTeamLogo=scores.events[key].competitions[0].competitors[0].team.logo;
        homeTeamScore=scores.events[key].competitions[0].competitors[0].score;
        homeTeamRecord=scores.events[key].competitions[0].competitors[0].records[0].summary;
        awayTeamName=scores.events[key].competitions[0].competitors[1].team.displayName;
        awayTeamAbrev=scores.events[key].competitions[0].competitors[1].team.abbreviation;
        awayTeamLogo=scores.events[key].competitions[0].competitors[1].team.logo;
        awayTeamScore=scores.events[key].competitions[0].competitors[1].score;
        awayTeamRecord=scores.events[key].competitions[0].competitors[1].records[0].summary;
        }
        scores=null;
        // json scoreboard is large, trim down to home team data only, improve performance, prob overkill, wth...
        return null;
    }

     function processMarketData (mkt) {
        var x1=[];
        var y1=[];
        x1[0]=mkt[finSymbols[0]].close.slice(-1)[0]!=null ? mkt[finSymbols[0]].close.slice(-1)[0].toFixed(2):mkt[finSymbols[0]].close.slice(-2)[0].toFixed(2);
        x1[1]=mkt[finSymbols[1]].close.slice(-1)[0]!=null ? mkt[finSymbols[1]].close.slice(-1)[0].toFixed(2):mkt[finSymbols[1]].close.slice(-2)[0].toFixed(2);
        x1[2]=mkt[finSymbols[2]].close.slice(-1)[0]!=null ? mkt[finSymbols[2]].close.slice(-1)[0].toFixed(2):mkt[finSymbols[2]].close.slice(-2)[0].toFixed(2);
        x1[3]=mkt[finSymbols[3]].close!=null ? mkt[finSymbols[3]].close.slice(-1)[0].toFixed(2) !=null ? mkt[finSymbols[3]].close.slice(-1)[0].toFixed(2): mkt[finSymbols[3]].close.slice(-1)[0].toFixed(2) : mkt[finSymbols[3]].previousClose.toFixed(2);
        x1[4]=mkt[finSymbols[4]].close!=null ? mkt[finSymbols[4]].close.slice(-1)[0].toFixed(2) !=null ? mkt[finSymbols[4]].close.slice(-1)[0].toFixed(2): mkt[finSymbols[4]].close.slice(-1)[0].toFixed(2) : mkt[finSymbols[4]].previousClose.toFixed(2);
       x1[5]=mkt[finSymbols[5]].close!=null ? mkt[finSymbols[5]].close.slice(-1)[0].toFixed(2) !=null ? mkt[finSymbols[5]].close.slice(-1)[0].toFixed(2): mkt[finSymbols[5]].close.slice(-1)[0].toFixed(2) : mkt[finSymbols[5]].previousClose.toFixed(2);
        //x11=mkt[finSymbols[0]].close.slice(-1)[0].toFixed(2)
        finClose=x1;

        y1[0]=mkt[finSymbols[0]].previousClose.toFixed(2);
        y1[1]=mkt[finSymbols[1]].previousClose.toFixed(2);
        y1[2]=mkt[finSymbols[2]].previousClose.toFixed(2);
        y1[3]=mkt[finSymbols[3]].previousClose.toFixed(2);
        y1[4]=mkt[finSymbols[4]].previousClose.toFixed(2);
        y1[5]=mkt[finSymbols[5]].previousClose.toFixed(2);
        finPrevClose=y1;
        x1=null;
        y1=null;
        mkt=null;
        return null;
    }

    function getData(fileUrl){
        var xhr = new XMLHttpRequest;
        var scores={};
        var market={};
        var weather={};
        xhr.open("GET", fileUrl); // set Method and File
        xhr.onreadystatechange = function () {
            if(xhr.readyState == 4){ // if request_status == DONE
                if (xhr.status == 200) {
                var response = xhr.responseText;
                if (fileUrl===url3) {
                    gmail=response;
                    response=null;
                    xhr=null;
                }
                    else if (fileUrl===url2) {
                        weather=JSON.parse(response);
                        processWeatherData(weather);
                        response=null;
                        weather=null;
                        xhr=null;
                    }
                        else if(fileUrl===url1) {
                            market=JSON.parse(response);
                            processMarketData(market);
                            response=null;
                            scores=null;
                            xhr=null;
                        }
                        else if(fileUrl===url4) {
                            scores=JSON.parse(response);
                            processGameData(scores);
                            response=null;
                            market=null;
                            xhr=null;
                    }
                }
            }
        return null;
        }
        xhr.send(); // begin the request
    return null;
    }

    function getOrdinal(n) {            // assigns superfix to date
        var s=["th","st","nd","rd"],
        v=n%100;
        return (s[(v-20)%10]||s[v]||s[0]);
    }


    function checkDate() {  // check if market is open hours/days
        //curDate=Qt.formatDate(new Date(),"ddd");
        //curTime=Qt.formatTime(new Date(),"hh:mm");
        return (curTime > mstartTime && curTime < mendTime) && days.includes(curDate)
    }

    function gameState() {
        if (gameStatusState == "pre") {
            return (Qt.formatDateTime(new Date(gameDate),"h:mm ap"));
        }
        else if (gameStatusState == "in") {
            if (gameStatusDescription!="In Progress") {
                return (gameStatusDetail);
            }
            return (gamePeriod+getOrdinal(gamePeriod));
        }
        else {
            return (gameStatusDetail);
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

    function gameInterval () {
        if (gameStatusState == "pre") {
            if (Math.abs(Math.round((new Date(timeSource.data["Local"]["DateTime"]).getTime())/(60*1000))-Math.round((new Date(gameDate).getTime())/(60*1000))) < 5) {
                // less than 5 mins to game start time
                return 20*60*1000;
            }
            return 2*60*60*1000;
        }
        if (gameStatusState == "in") {
            if (gameStatusDetail=="Delayed") {
                return 1*60*60*1000;
            }
            return 20*60*1000;
        }
        if (gameStatusState == "post") {
            return 4*60*60*1000;
        }
        return  2*60*60*1000;// default 2 hours if nothing matched
    }

    property var timerTemp: Timer {                  // timer to trigger update for internet data
        id: timerTemp
        interval: 20 * 60 * 1000 // every 20 minutes
        running: true
        repeat:  true
        triggeredOnStart:false
        onTriggered: {
            if (checkDate()) {
                gatData(url1);
            }
            getData(url2);
            getData(url3);
            startTime=0;    // restart time for suspend check
             if (Math.abs((Qt.formatDateTime(checkTimer.data["Local"]["DateTime"],"hhmm")-Qt.formatDateTime(new Date(gameDate),"hhmm"))) < 5) {
                 getData(url4);
                  // less than 5 mins to game start
            }
        }
    }

    Timer {
        id: gameTimer
        interval: gameInterval()
        running: true
        repeat:  true
        triggeredOnStart:false
        onTriggered:getData(url4)
    }

    property var suspendTimer: Timer{                  // timer to trigger update after wake from suspend mode
        id: suspend
        interval: 20*1000 ///delay 20 secs for suspend to resume
        running: false
        repeat:  false
        onTriggered: {
            getData(url2);
            getData(url1);
            getData(url3);
            getData(url4);
            timerTemp.restart(); // resets starTime, timerTemp interval
            gameTimer.restart();
            startTime=0;    // restart time for suspend check
        }
    }

    DataSource {
        id: timeSource
        engine: "time"
        connectedSources: ["Local"]
        interval: 900
        onNewData:{
         (timeChanged()>1210) ?  suspendTimer.start():suspendTimer.stop()
        }
    }

    Component.onCompleted: {
        getData(url2);
        getData(url1);
        getData(url3);
        getData(url4);
    }
}
