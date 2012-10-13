import QtQuick 1.0

Rectangle {
    width: 400
    height: 600

    property int serialnum : 0;
    color: "white"

    ListModel {
        id: listModel
    }

    ListView {
        id: listView
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: parent.height

        clip: true
        model: listModel

        delegate : Rectangle{
            id: rectangleElement
            width: parent.width
            height: 80
            border.color: "white"
            border.width: 1

            signal buttonClicked()

            gradient: Gradient {
                GradientStop { position: 0; color: "#E3E8E4"; }
                GradientStop { position: 0.35; color: "#E0E0E1"; }
                GradientStop { position: 1; color: "#D5D7D5"; }
            }


            Text {
                id: name
                text: hospitalName
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 5
                font.bold: true
                font.pixelSize: 12
                color: "black"
            }

            Text {
                id: ad
                text: address
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.top: name.bottom
                anchors.topMargin: 10
                wrapMode: Text.WordWrap
                font.bold: true
                font.pixelSize: 10
                color: "black"
            }

            Text {
                id: contactNo
                text: contactNumber
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.top: ad.bottom
                anchors.topMargin: 10
                wrapMode: Text.WordWrap
                font.bold: true
                font.pixelSize: 8
                color: "black"
            }
        }
    }

    Component.onCompleted: {

        listModel.append({hospitalName: "Indraprastha Apollo Hospital",
                         address: "Delhi Mathura Road, Sarita Vihar, Mathura Road , Delhi",
                         contactNumber: "011 - 26925888, 41676767, 26925858, 26925801" })


        listModel.append({hospitalName: "I O H Path Lab & Blood Bank Org",
                         address: "36, Vikas Marg, Vijay Block, Lakshmi Nagar, Delhi-110092 , Delhi",
                         contactNumber: "011 - 22546228, 22509456" })


        listModel.append({hospitalName: "National Heart Institute",
                         address: "3, Konark Apartment, Pocket - A - 4, Kalkaji 110019 , Delhi",
                         contactNumber: "0011 - 26093068" })


        listModel.append({hospitalName: "Sanjay Gandhi Memorial Hospital",
                         address: "Sanjay Gandhi Memorial Hospital",
                         contactNumber: "011 – 27914171" })

        listModel.append({hospitalName: " All India Institute of Medical Sciences ",
                         address: "New Delhi",
                         contactNumber: "011 - 22000000" })

        listModel.append({hospitalName: "Indarprastha Apollo Hospital",
                         address: "Delhi Mathura Road, Sarita Vihar, Mathura Road , Delhi",
                         contactNumber: "011 - 26925888, 41676767, 26925858, 26925801" })


        listModel.append({hospitalName: "Indarprastha Apollo Hospital",
                         address: "Delhi Mathura Road, Sarita Vihar, Mathura Road , Delhi",
                         contactNumber: "011 - 26925888, 41676767, 26925858, 26925801" })

        listModel.append({hospitalName: "Indarprastha Apollo Hospital",
                         address: "Delhi Mathura Road, Sarita Vihar, Mathura Road , Delhi",
                         contactNumber: "011 - 26925888, 41676767, 26925858, 26925801" })



    }
}

