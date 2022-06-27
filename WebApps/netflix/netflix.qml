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
