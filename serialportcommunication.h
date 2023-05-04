#ifndef SERIALPORTCOMMUNICATION_H
#define SERIALPORTCOMMUNICATION_H

#include <QSerialPort>
#include <QByteArray>
#include <QTextStream>
#include <QTimer>

QT_BEGIN_NAMESPACE

QT_END_NAMESPACE

class SerialPortCommunication : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QSerialPort *serialPort READ serialPort NOTIFY readerEnabledChanged)
    Q_PROPERTY(bool readerEnabled READ readerEnabled WRITE setReaderEnabled NOTIFY readerEnabledChanged)


public:
    Q_INVOKABLE void invokePerformConnection(const QString portName, const qint32 baud) {
        SerialPortCommunication::performConnection(portName, baud);
    }

    Q_INVOKABLE void closeConnection() {
        SerialPortCommunication::m_serialPort->close();
        SerialPortCommunication::m_readerEnabled = false;
    }

    explicit SerialPortCommunication(QObject *parent = nullptr);

    void performConnection(const QString portName, const qint32 baud);
    void setReaderEnabled(bool enabled);

    QSerialPort *serialPort();
    const bool readerEnabled();


private:
    QSerialPort *m_serialPort = nullptr;
    QByteArray m_readData;
    QTextStream m_standardOutput;

    QTimer m_timer;
    const quint16 m_interval = 1000;

    bool m_readerEnabled = false;


signals:
    void readerEnabledChanged();
    void portConnectionChanged();

private slots:
    void handleReadyRead();
    void handleReadyWrite();
    void handleError(QSerialPort::SerialPortError error);

};

#endif // SERIALPORTCOMMUNICATION_H
