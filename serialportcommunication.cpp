#include "serialportcommunication.h"

#include <QCoreApplication>
#include <QDebug>

SerialPortCommunication::SerialPortCommunication(QObject *parent) :
    QObject(parent),
    m_serialPort(new QSerialPort()),
    m_standardOutput(stdout)
{
    connect(m_serialPort, &QSerialPort::readyRead, this, &SerialPortCommunication::handleReadyRead);
    connect(m_serialPort, &QSerialPort::errorOccurred, this, &SerialPortCommunication::handleError);
    connect(&m_timer, &QTimer::timeout, this, &SerialPortCommunication::handleReadyWrite);

    m_timer.start(m_interval * 1000);
}

void SerialPortCommunication::setReaderEnabled(bool enabled) {
    m_readerEnabled = enabled;
}

QSerialPort *SerialPortCommunication::serialPort() {
    return m_serialPort;
}

const bool SerialPortCommunication::readerEnabled() {
    return m_readerEnabled;
}

void SerialPortCommunication::performConnection(const QString portName, const qint32 baud)
{
    m_serialPort->setPortName(portName);
    m_serialPort->setBaudRate(baud);

    if(!m_serialPort->error()) {
        m_serialPort->open(QIODevice::ReadWrite);
        emit portConnectionChanged();

        m_readerEnabled = true;
        emit readerEnabledChanged();
    } else
        m_standardOutput << m_serialPort->error();
}

void SerialPortCommunication::handleReadyWrite()
{
    if(!m_timer.isActive()) {
        m_timer.start(m_interval * 1000);
    }

    // TODO make data sentences to be written
    m_serialPort->write("test");
}

void SerialPortCommunication::handleReadyRead()
{
    if(m_readerEnabled) {
        if(m_serialPort->canReadLine()) {
            QByteArray data = m_serialPort->readLine();
            QString read_string = QString::fromLocal8Bit(data);

            // TODO check for errors
            // TODO parse message
            qDebug() << read_string;        // temporary
        }
    }
}


void SerialPortCommunication::handleError(QSerialPort::SerialPortError serialPortError)
{
    if (serialPortError == QSerialPort::ReadError) {
        m_standardOutput << QObject::tr("An I/O error occurred while reading "
                                        "the data from port %1, error: %2")
                                .arg(m_serialPort->portName())
                                .arg(m_serialPort->errorString())
                         << "\n";
    }
}
