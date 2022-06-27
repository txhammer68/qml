import os
import sys

from PyQt5.QtCore import QUrl
from PyQt5.QtGui import QIcon
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtWebEngineWidgets import QWebEngineView


CURRENT_DIR = os.path.dirname(os.path.realpath(__file__))

if __name__ == "__main__":
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.load(QUrl.fromLocalFile(os.path.join(CURRENT_DIR, "facebook.qml")))
    app.setWindowIcon(QIcon(os.path.join(CURRENT_DIR, "facebook.png")))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
