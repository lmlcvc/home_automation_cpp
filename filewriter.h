#ifndef FILEWRITER_H
#define FILEWRITER_H

#include<string>
#include<QFile>
#include<QDateTime>


class FileWriter
{
public:

    static void writeData(const QString &data, const QString &filepath);
    bool getOpened() const;

private:

    static FileWriter* fileWriter;
    static FileWriter& getInstance()
    {
        if(!fileWriter){
            fileWriter = new FileWriter();
        }
        return *fileWriter;
    }

    ~FileWriter();
    FileWriter();

    static void handleFileOpening(QFile &outputFile);
    static QString generateFilepath(const QString &path, const QString &name, const QString &type="txt");
    // TODO make default path

    // static QString m_filepath;
    // static QFile m_outputFile;

    uint32_t m_offset = 0;
    const static uint32_t MAX_SIZE = 250 * 1024 * 1024;  // 250 MB
    static bool opened;
};

#endif // FILEWRITER_H
