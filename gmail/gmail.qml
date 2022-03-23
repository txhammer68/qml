import QtQuick 2.8
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.5
import org.kde.plasma.core 2.0
//import QtWebView 1.15
import QtWebEngine 1.5
// g-mail suite workspace app using qt webview
// load each in a seperate webview for fast switching views
// TO-DO
// shortcut keys to switch views
// integrate mailto handler for system wide email client
// dark mode switch
// settings for univeral mail app, urls for other mailboxes,calendars, etc...i.e not google

ApplicationWindow {
        id:root
        visible: true
        width: 1600
        height: 850
        title: "Google Workspaces"
        Component.onCompleted: {
               // Qt.qputenv("QTWEBENGINE_CHROMIUM_FLAGS=--force-dark-mode")
                //qputenv(const char *varName, const QByteArray &value)
                //QtWebView.initialize()
                QtWebEngine.initialize()
                //Keys.onPressed: {
                //if(event.key===Qt.Key_Control && (event.modifiers & Qt.Key_Tab)){
                //Keys.onPressed:Qt.Key_Control && Qt.Key_Tab=viewInbox.visible=false
               //&&  Keys.onTabPressed) =  {viewInbox.visible=false
                //focusPolicy: Qt.StrongFocus
        }

        Rectangle {
                color:"black"
                width:root.width
                height:root.height
                opacity:.75

        }

        Column {
                id:navbar
                spacing:50
                leftPadding:15

                IconItem {
                        id:inbox
                        width: 48
                        height: 48
                        source: "mail-inbox"
                        enabled:true
                        opacity:viewInbox.visible  ||  mouseArea.containsMouse ? 1:.5
                        active: mouseArea.containsMouse || root.activeFocus
                        Text{
                                anchors.top:inbox.bottom
                                anchors.leftMargin:5
                                text:"  Inbox"
                                color:"white"
                                font.pointSize:10
                        }

                        MouseArea {
                                id: mouseArea
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                hoverEnabled: true
                                onClicked:{
                                        viewInbox.visible=true
                                        viewCal.visible=false
                                        viewCont.visible=false
                                        viewChat.visible=false
                                        viewMaps.visible=false
                                        viewMeet.visible=false
                                        viewNews.visible=false
                                }
                        }
                }

                IconItem {
                        id:calender
                        width: 48
                        height: 48
                        source: "view-calendar-month"
                        enabled:true
                        opacity:viewCal.visible ||  mouseAreaCal.containsMouse ? 1:.5
                        active: mouseAreaCal.containsMouse || root.activeFocus

                        Text{
                                anchors.top:calender.bottom
                                text:"Calendar"
                                color:"white"
                                font.pointSize:10
                        }

                        MouseArea {
                                id: mouseAreaCal
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                hoverEnabled: true
                                onClicked:{
                                        viewInbox.visible=false
                                        viewCal.visible=true
                                        viewCont.visible=false
                                        viewChat.visible=false
                                        viewMaps.visible=false
                                        viewMeet.visible=false
                                        viewNews.visible=false
                                }
                        }
                }

                IconItem {
                        id:contacts
                        width: 48
                        height: 48
                        source: "view-pim-contacts"
                        enabled:true
                        opacity:viewCont.visible ||  mouseAreaContacts.containsMouse ? 1:.5
                        active: mouseAreaContacts.containsMouse || root.activeFocus

                        Text{
                                anchors.top:contacts.bottom
                                anchors.leftMargin:5
                                text:"Contacts"
                                color:"white"
                                font.pointSize:10
                        }

                        MouseArea {
                                id: mouseAreaContacts
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                hoverEnabled: true
                                onClicked:{
                                        viewInbox.visible=false
                                        viewCal.visible=false
                                        viewCont.visible=true
                                        viewChat.visible=false
                                        viewMaps.visible=false
                                        viewMeet.visible=false
                                        viewNews.visible=false
                                }
                        }
                }

                IconItem {
                        id:chat
                        width: 48
                        height: 48
                        source: "dialog-messages"
                        enabled:true
                        opacity:viewChat.visible ||  mouseAreaChat.containsMouse ? 1:.5
                        active: mouseAreaChat.containsMouse || root.activeFocus

                        Text{
                                anchors.top:chat.bottom
                                anchors.leftMargin:5
                                text:"  Chat"
                                color:"white"
                                font.pointSize:10
                        }

                        MouseArea {
                                id: mouseAreaChat
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                hoverEnabled: true
                                onClicked:{
                                        viewInbox.visible=false
                                        viewCal.visible=false
                                        viewCont.visible=false
                                        viewChat.visible=true
                                        viewMaps.visible=false
                                        viewMeet.visible=false
                                        viewNews.visible=false
                                }
                        }
                }

                  IconItem {
                        id:meet
                        width: 48
                        height: 48
                        source: "stock_video-conferencing"
                        enabled:true
                        opacity:viewMeet.visible ||  mouseAreaMeet.containsMouse ? 1:.5
                        active: mouseAreaMeet.containsMouse || root.activeFocus

                        Text{
                                anchors.top:meet.bottom
                                anchors.leftMargin:5
                                text:"  Meet"
                                color:"white"
                                font.pointSize:10
                        }

                        MouseArea {
                                id: mouseAreaMeet
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                hoverEnabled: true
                                onClicked:{
                                        viewInbox.visible=false
                                        viewCal.visible=false
                                        viewCont.visible=false
                                        viewChat.visible=false
                                        viewMaps.visible=false
                                        viewMeet.visible=true
                                        viewNews.visible=false
                                }
                        }
                }

                IconItem {
                        id:maps
                        width: 48
                        height: 48
                        source: "map-globe"
                        enabled:true
                        opacity:viewMaps.visible ||  mouseAreaMaps.containsMouse ? 1:.5
                        active: mouseAreaMaps.containsMouse || root.activeFocus

                        Text{
                                anchors.top:maps.bottom
                                anchors.leftMargin:5
                                text:"  Maps"
                                color:"white"
                                font.pointSize:10
                        }

                        MouseArea {
                                id: mouseAreaMaps
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                hoverEnabled: true
                                onClicked:{
                                        viewInbox.visible=false
                                        viewCal.visible=false
                                        viewCont.visible=false
                                        viewChat.visible=false
                                        viewMaps.visible=true
                                        viewMeet.visible=false
                                        viewNews.visible=false
                                }
                        }
                }

        IconItem {
                        id:news
                        width: 48
                        height: 48
                        source: "view-pim-news"
                        enabled:true
                       opacity:viewNews.visible ||  mouseAreaNews.containsMouse ? 1:.5
                       active: mouseAreaNews.containsMouse || root.activeFocus


                        Text{
                                anchors.top:news.bottom
                                anchors.leftMargin:5
                                text:"  News"
                                color:"white"
                                font.pointSize:10
                        }

                        MouseArea {
                                id: mouseAreaNews
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                hoverEnabled: true
                                onClicked:{
                                        viewInbox.visible=false
                                        viewCal.visible=false
                                        viewCont.visible=false
                                        viewChat.visible=false
                                        viewMaps.visible=false
                                        viewMeet.visible=false
                                        viewNews.visible=true
                                }
                        }
                }
        }

        Item {
                id:viewGmail
                anchors.left:navbar.right
                anchors.leftMargin:20
                height:root.height
                width:root.width

                Item {
                        id:viewInbox
                        anchors.left:navbar.right
                        anchors.leftMargin:20
                        height:root.height
                        width:root.width
                        visible:true

                       WebEngineView {
                                id:web
                                anchors.fill:viewInbox
                                url: "https://mail.google.com/mail/u/0/#inbox"
                                onNewViewRequested: {
                                       if (request.userInitiated) {
                                                request.action = WebEngineView.IgnoreRequest;
                                                Qt.openUrlExternally(request.requestedUrl);
                                        }
                                }
                        }
                }

                Item {
                        id:viewCal
                        anchors.left:navbar.right
                        anchors.leftMargin:20
                        height:root.height
                        width:root.width
                        visible:false

                        WebEngineView {
                                id:web1
                                anchors.fill:viewCal
                                url: "https://calendar.google.com/calendar/u/0/r"
                        }
                }

                Item {
                        id:viewCont
                        anchors.left:navbar.right
                        anchors.leftMargin:20
                        height:root.height
                        width:root.width
                        visible:false

                        WebEngineView {
                                id:web2
                                anchors.fill:viewCont
                                url: "https://contacts.google.com/?hl=en#contacts"
                        }
                }

                Item {
                        id:viewChat
                        anchors.left:navbar.right
                        anchors.leftMargin:20
                        height:root.height
                        width:root.width
                        visible:false

                        WebEngineView {
                                id:web3
                                anchors.fill:viewChat
                                url:"https://mail.google.com/chat/u/0/?hl=en#chat/welcome"
                        }
                }

                Item {
                        id:viewMaps
                        anchors.left:navbar.right
                        anchors.leftMargin:20
                        height:root.height
                        width:root.width
                        visible:false

                        WebEngineView {
                                id:web4
                                anchors.fill:viewMaps
                                url:"https://www.google.com/maps/"
                        }
                }

                Item {
                        id:viewMeet
                        anchors.left:navbar.right
                        anchors.leftMargin:20
                        height:root.height
                        width:root.width
                        visible:false

                         WebEngineView {
                                id:web5
                                anchors.fill:viewMeet
                                url:"https://meet.google.com/"
                        }
                }

                Item {
                        id:viewNews
                        anchors.left:navbar.right
                        anchors.leftMargin:20
                        height:root.height
                        width:root.width
                        visible:false

                        WebEngineView {
                                id:web6
                                anchors.fill:viewNews
                                url:"https://news.google.com/topstories/"
                        }
                }

        }
}
