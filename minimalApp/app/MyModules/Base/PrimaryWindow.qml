import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import Theme

ApplicationWindow {
  title: qsTr("Awesome App")
  width: 1920
  height: 1080
  visible: true

  Rectangle {
    anchors.fill: parent
    color: Theme.accent
  }
}
