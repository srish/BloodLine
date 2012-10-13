#ifndef JSON_H
#define JSON_H

#include <QString>
#include <QVariantMap>

struct JSONData;
class JSON
{
public:
    static JSON& instance();
    ~JSON();

    QVariantMap parse(const QString& string) const;
    QString serialize(const QVariant& value) const;

protected:
    JSON();

private:
    JSONData* d;
};

#endif // JSON_H
