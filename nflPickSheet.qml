import QtQuick 2.12
import QtQuick.Controls 2.12
//import org.kde.plasma.components 2.0
//import org.kde.plasma.core 2.1
import QtQuick.Layouts 1.5


// mlb scores espn api

Rectangle {
    id:root
    width:900
    height:960
    color:"white"
    //implicitHeight:20

    property var url1: "http://site.api.espn.com/apis/site/v2/sports/football/nfl/scoreboard"
    // property var url1: "/Data/projects/QML/sports/nfl3.json"
    property var scores:{}
    //property var listViewHeight:20


    /// Object.keys(index.events).length  // array size

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
        //property var listViewHeight:Object.keys(scores.events).length * 50
        //root.height=listViewHeight
       // weekDate.text="TEST"
    }



    Timer {
        interval:1000*60*15
        running:true
        repeat:true
        onTriggered: getData(url1)
    }


    Image {
        id:logo
        source:"nfl.png"
        width:96
        height:96
        smooth:true
        anchors.top:root.top
        anchors.left:root.left
        anchors.bottomMargin:5
        anchors.topMargin:-15
    }

    Button {
        anchors.top: root.top
        anchors.right:root.right
        anchors.topMargin:10
        anchors.rightMargin:60
        //text:"🖨️"
        width: 22
        height: 22
        contentItem: Image {
            //text: "🖨️"
            source:"printer-symbolic.svg"
            //font.pointSize: 24
            //opacity: enabled ? 1.0 : 0.3
            //color: control.down ? "#17a81a" : "#21be2b"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        onClicked: {
            var stat = root.grabToImage(function(result) {
                result.saveToFile("./NFL-Week - "+scores.week.number+".jpg");
                //saves to a file
                //PRINT.print(result.image); //result.image holds the QVariant
            });
            // console.log("Success: ", stat);
            // // also grabWindow()
        }
    }

    Text {
        id:weekDate
        text:Qt.formatDateTime(scores.events[0].date,"  MMMM  d, yyyy")
        //text:"./NFL-Week - "+scores.week.number+Qt.formatDateTime(scores.events[0].date," - M/dd/yyyy")+".png"
        color:"black"
        font.pointSize:14
        antialiasing : true
        anchors.topMargin:10
        anchors.top:root.top
        anchors.horizontalCenter:root.horizontalCenter;
    }

    Text {
        id:weekNumber
        text:"Week: "+scores.week.number
        color:"black"
        font.pointSize:14
        antialiasing : true
        anchors.horizontalCenter:root.horizontalCenter;
        anchors.top:weekDate.bottom
    }

    Rectangle {
        id:titleSepr
        anchors.top:logo.bottom
        width:root.width*.95
        height:2
        color:"gray"
        anchors.left:root.left
        anchors.leftMargin:20
    }

    ButtonGroup { id: picks1 }
    ButtonGroup { id: picks2 }
    ButtonGroup { id: picks3 }
    ButtonGroup { id: picks4 }
    ButtonGroup { id: picks5 }
    ButtonGroup { id: picks6 }
    ButtonGroup { id: picks7 }
    ButtonGroup { id: picks8 }
    ButtonGroup { id: picks9 }
    ButtonGroup { id: picks10 }
    ButtonGroup { id: picks11 }
    ButtonGroup { id: picks12 }
    ButtonGroup { id: picks13 }
    ButtonGroup { id: picks14 }
    ButtonGroup { id: picks15 }
    ButtonGroup { id: picks16 }

    Component {
        id: games

        Column {
            id:col1
            spacing:1

            Row {
                spacing:20
                leftPadding:10
                topPadding:10


                CheckBox {
                    id: control
                    checked: false
                    //checkState: anyChildChecked ? Qt.Unchecked : Qt.Checked
                    //onCheckedChanged:  anyChildChecked ? Qt.Unchecked : Qt.Checked

                    ButtonGroup.group: {
                        if (index==0) picks1
                            else if (index==1) picks2
                                else if(index==2) picks3
                                    else if(index==3) picks4
                                        else if(index==4) picks5
                                            else if(index==5) picks6
                                                else if(index==6) picks7
                                                    else if(index==7) picks8
                                                        else if(index==8) picks9
                                                            else if(index==9) picks10
                                                                else if(index==10) picks11
                                                                    else if(index==11) picks12
                                                                        else if(index==12) picks13
                                                                            else if(index==13) picks14
                                                                                else if(index==14) picks15
                                                                                    else if(index==15) picks16
                    }
                    indicator: Rectangle {
                        implicitWidth: 20
                        implicitHeight: 20
                        radius: 3
                        border.color:"black"

                        Rectangle {
                            width: 12
                            height: 14
                            x: 4
                            y: 4
                            radius: 2
                            //color: control.down ? "#17a81a" : "black"
                            color: "red"
                            visible: control.checked
                        }
                    }
                }


                Image {
                    source:scores.events[index].competitions[0].competitors[1].team.logo
                    width:42
                    height:42
                    smooth:true
                    y:-10
                }

                Text {
                    text:scores.events[index].competitions[0].competitors[1].team.displayName
                    color:"black"
                    font.pointSize:14
                    width:200
                    topPadding:5
                    Layout.fillWidth:true
                    antialiasing : true
                }


                Text {
                    text:scores.events[index].competitions[0].competitors[1].score
                    color:"black"
                    font.pointSize:13
                    font.bold:true
                    width:60
                    topPadding:5
                    Layout.fillWidth:true
                    antialiasing : true
                }

                CheckBox {
                    id: control1
                    //text: qsTr("CheckBox1")
                    checked: false
                    checkState: anyChildChecked ? Qt.Unchecked : Qt.Checked
                    ButtonGroup.group: {
                        if (index==0) picks1
                            else if (index==1) picks2
                                else if(index==2) picks3
                                    else if(index==3) picks4
                                        else if(index==4) picks5
                                            else if(index==5) picks6
                                                else if(index==6) picks7
                                                    else if(index==7) picks8
                                                        else if(index==8) picks9
                                                            else if(index==9) picks10
                                                                else if(index==10) picks11
                                                                    else if(index==11) picks12
                                                                        else if(index==12) picks13
                                                                            else if(index==13) picks14
                                                                                else if(index==14) picks15
                                                                                    else if(index==15) picks16
                    }
                    indicator: Rectangle {
                        implicitWidth: 20
                        implicitHeight: 20
                        //x: control1.leftPadding
                        // y: parent.height / 2 - height / 2
                        radius: 3
                        border.color:"black"

                        Rectangle {
                            width: 12
                            height: 14
                            x: 4
                            y: 4
                            radius: 2
                            //color: control1.down ? "#17a81a" : "black"
                            color: "red"
                            visible: control1.checked
                        }
                    }
                }

                Image {
                    source:scores.events[index].competitions[0].competitors[0].team.logo
                    width:42
                    height:42
                    y:-10
                    smooth:true
                }
                Text {
                    text:scores.events[index].competitions[0].competitors[0].team.displayName
                    color:"black"
                    font.pointSize:14
                    width:200
                    topPadding:5
                    Layout.fillWidth:true
                    antialiasing : true
                }

                Text {
                    text:scores.events[index].competitions[0].competitors[0].score
                    color:"black"
                    font.pointSize:12
                    font.bold:true
                    topPadding:5
                    antialiasing : true
                }
            }
            Row {
                leftPadding:100
                topPadding:-18
                spacing:30
                //anchors.horizontalCenter:root.horizontalCenter;

                Text {
                    //text:Qt.formatDateTime(new Date(scores.events[index].date),"dddd dd/mm/yyyy - h:mm ap")
                    property var gameStatus:scores.events[index].competitions[0].status.type.state == "pre" ? gameStatus=scores.events[index].competitions[0].status.type.detail : "    \t\t\t   "+"     "+scores.events[index].competitions[0].status.type.detail
                    text:gameStatus
                    //Qt.formatDateTime(scores.events[0].date,"  MMMM  d, yyyy")+"\n\t"+"Week: "+scores.week.number
                    color:"gray"
                    font.pointSize:12
                    antialiasing : true
                }

                Text {
                    text:"Line: "+scores.events[index].competitions[0].odds[0].details+"\t"+"Over/Under: "+scores.events[index].competitions[0].odds[0].overUnder
                    color:"gray"
                    font.pointSize:12

                    antialiasing : true
                }
            }
            Rectangle {
                width:root.width*.95
                height:2
                color:"gray"
                x:10
                anchors.leftMargin:20
            }
        }
    }

    Item {
        id:game
        width:root.width
        height:root.height
        anchors.top:titleSepr.bottom
        anchors.left:root.left
        anchors.horizontalCenter:root.horizontalCenter;
        anchors.topMargin:10

        ListView {
            id:gameView
            anchors.fill: parent
            model: Object.keys(scores.events).length
            delegate: games
            spacing: 5
            }

            //Component.onCompleted: {
             //   listViewHeight=Object.keys(scores.events).length * 50
             //   root.implicitHeight=listViewHeight
            //}
        }
    }
