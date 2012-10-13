import QtQuick 1.0

Rectangle {
    width: 400
    height: 600

    color: "white"

    signal listOfBangalore()
    signal listOfDelhi()

    Column {
        id: column
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: parent.width
        height: parent.height

        ProfilePageElement {
            infoTabName: "Ahemdabad"
            width: parent.width
            height: 50
        }

        ProfilePageElement {
            infoTabName: "Bangalore"
            width: parent.width
            height: 50
            onButtonClicked: listOfBangalore()
        }

        ProfilePageElement {
            infoTabName: "Chennai"
            width: parent.width
            height: 50
        }

        ProfilePageElement {
            infoTabName: "Kolkata"
            width: parent.width
            height: 50
        }

        ProfilePageElement {
            infoTabName: "Hyderabad"
            width: parent.width
            height: 50
        }

        ProfilePageElement{
            infoTabName: "New Delhi(NCR)"
            width: parent.width
            height: 50
            onButtonClicked: listOfDelhi()
        }


        ProfilePageElement {
            infoTabName: "Mumbai"
            width: parent.width
            height: 50
        }

        ProfilePageElement {
            infoTabName: "Patna"
            width: parent.width
            height: 50
        }

        ProfilePageElement {
            infoTabName: "Pune"
            width: parent.width
            height: 50
        }
    }
}
