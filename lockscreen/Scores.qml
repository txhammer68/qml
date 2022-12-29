import QtQuick 2.9
import org.kde.plasma.core 2.1

Item {
    id:scoresMain
    width:640
    height:85

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

        Image{
            id:atl
            source:infoData.awayTeamLogo
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
            text:infoData.awayTeamAbrev
            color:"white"
            font.pointSize:16
            anchors.topMargin:10
            anchors.leftMargin:15
            anchors.rightMargin:15
            anchors.top:rect1.top
            anchors.left:atl.right

            Text {
                id:atr
                text:"("+infoData.awayTeamRecord+")"
                color:"lightgray"
                font.pointSize:10
                antialiasing : true
                anchors.horizontalCenter:parent
                anchors.top:parent.bottom
            }
        }

        Text {
            text:infoData.awayTeamScore
            color:"white"
            font.pointSize:16
            anchors.topMargin:10
            anchors.top:rect1.top
            anchors.left:ateam.right
            anchors.leftMargin:15
        }

        Text {
            text:infoData.gameState()
            color:"white"
            anchors.topMargin:15
            anchors.top:rect1.top
            anchors.horizontalCenter:rect1.horizontalCenter

            Text {
                text:Qt.formatDateTime(new Date(infoData.gameDate),"M/dd/yy")
                color:"gray"
                font.pointSize:10
                anchors.top:parent.bottom
                anchors.horizontalCenter:parent.horizontalCenter
            }
        }

        Image{
            id:htl
            source:infoData.homeTeamLogo
            height:48
            width:48
            anchors.right:hta.left
            anchors.top:rect1.top
            anchors.rightMargin:15
            anchors.topMargin:10
        }

        Text {
            id:hta
            text:infoData.homeTeamAbrev
            color:"white"
            font.pointSize:16
            anchors.topMargin:10
            anchors.leftMargin:15
            anchors.rightMargin:15
            anchors.top:rect1.top
            anchors.right:hts.left

            Text {
                text:"("+infoData.homeTeamRecord+")"
                color:"lightgray"
                font.pointSize:10
                anchors.top:parent.bottom
                anchors.horizontalCenter:parent.horizontalCenter
            }
        }

        Text {
            id:hts
            text:infoData.homeTeamScore
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
            text:infoData.gameHeadline
            color:Theme.textColor
            font.pointSize:11
            antialiasing : true
            leftPadding:5
            width:rect1.width*.97
            elide: Text.ElideRight
            wrapMode: Text.NoWrap
        }
    }
}
