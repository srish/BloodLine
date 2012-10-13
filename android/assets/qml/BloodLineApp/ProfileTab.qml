import QtQuick 1.0

ItemStack {
    id: profileTab

    Component.onCompleted: {
        // Create the very first item in the item stack
        var profilePageComponent = Qt.createComponent("ProfileForm.qml");
        var profilePage = profilePageComponent.createObject(profileTab)

        profilePage.bloodCompatibilityChartRequested.connect(showBloodChart)
        profileTab.push(profilePage)
    }

    function showBloodChart()
    {
        var bloodChartComponent = Qt.createComponent("BloodChart.qml");
        var bloodChartPage = bloodChartComponent.createObject(profileTab);
        profileTab.push(bloodChartPage)
    }
}
