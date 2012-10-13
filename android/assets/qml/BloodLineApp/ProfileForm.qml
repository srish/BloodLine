import QtQuick 1.0

Rectangle {
    width: 100
    height: 62
    color: "white"

    signal bloodCompatibilityChartRequested()

    Column {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 10
        spacing: 10

        Row {
            width: parent.width
            height: 20
            spacing: 20

            Text {
                text: "Full Name"
                color: "black"
                font.pixelSize: 12
                width: parent.width * (1 / 3)
                anchors.verticalCenter: parent.verticalCenter
            }

            InputField {
                id: fullName
                text: authorizer.facebookFullName
                width: parent.width * 0.6
                height: parent.height
            }
        }

        Row {
            width: parent.width
            height: 20
            spacing: 20

            Text {
                text: "DOB"
                width: parent.width * (1 / 3)
                font.pixelSize: 12
                anchors.verticalCenter: parent.verticalCenter
                color: "black"
            }

            InputField {
                id: dob
                text: authorizer.facebookDOB
                width: parent.width * 0.6
                height: parent.height
            }
        }

        Row {
            width: parent.width
            height: 20
            spacing: 20

            Text {
                text: "Marital Status"
                color: "black"
                font.pixelSize: 12
                width: parent.width * (1 / 3)
                anchors.verticalCenter: parent.verticalCenter
            }

            InputField {
                id: maritalStatus
                width: parent.width * 0.6
                height: parent.height
                text: authorizer.maritalStatus
            }
        }

        Row {
            width: parent.width
            height: 20
            spacing: 20

            Text {
                text: "Contact Number"
                color: "black"
                font.pixelSize: 12
                width: parent.width * (1 / 3)
                anchors.verticalCenter: parent.verticalCenter
            }

            InputField {
                id: contactNumber
                width: parent.width * 0.6
                height: parent.height
            }
        }

        Row {
            width: parent.width
            height: 20
            spacing: 20

            Text {
                text: "EMail (other than fb)"
                color: "black"
                font.pixelSize: 12
                width: parent.width * (1 / 3)
                anchors.verticalCenter: parent.verticalCenter
            }

            InputField {
                id: emailId
                width: parent.width * 0.6
                height: parent.height
                text: authorizer.emailId
            }
        }

        Row {
            width: parent.width
            height: 20
            spacing: 20

            Text {
                text: "Blood Group"
                color: "black"
                font.pixelSize: 12
                width: parent.width * (1 / 3)
                anchors.verticalCenter: parent.verticalCenter
            }

            InputField {
                id: bloodGroup
                width: parent.width * 0.6
                height: parent.height
                text: authorizer.currentLocation
            }
        }

        Row {
            width: parent.width
            height: 20
            spacing: 20

            Text {
                text: "Current Location"
                color: "black"
                font.pixelSize: 12
                width: parent.width * (1 / 3)
                anchors.verticalCenter: parent.verticalCenter
            }

            InputField {
                id: state
                width: parent.width * 0.6
                height: parent.height
            }
        }

        Row {
            width: parent.width
            height: 20
            spacing: 20

            Text {
                text: "Country"
                color: "black"
                font.pixelSize: 12
                width: parent.width * (1 / 3)
                anchors.verticalCenter: parent.verticalCenter
            }

            InputField {
                id: country
                width: parent.width * 0.6
                height: parent.height
                text: authorizer.country
            }
        }

        Row {
            width: parent.width
            height: 20
            spacing: 20

            Text {
                text: "Nearest Blood Zone"
                color: "black"
                font.pixelSize: 12
                width: parent.width * (1 / 3)
                anchors.verticalCenter: parent.verticalCenter
            }

            InputField {
                id: zone
                width: parent.width * 0.6
                height: parent.height
            }
        }
    }

    Row {
        id: row
        width: parent.width
        height: 30
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 2

        Button {
            id: bloodChartButton
            fontSize: 12
            buttonText: "Check Blood Compatibility"
            width: parent.width * 0.5
            height: 30
            radius: 5
            onButtonClicked: bloodCompatibilityChartRequested()
        }

        Button {
            id: addButton
            fontSize: 12
            buttonText: "Add Donor Details"
            width: parent.width * 0.5
            height: 30
            radius: 5
        }
    }

    Component.onCompleted: menuList.title = "Profile Form"
    Component.onDestruction: menuList.title = "Profile"
}

