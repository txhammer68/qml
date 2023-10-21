import QtQuick 2.9
import org.kde.plasma.core 2.1
import QtQuick.Layouts 1.5

Rectangle {
    id:golfMain
    width:640
    height:800
    color:"black"
    property var url1:"https://site.api.espn.com/apis/site/v2/sports/golf/pga/scoreboard"
    //property var url1: "/home/Data/projects/QML/sports/golf.json"
    property var scores:{}
    property var scorebard:[];
    property int key:0
    property int gameInterval:20*60*1000

    Component.onCompleted: {
        getData(url1);
        //init.start();
    }

    function getOrdinal(n) {            // assigns superfix to date
        var s=["th","st","nd","rd"],
        v=n%100;
        return (s[(v-20)%10]||s[v]||s[0]);
    }

    function getData(url){  // get json data sources
        var xhr = new XMLHttpRequest;
        //var scores={};
        xhr.open("GET", url); // set Method and File  true=asynchronous
        xhr.onreadystatechange = function () {
            if(xhr.readyState == 4){ // if request_status == DONE
                if (xhr.status == 200) {
                    var response = xhr.responseText;
                    scores=JSON.parse(response);
                    //response=null;
                    //xhr=null;
                }
            }
        }
        xhr.send(); // begin the request
    }



    function refreshGameData () {
        getData(url1);
        return null;
    }

    Component {
        id:golfers

    Column {
        spacing:2
        leftPadding:50
        Row {
            spacing:10

            Image {
                source:scores.events[0].competitions[0].competitors[index].athlete.flag.href
                width:20
                height:20
                smooth:true
                cache:true
            }
            Text {
                text:scores.events[0].competitions[0].competitors[index].athlete.fullName
                //text:scores1[0].name
                font.pointSize:12
                color:"white"
                width:165
                Layout.fillWidth:true
                horizontalAlignment: Text.AlignRight
            }

            Text {
                text:scores.events[0].competitions[0].competitors[index].score
                color:"white"
                font.pointSize:12
                width:28
                Layout.fillWidth:true
                horizontalAlignment: Text.AlignRight
            }

            Text {
                text:(typeof(scores.events[0].competitions[0].competitors[index].linescores[0].value) != "undefined") ? scores.events[0].competitions[0].competitors[index].linescores[0].value : "Na"
                color:"white"
                font.pointSize:12
                width:28
                Layout.fillWidth:true
                horizontalAlignment: Text.AlignRight
            }

            Text {
                text:(typeof(scores.events[0].competitions[0].competitors[index].linescores[1].value) != "undefined") ? scores.events[0].competitions[0].competitors[index].linescores[1].value : "Na"
                color:"white"
                font.pointSize:12
                width:28
                Layout.fillWidth:true
                horizontalAlignment: Text.AlignRight
            }

            Text {
                text:(typeof(scores.events[0].competitions[0].competitors[index].linescores[2].value) != "undefined") ? scores.events[0].competitions[0].competitors[index].linescores[2].value : "Na"
                color:"white"
                font.pointSize:12
                width:28
                Layout.fillWidth:true
                horizontalAlignment: Text.AlignRight
            }

            Text {
                text:(typeof(scores.events[0].competitions[0].competitors[index].linescores[3].value) != "undefined") ? scores.events[0].competitions[0].competitors[index].linescores[3].value : "Na"
                color:"white"
                font.pointSize:12
                width:28
                Layout.fillWidth:true
                horizontalAlignment: Text.AlignRight
            }
        }
      }
   }

 Column {
     id:titles
     height:90
     width:240
     spacing:3
    //anchors.left:golfMain.left
    anchors.top:golfMain.top
    anchors.horizontalCenter:golfMain.horizontalCenter;

    Text {
        id:eventTitle
        text:scores.events[0].name
        color:"white"
        anchors.horizontalCenter:parent.horizontalCenter;
        font.pointSize:12

        MouseArea {
            id: mouseArea1a
            anchors.fill: parent
            cursorShape:  Qt.PointingHandCursor
            hoverEnabled:true
            acceptedButtons: Qt.LeftButton | Qt.MiddleButton
            onEntered:parent.color=Theme.viewHoverColor
            onExited:parent.color="white"
            onClicked:Qt.openUrlExternally(scores.events[0].links[0].href)
        }
    }

    Text {
        id:eventDate
        text:Qt.formatDate(scores.events[0].date)
        color:"white"
        anchors.horizontalCenter:eventTitle.horizontalCenter;
        font.pointSize:12
    }

    Text {
        id:eventDetail
        text:scores.events[0].competitions[0].status.type.detail
        color:"white"
        anchors.horizontalCenter:eventTitle.horizontalCenter;
        font.pointSize:12
    }

    Rectangle {
        width:360
        height:1
        color:"gray"
        anchors.horizontalCenter:eventTitle.horizontalCenter;
    }

    Text {
        text:"RD1   RD2   RD3   RD4"
        color:"white"
        font.pointSize:11
        width:236
        Layout.fillWidth:true
        topPadding:5
        horizontalAlignment: Text.AlignRight
    }
}

    property var gameTimer: Timer {
        interval: 20*60*1000
        running:(scores.events[0].status.type.id==2)
        //id: 2 = in play, 7 = suspended
        repeat:true
        triggeredOnStart:false
        onTriggered:getData(url1)
    }

    Item {
        id:golfEvent
        width:golfMain.width
        height:golfMain.height
        anchors.top:titles.bottom
        anchors.left:golfMain.left
        anchors.topMargin:15
        anchors.bottomMargin:10
        //anchors.horizontalCenter:golfMain.horizontalCenter;
        //anchors.topMargin:10

        ListView {          // how to sort by scores ?? /// show which hole current playing, which round?
            id:golfView
            anchors.fill: parent
            //anchors.centerIn:parent
            //anchors.horizontalCenter:golfMain.horizontalCenter;
            model:Object.keys(scores.events[0].competitions[0].competitors).length
            delegate: golfers
            header : eventHeader
            //highlight: highlightBar
            //highlightFollowsCurrentItem: false
            spacing: 5
            }
        }

}
