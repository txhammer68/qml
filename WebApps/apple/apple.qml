import QtQuick 2.8
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.5
import org.kde.plasma.core 2.0
import QtWebEngine 1.5
import QtQuick.Window 2.15

// apple tv web app


ApplicationWindow {
        id:root
        visible: true
        width: Screen.width*.90
        height: Screen.height*.90
        title: "Apple TV"
        color :Theme.backgroundColor


        WebEngineView {
                        id:apple
                         anchors.fill:parent
                         url: "https://tv.apple.com/"
                          onNewViewRequested: {
                             if (request.userInitiated) {
                              request.action = WebEngineView.IgnoreRequest;
                              Qt.openUrlExternally(request.requestedUrl);
                            }
                        }
                }
}
