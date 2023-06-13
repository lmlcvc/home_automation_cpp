#include "filewriter.h"
#include "qdebug.h"
#include <QTextStream>
#include <QDir>

FileWriter::FileWriter()
{

}

//QString FileWriter::m_filepath = QDir::toNativeSeparators("C:/Users/lanam/Documents/gui_output/test.csv" +
//                                                          QDateTime::currentDateTime().toString("yyyy-MM-dd_HH-mm-ss") + ".csv");

//QFile FileWriter::m_outputFile(FileWriter::m_filepath);
bool FileWriter::opened = false;

QString FileWriter::generateFilepath(const QString &path, const QString &name, const QString &type) {
    const QString filepath = QDir::toNativeSeparators(path +
                                                      name +
                                                      QDateTime::currentDateTime().toString("yyyy-MM-dd_HH-mm-ss") +
                                                      "." + type);
    return filepath;
}

bool FileWriter::getOpened() const {
    return opened;
}

void FileWriter::handleFileOpening(QFile &outputFile) {
    if(!outputFile.isOpen()) {
        if(!outputFile.open(QIODevice::ReadWrite)) {
            qDebug() << outputFile.errorString();
            opened = false;
            return;
        }
    }


    if(outputFile.size() >= MAX_SIZE) {
        outputFile.close();
    }

    opened = true;
}


void FileWriter::writeData(const QString &data, const QString &path) {
    QFile outputFile = QFile(path);
    FileWriter::handleFileOpening(outputFile);
    if(FileWriter::opened) {
        QTextStream outStream(&outputFile);
        outStream << data;
    }
}
