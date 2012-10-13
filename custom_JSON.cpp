#include "custom_JSON.h"

#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkReply>
#include <QUrl>
#include <QStringList>
#include <QDebug>
#include <QEventLoop>
#include <QFile>
#include <QMap>

struct custom_JSONData
{
    custom_JSONData() : isParsingFinished(true), tryCount(0) {}

    QNetworkAccessManager *netMan;
    QMap<int,QString> valueMap;
    QMap<int,QString> configsValueMap;
    bool isParsingFinished;
    int tryCount;

    QString fileData;
};

custom_JSON& custom_JSON::instance()
{
    static custom_JSON theInstance;
    return theInstance;
}

custom_JSON::custom_JSON() :
    QObject()
{
    d = new custom_JSONData;
}

custom_JSON::~custom_JSON()
{
    delete d;
}

void custom_JSON::init()
{
    this->parse("http://www.sachinworld.com/static/s3rsports/configs.json");
    this->storeConfigs();
}

void custom_JSON::parse(const QString& url)
{
    if(!d->isParsingFinished)
    {
        QEventLoop pause;
        connect(d->netMan, SIGNAL(finished(QNetworkReply*)), &pause, SLOT(quit()));
        pause.exec();
    }

    d->valueMap.clear();
    d->isParsingFinished = false;
    d->netMan = new QNetworkAccessManager;
    d->netMan->get(QNetworkRequest(QUrl(url)));

    connect(d->netMan, SIGNAL(finished(QNetworkReply*)), this, SLOT(onNetworkReplyFinished(QNetworkReply*)));
}

void custom_JSON::storeConfigs()
{
    if(!d->isParsingFinished)
    {
        QEventLoop pause;
        connect(d->netMan, SIGNAL(finished(QNetworkReply*)), &pause, SLOT(quit()));
        pause.exec();
    }

    d->configsValueMap = d->valueMap;
}

QString custom_JSON::value(const int &id, const QString &key, custom_JSON::ValueMode mode) const
{
    if(!d->isParsingFinished)
    {
        QEventLoop pause;
        connect(d->netMan, SIGNAL(finished(QNetworkReply*)), &pause, SLOT(quit()));
        pause.exec();
    }
    QString string;
    if(mode == custom_JSON::Normal)
        string = d->valueMap.value(id);
    else if(mode == custom_JSON::Configs)
        string = d->configsValueMap.value(id);

    QStringList stringList = string.split(",\"");
    Q_FOREACH(QString str, stringList)
    {
        if(str.startsWith("\""))
                    str = str.mid(1);

        if(str.startsWith(key+"\""))
        {
            QString returnStr;
            if(str.startsWith(key+"\""+": "))
                returnStr = str.remove(key+"\""+": ");
            else
                returnStr = str.remove(key+"\""+":");

            if(returnStr.startsWith("\""))
                returnStr = returnStr.mid(1);

            if(returnStr.endsWith("\""))
                returnStr.chop(1);

            return returnStr.trimmed();
        }
    }

    return QString();
}

int custom_JSON::valueCount(custom_JSON::ValueMode mode) const
{
    if(!d->isParsingFinished)
    {
        QEventLoop pause;
        connect(d->netMan, SIGNAL(finished(QNetworkReply*)), &pause, SLOT(quit()));
        pause.exec();
    }

    if(mode == custom_JSON::Normal)
        return d->valueMap.count();
    else if(mode == custom_JSON::Configs)
        return d->configsValueMap.count();

    return -1;
}


// Only for configs.json
int custom_JSON::localIndexOfKey(const QString &key)
{
    if(!d->isParsingFinished)
    {
        QEventLoop pause;
        connect(d->netMan, SIGNAL(finished(QNetworkReply*)), &pause, SLOT(quit()));
        pause.exec();
    }

    int valueCount = this->valueCount(custom_JSON::Configs);
    for(int i=1; i<=valueCount; i++)
    {
        QString value = this->value(i,"key", custom_JSON::Configs);
        if(value == key)
        {
            return i;
            break;
        }
    }
    return -1;
}

QString custom_JSON::getUrl(const QString &key) const
{
    custom_JSON *that = const_cast<custom_JSON*>(this);
//    that->parse("http://www.sachinworld.com/static/s3rsports/configs.json");
    int index = that->localIndexOfKey(key);
    QString returnStr = value(index,"value", custom_JSON::Configs);
    if(!returnStr.isEmpty())
        return returnStr;
    else if(d->tryCount < 5)
    {
        d->tryCount++;
        that->parse("http://www.sachinworld.com/static/s3rsports/configs.json");
        that->storeConfigs();
        that->getUrl(key);
    }

    d->tryCount = 0;

    return QString();
}

void custom_JSON::parseString(const QString& string)
{
    d->valueMap.clear();
    QString stringCp = string;
    stringCp = stringCp.replace("} , {", "},{");
    stringCp = stringCp.replace("}, {", "},{");

    QStringList stringList;

//    if(stringCp.contains("} , {"))
//        stringList = stringCp.split("} , {");
//    else if(stringCp.contains("}, {"))
//        stringList = stringCp.split("}, {");
//    else
    stringList = stringCp.split("},{");

    int i = 1;
    Q_FOREACH(QString str, stringList)
    {
        str = str.simplified();
        if(str.startsWith("[{"))
            str = str.mid(2);
        else if(str.startsWith("[ {"))
            str = str.mid(3);
        else if(str.startsWith("[ { "))
            str = str.mid(4);

        if(str.endsWith("}]"))
            str.chop(2);
        else if(str.endsWith("} ]"))
            str.chop(3);
        else if(str.endsWith(" } ]"))
            str.chop(4);

        str = str.replace("\", \"", "\",\"");
        str = str.simplified();
        d->valueMap.insert(i,str);
        i++;
    }

    d->isParsingFinished = true;
}

QString custom_JSON::mapValue(int index) const
{
    if(!d->isParsingFinished)
    {
        QEventLoop pause;
        connect(d->netMan, SIGNAL(finished(QNetworkReply*)), &pause, SLOT(quit()));
        pause.exec();
    }

    return d->valueMap.value(index);
}

void custom_JSON::onNetworkReplyFinished(QNetworkReply *reply)
{
    if(reply->error() == QNetworkReply::NoError)
    {

        QString replyString =  reply->readAll();
        replyString = replyString.simplified();
        d->fileData = replyString;
        this->parseString(replyString);
    }
    else
    {
        d->isParsingFinished = true;
    }
}
