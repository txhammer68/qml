<img align="bottom" src="https://tipsonubuntu.com/wp-content/uploads/2016/10/kde-logo-400x218.jpg" width="72"> [Plasma Docs](https://develop.kde.org/docs/plasma/widget/plasma-qml-api/)
[<img src="http://www.google.com.au/images/nav_logo7.png">](foo)
 ## QML Formatting
### Spacing
```qml
  Units.smallSpacing
  Units.mediumSpacing
  Units.largelSpacing

  implicitHeight:120  // can change dynamically
  implicitWidth:120

  preferredWidth:120
  preferredHeight:120
```
### Anchors
```qml
  anchors.top:parent.bottom
  anchors.bottom: parent.bottom
  anchors.fill:parent
  anchors.centerIn: root
  anchors.left: parent.left
  anchors.right: parent.right
  anchors.topMargin: units.smallSpacing
  anchors.bottomMargin: units.smallSpacing
  anchors.leftMargin: Units.mediumSpacing
  anchors.rightMargin:units.smallSpacing
  anchors.horizontalCenter:id.horizontalCenter
  anchors.verticalCenter:id.verticalCenter
```
### Layouts use in RowLayout,ColumnLayout,GridLayout
```qml
Layout.fillWidth: true // use with width for uniform spacing
Layout.fillHeight: true
horizontalAlignment : Text.AlignLeft (Default)
                      Text.AlignRight
                      Text.AlignHCenter

verticalAlignment   : Text.AlignTop
                      Text.AlignTop
                      Text.AlignBottom
                      Text.AlignVCenter (Default)

Layout.alignment: Qt.AlignLeft // Qt.AlignRight // Qt.AlignVCenter // Qt.AlignHCenter
```
### Fonts
```qml
  font.family:config.displayFont // default theme font
  font.family:theme.displayFont // default theme font
  font.family:Noto Sans
  font.weight: Font.Black
  font.pointSize:12
  antialiasing : true
  font.bold:true
  font.italic:true
  textFormat: Text.RichText // use for inline html //Text.AutoText//Text.PlainText//Text.MarkdownText
  wrapMode:Text.WordWrap
  font.capitalization: Font.Capitalize  // capital first letter of text string
```
### Colors
```qml
  color: Theme.textColor  // default theme color
  color: Theme.viewTextColor
  color: config.textColor // user selected
  Theme.highlightColor
  Theme.highlightedTextColor
  Theme.backgroundColor
  Theme.buttonHoverColor
  Theme.viewHoverColor
  color: transparent
  color: ColorScope.textColor
```
### QML Theme Options
```qml
  Theme.viewTextColor
  Theme.textColor
  Theme.highlightColor
  Theme.highlightedTextColor
  Theme.backgroundColor
  Theme.linkColor
  Theme.visitedLinkColor
  Theme.positiveTextColor
  Theme.neutralTextColor
  Theme.negativeTextColor
  Theme.disabledTextColor
  Theme.complementaryTextColor
  Theme.viewTextColor
  Theme.headerTextColor
  Theme.buttonTextColor
```
