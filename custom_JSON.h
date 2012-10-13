#ifndef custom_JSON_H
#define custom_JSON_H

#include <QObject>

class QUrl;
class QNetworkReply;

struct custom_JSONData;
class custom_JSON : public QObject
{
    Q_OBJECT

public:
    static custom_JSON& instance();
    custom_JSON();
    ~custom_JSON();

    enum ValueMode {
        Normal,
        Configs
    };

    Q_INVOKABLE void init();
    Q_INVOKABLE void parse(const QString& url);
    Q_INVOKABLE void storeConfigs();
    Q_INVOKABLE QString value(const int& id, const QString& key, custom_JSON::ValueMode mode = Normal) const;
    Q_INVOKABLE int valueCount(custom_JSON::ValueMode mode = Normal) const;
    Q_INVOKABLE int localIndexOfKey(const QString& key);
    Q_INVOKABLE QString getUrl(const QString& key) const;
    void parseString(const QString& string);
    QString mapValue(int index) const;

private slots:
    void onNetworkReplyFinished(QNetworkReply *reply);

private:
    custom_JSONData *d;
};

#endif // custom_JSON_H
