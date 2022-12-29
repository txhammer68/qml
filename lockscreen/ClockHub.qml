import QtQuick 2.9
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.5
import org.kde.plasma.core 2.1

// clock hub google nest style
Item {
    id:clockHub
    //width:900
    //height:500
    //visible:true

    property var font_color:"whitesmoke"         // change font color
    property var font_style1:"Noto Serif"   // change clock font
    property var font_style2:"SF Pro Display"    // change info status font
    property int today:Qt.formatDate(timeSource.data["Local"]["DateTime"],"MMdd")
    property var finTitles:["DOW","NASDAQ","S&P 500","OIL","GOLD","10Y BOND"]
    property var nth:infoData.getOrdinal(Qt.formatDate(timeSource.data["Local"]["DateTime"],"d"))

    function isPositive(num) {
        if(num < 0)
            return false;
        else
            return true;
    }

    function formatNumber(num) {
        return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,')
    }

    GetData {id:infoData}
    Events {id:dates}


    Column {
        id:c1
        anchors.horizontalCenter: clockHub.horizontalCenter
        anchors.top:parent.top
        spacing:2

        Text {
            id:time
            text:Qt.formatTime(timeSource.data["Local"]["DateTime"],"h:mm ap").replace("am", "").replace("pm", "")
            color: font_color
            antialiasing : true
            font.pointSize: 72
            font.family: font_style1
        }

        Text {
            id:date
            textFormat: Text.RichText
            text: Qt.formatDate(timeSource.data["Local"]["DateTime"],"dddd - MMMM  d")+"<sup>"+nth+"</sup>"
            // html markup for superfix date
            color: font_color
            antialiasing : true
            font.pointSize: 28
            font.family: font_style1
        }

        Text {
            id:calEvents
            textFormat: Text.RichText
            text:dates.events[today]
            height: (dates.events[today] === undefined) ? 1 : 30
            visible:(dates.events[today] === undefined) ? false : true
            color: font_color
            antialiasing : true
            font.pointSize: 16
            font.family: font_style1
        }

        Component.onCompleted: {
            for (var item in children)
                children[item].anchors.horizontalCenter = c1.horizontalCenter;
        }

        Rectangle {
            id:ts
            width:700
            height:1
            color:"gray"
        }
    }

    Item {
        id:info
        anchors.top:c1.bottom
        anchors.left:c1.left
        anchors.right:c1.right
        Layout.preferredWidth :620
        opacity:1
        Row {
            id:r1
            leftPadding:20
            spacing:20

            Image {
                id: wIcon
                asynchronous : true
                cache: false
                source:infoData.weatherIcon
                smooth: true
                sourceSize.width: 56
                sourceSize.height: 56
            }

            Text {
                id:current_weather_conditions
                Layout.fillWidth: false
                topPadding:15
                text:infoData.weatherWarnings ? infoData.weatherAlertText : infoData.weatherConditions
                font.family: font_style2
                font.pointSize: 18
                color: font_color
                antialiasing : true
            }
        }
        Row {
            anchors.right:parent.right
            rightPadding:20
            topPadding:10
            spacing:10
            Image {
                id:email_icon
                source: "../icons/gmail.png"
                smooth: true
                sourceSize.width: 28
                sourceSize.height: 28
            }

            Text {
                id:email_count
                text: infoData.gmail
                font.family: font_style2
                font.pointSize:14
                color: font_color
                antialiasing : true
            }
        }
    }

    Item {
        id:info2
        anchors.top:c1.bottom
        anchors.horizontalCenter: clockHub.horizontalCenter
        Layout.preferredWidth :620
        opacity:0

        Column {
            id:forecast
            anchors.horizontalCenter: info2.horizontalCenter
            topPadding:10
            visible:true
            spacing:1

            Row {
                spacing:60
                Repeater {
                    model: 7
                    Text {
                        text:infoData.forecastDays[index]
                        color:font_color
                        font.pointSize:14
                        font.bold:true

                        Image {
                            source:infoData.forecastIcons[index]
                            anchors.horizontalCenter:parent.horizontalCenter
                            anchors.top:parent.bottom
                            width:48
                            height:48

                            Text {
                                anchors.horizontalCenter:parent.horizontalCenter
                                anchors.top:parent.bottom
                                text:infoData.forecastRains[index]
                                color:font_color
                                font.pointSize:14

                                Text {
                                    text:infoData.forecastTemps[index]
                                    color:font_color
                                    font.pointSize:14
                                    anchors.horizontalCenter:parent.horizontalCenter
                                    anchors.top:parent.bottom
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Item {
        id:info3
        anchors.top:c1.bottom
        visible:true
        opacity:0
        anchors.horizontalCenter:clockHub.horizontalCenter;

        Scores{anchors.horizontalCenter:info3.horizontalCenter;}
    }

    Item {
        id:info4
        anchors.top:c1.bottom
        anchors.horizontalCenter:clockHub.horizontalCenter;
        visible:true
        opacity:0

        Column {
            anchors.horizontalCenter:info4.horizontalCenter;
            topPadding:10
            Row {
                spacing:160
                anchors.horizontalCenter:info4.horizontalCenter;

                Text {
                    text:finTitles[0]
                   color:font_color
                    font.pointSize:16
                    font.bold:true

                    Row {
                        anchors.horizontalCenter:parent.horizontalCenter;
                        anchors.top:parent.bottom
                        spacing:20
                        Text {
                            text:formatNumber(infoData.finClose[0])
                            color:font_color
                            font.pointSize:14
                        }

                        Text {
                            text:isPositive(infoData.finClose[0]-infoData.finPrevClose[0]) ? "▲":"▼"
                            color:isPositive(infoData.finClose[0]-infoData.finPrevClose[0]) ? "green":"red"
                            font.pointSize:16
                        }

                        Text {
                            text:formatNumber((infoData.finClose[0]-infoData.finPrevClose[0]).toFixed(2))
                            color:isPositive(infoData.finClose[0]-infoData.finPrevClose[0]) ? "green":"red"
                            font.pointSize:14
                        }
                    }
                }
                Text {
                    text:finTitles[1]
                   color:font_color
                    font.pointSize:16
                    font.bold:true

                    Row {
                        id:t3
                        anchors.horizontalCenter:parent.horizontalCenter;
                        anchors.top:parent.bottom
                        spacing:20
                        Text {
                            text:formatNumber(infoData.finClose[1])
                           color:font_color
                            font.pointSize:14
                            antialiasing : true
                        }

                        Text {
                            text:isPositive(infoData.finClose[1]-infoData.finPrevClose[1]) ? "▲":"▼"
                            color:isPositive(infoData.finClose[1]-infoData.finPrevClose[1]) ? "green":"red"
                            font.pointSize:16
                            antialiasing : true
                        }

                        Text {
                            text:formatNumber((infoData.finClose[1]-infoData.finPrevClose[1]).toFixed(2))
                            color:isPositive(infoData.finClose[1]-infoData.finPrevClose[1]) ? "green":"red"
                            font.pointSize:14
                            antialiasing : true
                        }
                    }
                }
                Text {
                    text:finTitles[2]
                   color:font_color
                    font.pointSize:16
                    font.bold:true

                    Row {
                        id:t4
                        anchors.horizontalCenter:parent.horizontalCenter;
                        anchors.top:parent.bottom
                        spacing:20
                        Text {
                            text:formatNumber(infoData.finClose[2])
                           color:font_color
                            font.pointSize:14
                            antialiasing : true
                        }

                        Text {
                            text:isPositive(infoData.finClose[2]-infoData.finPrevClose[2]) ? "▲":"▼"
                            color:isPositive(infoData.finClose[2]-infoData.finPrevClose[2]) ? "green":"red"
                            font.pointSize:16
                            antialiasing : true
                        }

                        Text {
                            text:formatNumber((infoData.finClose[2]-infoData.finPrevClose[2]).toFixed(2))
                            color:isPositive(infoData.finClose[2]-infoData.finPrevClose[2]) ? "green":"red"
                            font.pointSize:14
                            antialiasing : true
                        }
                    }
                }
            }
        }
    }

    Item {
        id:info5
        anchors.top:c1.bottom
        anchors.horizontalCenter:clockHub.horizontalCenter;
        visible:true
        opacity:0

        Column {
            anchors.horizontalCenter:info5.horizontalCenter;
            topPadding:10
            Row {
                spacing:160
                anchors.horizontalCenter:info5.horizontalCenter;

                Text {
                    text:finTitles[3]
                   color:font_color
                    font.pointSize:16
                    font.bold:true

                    Row {
                        anchors.horizontalCenter:parent.horizontalCenter;
                        anchors.top:parent.bottom
                        spacing:20
                        Text {
                            text:formatNumber(infoData.finClose[3])
                           color:font_color
                            font.pointSize:14
                        }
                        Text {
                            text:isPositive(infoData.finClose[3]-infoData.finPrevClose[3]) ? "▲":"▼"
                            color:isPositive(infoData.finClose[3]-infoData.finPrevClose[3]) ? "green":"red"
                            font.pointSize:16
                        }
                        Text {
                            text:formatNumber((infoData.finClose[3]-infoData.finPrevClose[3]).toFixed(2))
                            color:isPositive(infoData.finClose[3]-infoData.finPrevClose[3]) ? "green":"red"
                            font.pointSize:14
                        }
                    }
                }
                Text {
                    text:finTitles[4]
                   color:font_color
                    font.pointSize:16
                    font.bold:true

                    Row {
                        anchors.horizontalCenter:parent.horizontalCenter;
                        anchors.top:parent.bottom
                        spacing:20
                        Text {
                            text:formatNumber(infoData.finClose[4])
                           color:font_color
                            font.pointSize:14
                            antialiasing : true
                        }

                        Text {
                            text:isPositive(infoData.finClose[4]-infoData.finPrevClose[4]) ? "▲":"▼"
                            color:isPositive(infoData.finClose[4]-infoData.finPrevClose[4]) ? "green":"red"
                            font.pointSize:16
                            antialiasing : true
                        }

                        Text {
                            text:formatNumber((infoData.finClose[4]-infoData.finPrevClose[4]).toFixed(2))
                            color:isPositive(infoData.finClose[4]-infoData.finPrevClose[4]) ? "green":"red"
                            font.pointSize:14
                            antialiasing : true
                        }
                    }
                }
                Text {
                    text:finTitles[5]
                   color:font_color
                    font.pointSize:16
                    font.bold:true

                    Row {
                        anchors.horizontalCenter:parent.horizontalCenter;
                        anchors.top:parent.bottom
                        spacing:20
                        Text {
                            text:formatNumber(infoData.finClose[5])
                           color:font_color
                            font.pointSize:14
                            antialiasing : true
                        }

                        Text {
                            text:isPositive(infoData.finClose[5]-infoData.finPrevClose[5]) ? "▲":"▼"
                            color:isPositive(infoData.finClose[5]-infoData.finPrevClose[5]) ? "green":"red"
                            font.pointSize:16
                            antialiasing : true
                        }

                        Text {
                            text:formatNumber((infoData.finClose[5]-infoData.finPrevClose[5]).toFixed(2))
                            color:isPositive(infoData.finClose[5]-infoData.finPrevClose[5]) ? "green":"red"
                            font.pointSize:14
                            antialiasing : true
                        }
                    }
                }
            }
        }
    }

    Item {
        id:animators

        ParallelAnimation {
            running: true
            loops: Animation.Infinite
            SequentialAnimation {
                id:ani1
                running: true
                loops: Animation.Infinite

                PropertyAnimation {
                    target: info;
                    property :"opacity"; to: 1 }


                    PauseAnimation { duration: 7000 }

                    PropertyAnimation {
                        target: info;
                        property:"opacity"; to: 0
                        duration: 1000
                    }

                    PropertyAnimation {
                        target: info2;
                        property:"opacity"; to: 1
                        duration: 1000
                    }

                    PauseAnimation { duration: 7000 }

                    PropertyAnimation {
                        target: info2;
                        property:"opacity"; to: 0
                        duration: 1000
                    }

                    PropertyAnimation {
                        target: info3;
                        property:"opacity"; to: 1
                        duration: 1000
                    }

                    PauseAnimation { duration: 7000 }

                    PropertyAnimation {
                        target: info3;
                        property:"opacity"; to: 0
                        duration: 1000
                    }

                    PropertyAnimation {
                        target: info4;
                        property:"opacity"; to: 1
                        duration: 1000
                    }

                    PauseAnimation { duration: 7000 }

                    PropertyAnimation {
                        target: info4;
                        property:"opacity"; to: 0
                        duration: 1000
                    }

                    PropertyAnimation {
                        target: info5;
                        property:"opacity"; to: 1
                        duration: 1000
                    }

                    PauseAnimation { duration: 7000 }

                    PropertyAnimation {
                        target: info5;
                        property:"opacity"; to: 0
                        duration: 1000
                    }

            }
        }
    }
    DataSource {
        id: timeSource
        engine: "time"
        connectedSources: ["Local"]
        interval: 1000
    }
}
