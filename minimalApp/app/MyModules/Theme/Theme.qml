pragma Singleton

import QtQuick

QtObject {
    // Theme state
    property bool darkMode: true
    property color accent: darkMode ? primary_01 : primary_02

    readonly property color primary_01: "#0000FF"
    readonly property color primary_02: "#FF0000"

    function makeTransparent( color : Color, alphaPercent : double ) {
        return Qt.rgba(color.r, color.g, color.b, alphaPercent);
    }
}
