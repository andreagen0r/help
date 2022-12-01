import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import Theme

ApplicationWindow {
  title: qsTr("Secondary")
  width: 1920
  height: 1080
  visible: true

  Rectangle {
    anchors.fill: parent
    color: Theme.primary_02
  }
}
