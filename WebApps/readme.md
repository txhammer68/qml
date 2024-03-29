## Python Qt Apps
Use python to create webapps for your favorite websites, Netflix, Facebook, Instagram, G-mail, etc...
The qml webengine view isolates the web site from your normal web browswer, so cookies, trackers are not in your default web profile.
Create QML apps with python front end, such as weather,news,sports.
Each app has its own profile and security settings, stored in ~/.local/share/WebAppName

    * Qt Apps
        * Weather
        * G-Mail
    * Web Apps
        * Netflix
        * Facebook
## Requirements
   * python-pyqt5
   * python-pyqt5-webengine
  
### Sample python code for web app/ companion qml code for webview

```python
import os
import sys

from PyQt5.QtCore import QUrl
from PyQt5.QtGui import QIcon
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine
# from PyQt5.QtWebEngineWidgets import QWebEnginePage
from PyQt5.QtWebEngineWidgets import QWebEngineView


CURRENT_DIR = os.path.dirname(os.path.realpath(__file__))

if __name__ == "__main__":
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.load(QUrl.fromLocalFile(os.path.join(CURRENT_DIR, "netflix.qml")))
    app.setWindowIcon(QIcon(os.path.join(CURRENT_DIR, "netflix.png")))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
```
### QML code for webview

```qml
import QtQuick 2.8
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.5
import org.kde.plasma.core 2.0
import QtWebEngine 1.5
import QtQuick.Window 2.15



ApplicationWindow {
        id:root
        visible: true
        width: Screen.width*.90
        height: Screen.height*.90
        title: "Netflix"
        color : Theme.backgroundColor


        WebEngineView {
                        id:webNetflix
                         anchors.fill:parent
                         url: "https://www.netflix.com/"
                          onNewViewRequested: {
                             if (request.userInitiated) {
                              request.action = WebEngineView.IgnoreRequest;
                              Qt.openUrlExternally(request.requestedUrl);
                            }
                        }
                }
}
```
