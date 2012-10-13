// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.0

Image {
    id: loading; source: "qrc:///Images/loading.png"
    NumberAnimation on rotation {
        from: 0; to: 360; running: loading.visible == true; loops: Animation.Infinite; duration: 900
    }
}
