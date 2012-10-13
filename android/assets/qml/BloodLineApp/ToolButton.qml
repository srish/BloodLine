import QtQuick 1.0

Rectangle {
    id: toolButton
    width: 60
    height: 60
    radius: 5
    clip: false
    color: Qt.rgba(0, 0, 0, 0)

    property string checkedIcon: ""
    property string uncheckedIcon: ""

    signal checked()

    Image {
        id: toolButtonIcon
        width: 45
        height: 45
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        asynchronous: false
        smooth: true
        source: checkedIcon
        //source: parent.state == "checked" ? checkedIcon : uncheckedIcon
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            parent.state = "checked";
            parent.checked();
        }
    }

    state: "unchecked"
}
