// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Imagine
import QtQuick.Window
import QtCharts

ApplicationWindow {
    id: window
    width: 1280
    height: 720
    minimumWidth: 1180
    minimumHeight: 663
    visible: true
    title: "Qt Quick Controls - Imagine Style Example: Automotive"

    readonly property color colorGlow: "#1ddd14"
    readonly property color colorWarning: "#d5232f"
    readonly property color colorMain: "#6aff6a"
    readonly property color colorBright: "#ffffff"
    readonly property color colorLightGrey: "#888"
    readonly property color colorDarkGrey: "#333"

    readonly property int fontSizeExtraSmall: Qt.application.font.pixelSize * 0.8
    readonly property int fontSizeMedium: Qt.application.font.pixelSize * 1.5
    readonly property int fontSizeLarge: Qt.application.font.pixelSize * 2
    readonly property int fontSizeExtraLarge: Qt.application.font.pixelSize * 5

    Component.onCompleted: {
        x = Screen.width / 2 - width / 2
        y = Screen.height / 2 - height / 2
    }

    Shortcut {
        sequence: "Ctrl+Q"
        onActivated: Qt.quit()
    }

    Frame {
        id: frame
        anchors.fill: parent
        anchors.margins: 90

        RowLayout {
            id: mainRowLayout
            anchors.fill: parent
            anchors.margins: 24
            spacing: 36

            ScrollView {

                Layout.fillHeight: true


                Container {
                    id: leftTabBar

                    currentIndex: 1

                    Layout.fillWidth: false
                    Layout.fillHeight: true

                    ButtonGroup {
                        buttons: columnLayout.children
                    }

                    contentItem: ColumnLayout {
                        id: columnLayout
                        spacing: 3

                        Repeater {
                            model: leftTabBar.contentModel
                        }
                    }

                    FeatureButton {
                        id: navigationFeatureButton
                        text: qsTr("Dashboard")
                        icon.name: "dashboard"
                        Layout.fillHeight: true

                        checked: true
                    }

                    FeatureButton {
                        text: qsTr("Statistics")
                        icon.name: "statistics"
                        Layout.fillHeight: true
                    }

                    FeatureButton {
                        text: qsTr("Security")
                        icon.name: "security"
                        Layout.fillHeight: true
                    }

                    FeatureButton {
                        text: qsTr("Settings")
                        icon.name: "settings"
                        Layout.fillHeight: true
                    }
                }
            }

            StackLayout {
                currentIndex: leftTabBar.currentIndex

                Layout.preferredWidth: 150
                Layout.maximumWidth: 150
                Layout.fillWidth: false

                Item {}

                ColumnLayout {
                    spacing: 16

                    LargeLabel {
                        text: qsTr("AIR CON (°C)")
                        color: "white"
                        font.pixelSize: fontSizeMedium
                    }

                    Dial {
                        id: volumeDial
                        from: 15
                        value: 21
                        to: 28
                        stepSize: 0.5

                        Layout.alignment: Qt.AlignHCenter
                        Layout.minimumWidth: 64
                        Layout.minimumHeight: 64
                        Layout.preferredWidth: 128
                        Layout.preferredHeight: 128
                        Layout.maximumWidth: 128
                        Layout.maximumHeight: 128
                        Layout.fillHeight: true

                        Label {
                            text: (Math.round(volumeDial.value*2)/2).toFixed(1)
                            color: "white"
                            font.pixelSize: Qt.application.font.pixelSize * 2.5
                            anchors.centerIn: parent
                        }
                    }


                    ButtonGroup {
                        id: audioSourceButtonGroup
                    }

                    RowLayout {
                        Layout.topMargin: 16

                        LargeLabel {
                            id: current
                            text: qsTr("STATISTICS")
                            color: "white"
                            font.pixelSize: fontSizeMedium
                            horizontalAlignment: Label.AlignLeft

                            Layout.fillWidth: true
                        }
                    }

                    Frame {
                        id: currentFrame
                        leftPadding: 1
                        rightPadding: 1
                        topPadding: 1
                        bottomPadding: 1

                        Layout.fillWidth: true
                        Layout.preferredHeight: 128

                        ListView {
                            id: stationListView
                            clip: true
                            anchors.fill: parent

                            ScrollIndicator.vertical: ScrollIndicator {
                                parent: currentFrame
                                anchors.top: parent.top
                                anchors.right: parent.right
                                anchors.rightMargin: 1
                                anchors.bottom: parent.bottom
                            }

                            model: ListModel {
                                ListElement { name: "Temperature"; value: "21 °C" }
                                ListElement { name: "Humidity"; value: "60%" }
                                ListElement { name: "Air Pressure"; value: "1013 hPa" }
                                ListElement { name: "Brightness"; value: "320 lux" }
                                ListElement { name: "Power Usage"; value: "30 kW" }
                            }
                            delegate: ItemDelegate {
                                id: stationDelegate
                                width: stationListView.width
                                height: 22
                                text: model.name
                                font.pixelSize: fontSizeExtraSmall
                                topPadding: 0
                                bottomPadding: 0

                                contentItem: RowLayout {
                                    Label {
                                        text: model.name
                                        font: stationDelegate.font
                                        horizontalAlignment: Text.AlignLeft
                                        Layout.fillWidth: true
                                    }
                                    Label {
                                        text: model.value
                                        font: stationDelegate.font
                                        horizontalAlignment: Text.AlignRight
                                        Layout.fillWidth: true
                                    }
                                }
                            }
                        }
                    }

                    //                    Frame {
                    //                        Layout.fillWidth: true

                    //                        RowLayout {
                    //                            anchors.fill: parent

                    //                            Label {
                    //                                text: qsTr("Sort by")
                    //                                font.pixelSize: fontSizeExtraSmall

                    //                                Layout.alignment: Qt.AlignTop
                    //                            }

                    //                            ColumnLayout {
                    //                                RadioButton {
                    //                                    text: qsTr("Name")
                    //                                    font.pixelSize: fontSizeExtraSmall
                    //                                }
                    //                                RadioButton {
                    //                                    text: qsTr("Frequency")
                    //                                    font.pixelSize: fontSizeExtraSmall
                    //                                }
                    //                                RadioButton {
                    //                                    text: qsTr("Favourites")
                    //                                    font.pixelSize: fontSizeExtraSmall
                    //                                    checked: true
                    //                                }
                    //                            }
                    //                        }
                    //                    }
                }
            }

            Rectangle {
                color: colorMain
                implicitWidth: 1
                Layout.fillHeight: true
            }

            ColumnLayout {
                Layout.preferredWidth: 850
                Layout.fillWidth: true
                Layout.fillHeight: true

                LargeLabel {
                    id: sectionLabel
                    text: qsTr("Dashboard")
                    font.pixelSize: fontSizeLarge

                    Layout.alignment: Qt.AlignLeft
                }


                Rectangle {
                    Layout.fillHeight: true

                    Column {
                        x: parent.width * 0.88
                        y: parent.height * 0.56

                        //                    ChartView {
                        //                        antialiasing: true

                        //                        PieSeries {
                        //                            id: pieSeries
                        //                            PieSlice { label: "eaten"; value: 94.9 }
                        //                            PieSlice { label: "not yet eaten"; value: 5.1 }
                        //                        }
                        //                    }
                    }
                }
            }

            Rectangle {
                color: colorMain
                implicitWidth: 1
                Layout.fillHeight: true
            }

            ColumnLayout {
                Layout.minimumWidth: 225

                Row {
                    spacing: 8

                    Column {
                        spacing: 8

                        Layout.topMargin: 10

                        LargeLabel {
                            id: timeLabel
                            text: qsTr("11:02")
                            font.pixelSize: fontSizeLarge

                            horizontalAlignment: Qt.AlignRight

                            LargeLabel {
                                text: qsTr("AM")
                                font.pixelSize: fontSizeLarge
                                anchors.left: parent.right
                                anchors.leftMargin: 8
                            }
                        }

                        Label {
                            text: qsTr("01/01/2018")
                            color: colorLightGrey
                            font.pixelSize: fontSizeMedium

                            Layout.topMargin: 2
                            Layout.bottomMargin: 10

                            horizontalAlignment: Qt.AlignRight
                        }

                        Row {
                            spacing: 10

                            Image {
                                source: "qrc:/icons/weather.png"
                                Layout.preferredWidth: 20
                                Layout.preferredHeight: 20
                            }

                            Column {
                                Label {
                                    id: outsideTempValueLabel
                                    text: qsTr("31 °C")
                                    font.pixelSize: fontSizeMedium
                                    horizontalAlignment: Qt.AlignRight
                                }

                                Label {
                                    id: locationLabel
                                    text: qsTr("Rijeka")
                                    color: colorLightGrey
                                    font.pixelSize: fontSizeMedium
                                    horizontalAlignment: Qt.AlignRight
                                }
                            }

                        }
                    }
                }

                ColumnLayout {
                    id: airConRowLayout
                    spacing: 8

                    Layout.preferredWidth: 128
                    Layout.preferredHeight: 380
                    Layout.fillHeight: true

                    Item {
                        Layout.fillHeight: true
                    }

                    LargeLabel {
                        id: devices
                        text: qsTr("DEVICES")
                        color: "white"
                        font.pixelSize: fontSizeMedium
                        horizontalAlignment: Label.AlignLeft

                        Layout.fillWidth: true
                    }

                    // TODO get list of devices for room and fill scroll accordingly
                    // TODO equal spacing between device name and button for all

                    ScrollView {
                        Layout.fillHeight: true
                        leftPadding: 0
                        rightPadding: 0
                        topPadding: 0
                        bottomPadding: 0

                        Layout.fillWidth: true


                        //                        Container {
                        //                            id: devicesBar

                        //                            currentIndex: 1

                        //                            Layout.fillHeight: true


                        SwitchDelegate {
                            text: qsTr("AC")


                            checked: true
                            leftPadding: 0
                            rightPadding: 0
                            topPadding: 0
                            bottomPadding: 0

                            Layout.fillWidth: true
                        }

                        Item {
                            Layout.fillHeight: true
                        }
                    }
                }
            }

            ScrollView {

                Layout.fillHeight: true

                Container {
                    id: rightTabBar

                    currentIndex: 1

                    Layout.fillHeight: true

                    ButtonGroup {
                        buttons: rightTabBarContentLayout.children
                    }

                    contentItem: ColumnLayout {
                        id: rightTabBarContentLayout
                        spacing: 3

                        Repeater {
                            model: rightTabBar.contentModel
                        }
                    }

                    Item {
                        Layout.fillHeight: true
                    }

                    // TODO unclickable if not on dashboard

                    FeatureButton {
                        text: qsTr("Living Room")
                        icon.name: "living-room"

                        Layout.maximumHeight: navigationFeatureButton.height
                        Layout.fillHeight: true
                    }
                    FeatureButton {
                        text: qsTr("Bedroom 1")
                        icon.name: "bedroom1"
                        checked: true

                        Layout.maximumHeight: navigationFeatureButton.height
                        Layout.fillHeight: true
                    }
                    FeatureButton {
                        text: qsTr("Bedroom 2")
                        icon.name: "bedroom2"

                        Layout.maximumHeight: navigationFeatureButton.height
                        Layout.fillHeight: true
                    }
                    FeatureButton {
                        text: qsTr("Dining Room")
                        icon.name: "dining-room"

                        Layout.maximumHeight: navigationFeatureButton.height
                        Layout.fillHeight: true
                    }
                    FeatureButton {
                        text: qsTr("Bathroom")
                        icon.name: "bathroom"

                        Layout.maximumHeight: navigationFeatureButton.height
                        Layout.fillHeight: true
                    }
                    FeatureButton {
                        text: qsTr("Garage")
                        icon.name: "garage"

                        Layout.maximumHeight: navigationFeatureButton.height
                        Layout.fillHeight: true
                    }
                }
            }
        }
    }
}
