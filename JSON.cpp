#include "JSON.h"
#include <QScriptEngine>
#include <QScriptValue>
#include <QStringList>
#include <QVariantList>
#include <QtDebug>

struct JSONData
{
    QScriptEngine engine;
    QScriptValue parseFn;
    QScriptValue streamFn;

    QScriptValue createValue(const QVariant& value);
};

JSON& JSON::instance()
{
    static JSON theInstance;
    return theInstance;
}

JSON::JSON()
{
    d = new JSONData;

    const QString script = "function parse_json(string) { return JSON.parse(string); }\n"
                           "function stream_json(object) { return JSON.stringify(object); }";
    QScriptValue result = d->engine.evaluate(script);

    d->parseFn = d->engine.globalObject().property("parse_json");
    d->streamFn = d->engine.globalObject().property("stream_json");
}

JSON::~JSON()
{
    delete d;
}

QVariantMap JSON::parse(const QString& string) const
{
    if(string.isEmpty())
        return QVariantMap();

    QScriptValue result = d->parseFn.call(QScriptValue(), QScriptValueList() << QScriptValue(string));
    QVariantMap resultMap = result.toVariant().toMap();
    return resultMap;
}

QString JSON::serialize(const QVariant& value) const
{
    QScriptValue arg = d->createValue(value);
    QScriptValue result = d->streamFn.call(QScriptValue(), QScriptValueList() << arg);
    QString resultString = result.toString();
    return resultString;
}

QScriptValue JSONData::createValue(const QVariant& value)
{
    if(value.type() == QVariant::Map)
    {
        QScriptValue obj = this->engine.newObject();

        QVariantMap map = value.toMap();
        QVariantMap::const_iterator it = map.begin();
        QVariantMap::const_iterator end = map.end();
        while(it != end)
        {
            obj.setProperty( it.key(), this->createValue(it.value()) );
            ++it;
        }

        return obj;
    }

    switch(value.type())
    {
    case QVariant::String:
        return QScriptValue(value.toString());
    case QVariant::Int:
        return QScriptValue(value.toInt());
    case QVariant::UInt:
        return QScriptValue(value.toUInt());
    case QVariant::LongLong:
        return QScriptValue((qsreal)value.toLongLong());
    case QVariant::Bool:
        return QScriptValue(value.toBool());
    case QVariant::ByteArray:
        return QScriptValue(QLatin1String(value.toByteArray()));
    case QVariant::Double:
        return QScriptValue((qsreal)value.toDouble());
    case QVariant::StringList: {
        QStringList stringList = value.toStringList();
        QScriptValue array = this->engine.newArray(stringList.length());
        for(int i=0; i<stringList.count(); i++)
            array.setProperty(i, stringList.at(i));
        return array;
    } break;
    case QVariant::List: {
        QList<QVariant> list = value.toList();
        QScriptValue array = this->engine.newArray(list.length());
        for(int i=0; i<list.count(); i++)
            array.setProperty(i, this->createValue(list.at(i)));
        return array;
    } break;
    default:
        break;
    }

    if(value.isNull())
        return QScriptValue(QScriptValue::NullValue);

    return this->engine.newVariant(value);
}


