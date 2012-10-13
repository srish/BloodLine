// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    width: 400
    height: 600
    color: "white"

    Rectangle {
        id: textBox
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "white"
        width: parent.width
        height: parent.height * 0.7

        Flickable {
            anchors.fill: parent
            contentHeight: aboutUsText.implicitHeight
            contentWidth: width
            clip: true

            Text {
                id: aboutUsText
                anchors.fill: parent
                anchors.margins: 5
                font.pixelSize: 14
                wrapMode: Text.WordWrap
                height: textBox.height
                clip: true
                text: "Punch Line :-  Be a Blood Donor. All it costs is little love. \n\n Description :- Bloodline is a social awareness application which connects donors/recepients socially via their Facebook profile to donate or receive blood in urgency. All that user requires is to login with his/her facebook account and further fix a personal appointment to donate/receive blood at the nearest blood bank center or a hospital.\n\n With specified feature namely CREDIT SYSTEM, donors can get benefits in different forms such as fair health concern deals, low cost doctor appointments etc once they donate blood. Users will get daily health awareness notifications about  upcoming blood donation camp or a particular blood group requirement. \n"
            }
        }
    }

    Component.onCompleted: menuList.title = "About Us"
    Component.onDestruction: menuList.title = "Settings"
}
