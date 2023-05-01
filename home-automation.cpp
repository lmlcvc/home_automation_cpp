#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSettings>
#include <QQuickStyle>
#include <QIcon>

int main(int argc, char *argv[])
{
    QApplication::setApplicationName("Smart Home Central");

    QApplication app(argc, argv);

    QIcon::setThemeName("smarthome");

    QQmlApplicationEngine engine;
    engine.load(QUrl("qrc:/qml/HomeAutomation.qml"));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
