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
            infoTabName: "Donate Blood"
            width: parent.width
            height: 60
        }

        ProfilePageElement {
            infoTabName: "Fetch Blood"
            width: parent.width
            height: 60
            onButtonClicked: aboutUsPage()
        }

        ProfilePageElement {
            infoTabName: "Your Credits(only for donors)"
            width: parent.width
            height: 60
            onButtonClicked: listOfCities()
        }

        ProfilePageElement {
            infoTabName: "Invite Friends"
            width: parent.width
            height: 60
        }
    }
}
