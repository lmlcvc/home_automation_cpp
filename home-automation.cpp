#include "serialportcommunication.h"

#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSettings>
#include <QQuickStyle>
#include <QIcon>
#include <QSerialPort>

int main(int argc, char *argv[])
{
    QApplication::setApplicationName("Smart Home Central");

    QApplication app(argc, argv);

    QIcon::setThemeName("smarthome");

    QString portName = "COM2";      // could also be passed in argument list
    QSerialPort serialPort;
    SerialPortCommunication serialPortCommunication;
    serialPortCommunication.performConnection(portName, 4800);

    QQmlApplicationEngine engine;
    engine.load(QUrl("qrc:/qml/HomeAutomation.qml"));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
