#include "Foundation.h"
#include <QMap>
#include <QFile>
#include <QDir>
#include <QStringList>
#include "custom_JSON.h"

struct FoundationData {
    QMap<int,QString> valueMap;
    QString fileData;
    QString fileName;
    QMap<QString, QString> notificationMap;
};

Foundation& Foundation::instance()
{
    static Foundation theInstance;
    return theInstance;
}

Foundation::Foundation(QObject* parent) : QObject(parent)
{
    d = new FoundationData;
}

Foundation::~Foundation()
{
}

void Foundation::init()
{
    // index in database
    // 1 for Profile
    // 2 for Notification
    this->readDatabase();
}

QString Foundation::possibleReceiverGroups(const QString bloodGroup)
{
    if(bloodGroup == "AB+")
    {
        return "You can donate blood to AB+ , AB- , O+, O-, B+, B-, A+, A-";
    }
    else if(bloodGroup == "AB-")
    {
        return "You can donate blood to AB-, O-, B-, A-";
    }
    else if(bloodGroup == "O+")
    {
        return "You can donate blood only to O-";
    }
    else if(bloodGroup == "O-")
    {
        return "You can donate blood to O-";
    }
    else if(bloodGroup == "A+")
    {
        return "You can donate blood to O+, O-, A+, A-";
    }
    else if(bloodGroup == "A-")
    {
        return "You can donate blood to O-, A-";
    }
    else if(bloodGroup == "B+")
    {
        return "You can donate blood to O+, O-, B+, B-";
    }
    else if(bloodGroup == "B-")
    {
        return "You can donate blood to O-, B-";
    }
    else {
        return "You have entered an incorrect group. Please try again!";
    }

    return "";
}

QString Foundation::fileContents(const QString &fileName) const
{
    QFile file(fileName);
    file.open(QFile::ReadOnly);
    return file.readAll();
}

void Foundation::writeDatabase()
{
    QFile file(d->fileName);
    if(!file.open(QIODevice::WriteOnly))
        return;

    file.flush();
    file.write(d->fileData.toUtf8());
    file.close();
}

void Foundation::setFile(const QString &fileName) const
{
    d->fileName = fileName;
}

void Foundation::setFileData(const QString &fileData) const
{
    d->fileData = fileData;
}

void Foundation::readDatabase()
{
    QFile file(d->fileName);
    if(!file.open(QIODevice::ReadOnly))
        return;

    d->fileData = file.readAll();
    file.close();
}

void Foundation::addValue(int index, const QString &key, const QString &value)
{
    QString localValue;
    localValue.append("\"");
    localValue.append(key);
    localValue.append("\":");
    localValue.append("\"");
    localValue.append(value);
    localValue.append("\"");

    custom_JSON::instance().parseString(d->fileData);
    QString preValue = custom_JSON::instance().value(index,key);
    if(!preValue.isNull())
    {
        QString temp = d->valueMap.value(index);
        QStringList tempList = temp.split(key);
        temp = tempList.last();
        preValue.prepend(":\"");
        temp = temp.mid(preValue.length()+1);
        localValue = tempList.first();
        localValue.append(key);
        localValue.append("\":\""+value);
        localValue.append(temp);
    }
    else if(!d->valueMap.value(index).isNull())
        localValue.prepend(d->valueMap.value(index)+",");

    d->valueMap.insert(index, localValue);

    this->createJSONString();
}

void Foundation::clearValue()
{
    d->valueMap.clear();
}

void Foundation::createJSONString()
{
    QString JSONString = "[";

    for(int i=1; i<=d->valueMap.count(); i++)
    {
        if(d->valueMap.value(i).isNull())
            continue;

        JSONString.append("{");
        JSONString.append(d->valueMap.value(i));
        JSONString.append("},");
    }

    if(JSONString.endsWith(","))
        JSONString.chop(1);

    JSONString.append("]");
    d->fileData = JSONString;
}

void Foundation::parseNotificationList()
{
    QStringList notificationList;
    QDir dir;
    Q_FOREACH(QString fileName, dir.entryList())
        d->notificationMap.insert(fileName, "file:///"+dir.currentPath()+fileName);
}

int Foundation::notificationCount()
{
    return d->notificationMap.count();
}

QString Foundation::notificationMessage(int index)
{
    this->setFile(d->notificationMap.value(d->notificationMap.keys().at(index)));
    this->readDatabase();
    return d->fileData;
}
