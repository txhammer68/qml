import QtQuick 2.8
import QtQuick.Controls 2.15
import org.kde.plasma.components 2.0
import org.kde.plasma.extras 2.0
import org.kde.plasma.core 2.0
import QtQuick.Layouts 1.1


// mlb scores espn api

Item {
    id:root
    width:600
    //height:400
    //implicitHeight:listViewHeight
    Layout.fillHeight: true

    Layout.preferredWidth:600
    Layout.preferredHeight:listViewHeight
    Layout.alignment: Qt.AlignHCenter

    Timer {
        interval:400
        running:false
        repeat:false
        onTriggered: root.height=listViewHeight//root.height=640//Object.keys(scores.events).length*9.35
    }

    property var url1:"http://site.api.espn.com/apis/site/v2/sports/baseball/mlb/scoreboard"
    property var scores:{}
    property var listViewHeight:Object.keys(scores.events).length * 60

    property real fixedHeight: {
        if (showText) {
            if (textUnderIcon)
                return columnLabels.height + 2 * margins
            else
                return 2 * margins
        }
        else
            return 2 * margins
    }



    /// Object.keys(index.events).length  // array size

    Rectangle {
        width:root.width
        height:root.height
        color:"white"
        opacity:.75
        anchors.horizontalCenter:root.horizontalCenter;
    }


    function getData(url){  // get data json api scores
        var xhr = new XMLHttpRequest;
        xhr.open("GET", url); // set Method and File  true=asynchronous
        xhr.onreadystatechange = function () {
            if(xhr.readyState === XMLHttpRequest.DONE){ // if request_status == DONE
                var response = xhr.responseText;
                scores=JSON.parse(response)
            }
        }
        xhr.send(); // begin the request
    }

    Component.onCompleted: {
        getData(url1)
         listViewHeight=Object.keys(scores.events).length * 60

    }

    Timer {
        interval:400
        running:true
        repeat:false
        onTriggered: listViewHeight=Object.keys(scores.events).length * 60//root.height=640//Object.keys(scores.events).length*9.35
    }


    Image {
        id:logo
        source:"espn.jpg"
        width:96
        height:24
        smooth:true
        anchors.top:root.top
        anchors.left:root.left
        anchors.bottomMargin:10
        anchors.topMargin:5
    }

    Image {
        id:logo2
        source:"mlb.png"
        width:96
        height:64
        smooth:true
        anchors.top:root.top
        anchors.right:root.right
        anchors.topMargin:-10
        anchors.bottomMargin:10
    }


    Component {
            id: games

    Column {
        id:col1
        spacing:10
        topPadding:10
        anchors.horizontalCenter:root.horizontalCenter;

            Row {
                id:gm
                spacing:10
                leftPadding:10
                Rectangle {
                    width:root.width*.98
                    height:40
                    color:"transparent"
                    border.color:"lightgray"
                    border.width:2
                    radius:6
                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        cursorShape:  Qt.PointingHandCursor
                        hoverEnabled:true
                        onEntered:parent.border.color="steelblue"
                        onExited:parent.border.color="lightgray"
                        onClicked: {
                            Qt.openUrlExternally(scores.events[index].links[0].href)
                        }
                    }
                }
                Item {
                    id:scr
                    height:20
                    anchors.centerIn:rect1

                    Row {
                        spacing:20
                        topPadding:5
                        leftPadding:10
                        Image {
                            source:scores.events[index].competitions[0].competitors[1].team.logo
                            width:28
                            height:28
                            smooth:true
                        }

                        Text {
                            text:scores.events[index].competitions[0].competitors[1].team.displayName
                            color:"black"
                            font.pointSize:14
                            width:200
                            Layout.fillWidth:true
                        }

                        Text {
                            text:scores.events[index].competitions[0].competitors[1].score
                            color:"black"
                            font.pointSize:14
                        }
                        Image {
                            source:scores.events[index].competitions[0].competitors[0].team.logo
                            width:28
                            height:28
                            smooth:true
                        }
                        Text {
                            text:scores.events[index].competitions[0].competitors[0].team.displayName
                            color:"black"
                            font.pointSize:14
                            width:200
                            Layout.fillWidth:true
                        }
                        Text {
                            text:scores.events[index].competitions[0].competitors[0].score
                            color:"black"
                            font.pointSize:14
                        }
                    }
                }
            }
        }
    }

    Item {
        id:game
        anchors.top:logo.bottom
        anchors.topMargin:25
        width:root.width
       // height:root.height
        implicitHeight:root.implicitHeight
        anchors.fill:parent
        //anchors.horizontalCenter:root.horizontalCenter;


        ListView {
        anchors.fill: parent
        //anchors.horizontalCenter:root.horizontalCenter;
        model: Object.keys(scores.events).length
       // highlight:
        delegate: games
        spacing: 5
        }
    }
}
