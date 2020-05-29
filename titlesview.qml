import QtQuick 2.7
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import "titleslistmodel.qml"

Component {
    Frame {
        id: viewTblframe
        x: 1
        y: 1
        width: 800
        height: 640
        implicitWidth: 800
        implicitHeight: 240
        visible: true

        ListView {
            implicitHeight: parent.height - 60
            implicitWidth:  parent.width - 12
            visible: true
            clip: true

            model: TitlesListModel

            delegate: RowLayout {
                width: parent.width

                TextField {
                    text: model.data(1,0)
                    onEditingFinished: model.idno = text
                }
                TextField {
                    text: model.data(1,1)
                    onEditingFinished: model.selected = text
                }
                TextField {
                    text: model.data(1,2)
                    onEditingFinished: model.title = text
                }
                TextField {
                    text: model.data(1,3)
                    onEditingFinished: model.author = text
                }
                TextField {
                    text: model.data(1,4)
                    onEditingFinished: model.media = text
                }
                TextField {
                    text: model.data(1,5)
                    onEditingFinished: model.notes = text
                    Layout.fillWidth: true
                }
            }
        }  // end list view
    } // end frame
}