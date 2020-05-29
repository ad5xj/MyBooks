import QtQuick 2.7
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtQuick.LocalStorage 2.12

import "sqliteproxy.js" as JS

ApplicationWindow {
    id: mainwindow
    visible: true
    width: 1024
    height: 650
    title: qsTr("MyBooks Media Library")
    property color backGroundColor : "#394454"
    property color mainAppColor: "#6fda9c" //"#FA6B65"
    property color mainTextCOlor: "#f0f0f0"
    property var dataBase

    // After loading show initial Login Page
    Component.onCompleted: {
        dataBase = JS.initDB()
        var component = Qt.createComponent("titlesview.qml")
        var window    = component.createObject(mainwindow)
        window.show()
    }

    header: ToolBar {
        id: mainMenuBar
        width: parent.width
        height: 47
        font.pointSize: 11

        RowLayout {
            anchors.fill: parent
            ToolButton {
                id: actionExit
                width: 45
                height: 45
                display: AbstractButton.IconOnly


                padding: 0
                leftPadding: 1
                rightPadding: 0
                bottomPadding: 1
                topPadding: 1
                icon.source: "images/process-stop.png"
                icon.width: 42
                icon.height: 42
                Layout.fillHeight: false
                Layout.fillWidth: false

                ToolTip.text: qsTr("Exit MyBooks")
                ToolTip.visible: hovered


                onClicked: Qt.quit()
            }
            ToolSeparator {
                padding: vertical ? 10 : 2
                topPadding: vertical ? 2 : 10
                bottomPadding: vertical ? 2 : 10

                contentItem: Rectangle {
                    implicitWidth: parent.vertical ? 1 : 24
                    implicitHeight: parent.vertical ? 24 : 1
                    color: "#c3c3c3"
                }
            }
            ToolButton {
                id: actionEditAuthors
                width: 45
                height: 45
                display: AbstractButton.IconOnly

                padding: 0
                leftPadding: 1
                rightPadding: 0
                bottomPadding: 1
                topPadding: 1
                icon.source: "images/edit-authors.png"
                icon.width: 42
                icon.height: 42
                Layout.fillHeight: false
                Layout.fillWidth: false

                ToolTip.text: qsTr("Edit Authors")
                ToolTip.visible: hovered
            }
            ToolButton {
                id: actionEditTitles
                width: 45
                height: 45

                padding: 0
                leftPadding: 1
                rightPadding: 0
                bottomPadding: 1
                topPadding: 1
                icon.source: "images/edit-titles.png"
                icon.width: 42
                icon.height: 42
                Layout.fillHeight: false
                Layout.fillWidth: false

                ToolTip.text: qsTr("Edit Titles")
                ToolTip.visible: hovered
            }

            ToolSeparator {
                padding: vertical ? 10 : 2
                topPadding: vertical ? 2 : 10
                bottomPadding: vertical ? 2 : 10

                contentItem: Rectangle {
                    implicitWidth: parent.vertical ? 1 : 24
                    implicitHeight: parent.vertical ? 24 : 1
                    color: "#c3c3c3"
                }
            }
            ToolButton {
                id: actionHelp
                width: 45
                height: 45
                display: AbstractButton.IconOnly

                padding: 0
                leftPadding: 1
                rightPadding: 0
                bottomPadding: 1
                topPadding: 1
                icon.source: "images/help-contents.png"
                icon.width: 42
                icon.height: 42
                Layout.fillHeight: false
                Layout.fillWidth: false

                ToolTip.text: qsTr("Help Contents")
                ToolTip.visible: hovered

                onClicked: Qt.openUrlExternally("https://qso.com/qLogger/index.html")
            }
            Rectangle {
                id: dummy
                height: 45
                width: parent.fillWidth

                implicitWidth: 390
                antialiasing: true
                enabled: false

                Image {
                    id: imgBlank
                    width: 648
                    height: 45
                    scale: 1
                    source: "images/blank.png"
                }
            }
        }
    }

    Image {
        id: imgOwl
        x: 27
        y: 20
        width: 100
        height: 88
        fillMode: Image.PreserveAspectFit
        source: "images/Bookowl.png"
    }

    Image {
        id: imgShelf
        x: 32
        y: 135
        width: 255
        height: 183
        fillMode: Image.Stretch
        source: "images/Bookshelf.png"
    }

    Rectangle {
        id: btnBooks
        x: 170
        y: 40
        width: 91
        height: 60
        border.color: "#999999"
        border.width: 1
        radius: 6
        gradient: Gradient {
            GradientStop { position: 0.0; color: "lightgray" }
            GradientStop { position: 1.0; color: "gray" }
        }

        Text {
            id: lblButton
            x: 9
            y: 23
            text: qsTr("View / Search")
            font.bold: false
            font.family: "DejaVu Sans"
            font.pixelSize: 11
        }

        MouseArea {
            id: btnBooksClickArea
            x: 1
            y: 2
            width: 88
            height: 57
            hoverEnabled: false
            visible: true
            acceptedButtons: Qt.LeftButton

            onClicked: {
            }
        }
    }

}
