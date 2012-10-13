import QtQuick 1.0

Rectangle {
    width: 400
    height: 600

    color: "white"

    signal listOfCities()
    signal aboutUsPage()

    Column {
        id: column
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: parent.width
        height: parent.height

        ProfilePageElement{
            infoTabName: "Alarm"
            width: parent.width
            height: 60
        }

        ProfilePageElement {
            infoTabName: "About Us"
            width: parent.width
            height: 60
            onButtonClicked: aboutUsPage()
        }

        ProfilePageElement {
            infoTabName: "List of Blood Blanks"
            width: parent.width
            height: 60
            onButtonClicked: listOfCities()
        }

        ProfilePageElement {
            infoTabName: "Nearby Hospitals"
            width: parent.width
            height: 60
        }
    }
}
