import QtQuick 1.0

GradientBar {
    id: toolBar
    width: parent.width
    height: 62

    property string currentStateTitle: ""
    property int oldWidth: parent.width

    Row {
        id: toolBarRow
        spacing: ((toolBar.width/4)-45)/2
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 20
        anchors.rightMargin: 20

        ToolButton {
            id: cmdProfile
            checkedIcon: "qrc:///Images/Profile.png"
            //uncheckedIcon: "qrc:///Images/btn_categories.png"
            onChecked: toolBar.state = "Profile"
        }

        ToolButton {
            id: cmdNotifications
            checkedIcon: "qrc:///Images/Notifications.png"
            //uncheckedIcon: "qrc:///Images/btn_favourites.png"
            onChecked: toolBar.state = "Notifications"
        }

        ToolButton {
            id: cmdCredits
            checkedIcon: "qrc:///Images/Credits.png"
            //uncheckedIcon: "qrc:///Images/btn_settings.png"
            onChecked: toolBar.state = "Credits"
        }

        ToolButton {
            id: cmdSettings
            checkedIcon: "qrc:///Images/Settings.png"
            //uncheckedIcon: "qrc:///Images/btn_myaccounts.png"
            onChecked: toolBar.state = "Settings"
        }
    }

    state: "Profile"

    states: [
        State {
            name: "Profile"
            PropertyChanges { target: cmdProfile; state: "checked" }
            PropertyChanges { target: cmdNotifications; state: "unchecked" }
            PropertyChanges { target: cmdCredits; state: "unchecked" }
            PropertyChanges { target: cmdSettings; state: "unchecked" }
            PropertyChanges { target: toolBar; currentStateTitle: "Profile" }
        },
        State {
            name: "Notifications"
            PropertyChanges { target: cmdProfile; state: "unchecked" }
            PropertyChanges { target: cmdNotifications; state: "checked" }
            PropertyChanges { target: cmdCredits; state: "unchecked" }
            PropertyChanges { target: cmdSettings; state: "unchecked" }
            PropertyChanges { target: toolBar; currentStateTitle: "Notifications" }
        },
        State {
            name: "Credits"
            PropertyChanges { target: cmdProfile; state: "unchecked" }
            PropertyChanges { target: cmdNotifications; state: "unchecked" }
            PropertyChanges { target: cmdCredits; state: "checked" }
            PropertyChanges { target: cmdSettings; state: "unchecked" }
            PropertyChanges { target: toolBar; currentStateTitle: "Credits" }
        },
        State {
            name: "Settings"
            PropertyChanges { target: cmdProfile; state: "unchecked" }
            PropertyChanges { target: cmdNotifications; state: "unchecked" }
            PropertyChanges { target: cmdCredits; state: "unchecked" }
            PropertyChanges { target: cmdSettings; state: "checked" }
            PropertyChanges { target: toolBar; currentStateTitle: "Settings" }
        }
    ]

    onWidthChanged: {
        if((oldWidth > 0) && (toolBar.width > oldWidth))
            toolBarRow.spacing = ((toolBar.width/4)-45);
        else
            toolBarRow.spacing = ((toolBar.width/4)-45)/2;

        oldWidth = toolBar.width
    }
}
