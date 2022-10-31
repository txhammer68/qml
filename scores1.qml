import QtQuick 2.9
import org.kde.plasma.core 2.1

Rectangle {
    id:scoresMain
    width:420
    height:185
    color:"black"
    // docs https://gist.github.com/akeaswaran/b48b02f1c94f873c6655e7129910fc3b
    //property var url1:"https://site.api.espn.com/apis/site/v2/sports/baseball/mlb/teams/18"
    //property var url1:"https://site.api.espn.com/apis/site/v2/sports/baseball/mlb/scoreboard"
   // property var url1:"/home/matt/Downloads/scoreboard.json"
    property var url1:"https://site.api.espn.com/apis/site/v2/sports/basketball/nba/scoreboard"
    //property var scores:{}
    property var key:0
    property var t1:""
    //property var favTeam:"Houston Astros"
    property var favTeam:"Houston Rockets"

    property var gameStatusState:""
    property var gameStatusDetail:""
    property var gameStatusDescription:""
    property var gamePeriod:""
    property var gameDate:""
    property var gameHeadline:""
    property var gamePlayoffRecord:""
    property var gameAltHeadline:""
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

    Component.onCompleted: {
        getData(url1);
    }

    function getOrdinal(n) {            // assigns superfix to date
        var s=["th","st","nd","rd"],
        v=n%100;
        return (s[(v-20)%10]||s[v]||s[0]);
    }

    function getData(url){  // get json data sources
        var xhr = new XMLHttpRequest;
        var scores={};
        xhr.open("GET", url); // set Method and File  true=asynchronous
        xhr.onreadystatechange = function () {
            if(xhr.readyState == 4){ // if request_status == DONE
                if (xhr.status == 200) {
                    var response = xhr.responseText;
                    scores=JSON.parse(response);
                    processGameData(scores);
                    response=null;
                    xhr=null;
                }
            }
        return
        }
        xhr.send(); // begin the request
    }

    function processGameData (scores) {

        for (var i = 0; i < Object.keys(scores.events).length; i++) {

            if (scores.events[i].competitions[0].competitors[0].team.displayName===favTeam)  {
                key=i
                break;
            }
            else if (scores.events[i].competitions[0].competitors[1].team.displayName===favTeam)  {
                key=i
                break;
            }
             key=0; // else no home team game, pick first available game.
        }

        gameStatusState=scores.events[key].competitions[0].status.type.state;
        gameStatusDetail=scores.events[key].competitions[0].status.type.detail;
        gameStatusDescription=scores.events[key].competitions[0].status.type.description;
        gamePeriod=scores.events[key].competitions[0].status.period;
        gameDate=scores.events[key].competitions[0].date;

        gameboxScoresURL=scores.events[key].links[0].href;
        //sevents[0].competitions[0].series.title
        gamePlayoffRecord=scores.events[key].competitions[0].hasOwnProperty("series") ? scores.events[key].competitions[0].series.summary:""
        gameAltHeadline=(typeof scores.events[key].competitions[0].notes[0]!="undefined") ? scores.events[key].competitions[0].notes[0].headline : ""
        gameHeadline=scores.events[key].competitions[0].hasOwnProperty("headlines") ? scores.events[key].competitions[0].headlines[0].shortLinkText : gameAltHeadline+"    "+gamePlayoffRecord
        //gameHeadline=scores.events[key].competitions[0].hasOwnProperty("headlines") ? scores.events[key].competitions[0].headlines[0].shortLinkText : ""
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
        scores=null;
        return
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

    function gameInterval () {
        if (gameStatusState == "pre") {
            if (Math.abs((Qt.formatDateTime(checkTimer.data["Local"]["DateTime"],"hhmm")-Qt.formatDateTime(new Date(gameDate),"hhmm"))) < 2) {
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
            return 8*60*60*1000;
        }
        return  2*60*60*1000;// default 2 hours if nothing matched
    }

    function refreshGameData () {
        getData(url1);
        return
    }

    Rectangle {
        id:rect1
        width:scoresMain.width*.99
        height:85
        antialiasing : true
        color:"transparent"
        border.color:"transparent"
        radius:8
        anchors.top:scoresMain.top
        anchors.left:scoresMain.left
        anchors.leftMargin:2

        MouseArea {
            id: mouseArea1a
            anchors.fill: parent
            cursorShape:  Qt.PointingHandCursor
            hoverEnabled:true
            acceptedButtons: Qt.LeftButton | Qt.MiddleButton
            onEntered:parent.border.color=Theme.viewHoverColor
            onExited:parent.border.color="transparent"
            onClicked:(mouse.button==Qt.LeftButton) ? Qt.openUrlExternally(gameboxScoresURL) : refreshGameData()
        }

        Image{
            id:atl
            source:awayTeamLogo
            height:48
            width:48
            anchors.left:rect1.left
            anchors.top:rect1.top
            anchors.leftMargin:15
            anchors.rightMargin:15
            anchors.topMargin:10
        }

        Text {
            id:ateam
            text:awayTeamAbrev
            color:"white"
            font.pointSize:16
            anchors.topMargin:10
            anchors.leftMargin:15
            anchors.rightMargin:15
            anchors.top:rect1.top
            anchors.left:atl.right

            Text {
                id:atr
                text:"("+awayTeamRecord+")"
                color:"gray"
                font.pointSize:10
                antialiasing : true
                anchors.horizontalCenter:parent
                anchors.top:parent.bottom
            }
        }

        Text {
            text:awayTeamScore
            color:"white"
            font.pointSize:16
            anchors.topMargin:10
            anchors.top:rect1.top
            anchors.left:ateam.right
            anchors.leftMargin:15
        }

        Text {
            text:gameState()
            color:"white"
            anchors.topMargin:15
            anchors.top:rect1.top
            anchors.horizontalCenter:rect1.horizontalCenter

            Text {
                text:Qt.formatDateTime(new Date(gameDate),"M/dd/yy")
                color:"gray"
                font.pointSize:10
                anchors.top:parent.bottom
                anchors.horizontalCenter:parent.horizontalCenter
            }
        }

        Image{
            id:htl
            source:homeTeamLogo
            height:48
            width:48
            anchors.right:hta.left
            anchors.top:rect1.top
            anchors.rightMargin:15
            anchors.topMargin:10
        }

        Text {
            id:hta
            text:homeTeamAbrev
            color:"white"
            font.pointSize:16
            anchors.topMargin:10
            anchors.leftMargin:15
            anchors.rightMargin:15
            anchors.top:rect1.top
            anchors.right:hts.left

            Text {
                text:"("+homeTeamRecord+")"
                color:"gray"
                font.pointSize:10
                anchors.top:parent.bottom
                anchors.horizontalCenter:parent.horizontalCenter
            }
        }

        Text {
            id:hts
            text:homeTeamScore
            color:"white"
            font.pointSize:16
            anchors.topMargin:10
            anchors.leftMargin:15
            anchors.rightMargin:15
            anchors.top:rect1.top
            anchors.right:rect1.right
        }

        Text {
            anchors.bottom:rect1.bottom
            anchors.left:rect1.left
            anchors.bottomMargin:2
            text:gameHeadline
            color:Theme.textColor
            font.pointSize:10
            antialiasing : true
            leftPadding:5
            width:rect1.width*.97
            elide: Text.ElideRight
            wrapMode: Text.NoWrap
        }
    }

    property var gameTimer: Timer {
        interval: gameInterval()
        running:true
        repeat:true
        triggeredOnStart:false
        onTriggered:getData(url1)
    }

    DataSource {
        id: checkTimer  // use system clock for wake from suspend check
        engine: "time"
        connectedSources: ["Local"]
        interval: 995
        //onNewData:timeChanged()>1210 ?  suspendTimer.start():suspendTimer.stop()
    }
}
