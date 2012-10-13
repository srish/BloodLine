#ifndef FOUNDATION_H
#define FOUNDATION_H

#include <QObject>
struct FoundationData;

class Foundation : public QObject
{
    Q_OBJECT
public:
    static Foundation& instance();
    explicit Foundation(QObject* parent = 0);
    ~Foundation();
    void init();

    Q_INVOKABLE QString possibleReceiverGroups(const QString bloodGroup);
    Q_INVOKABLE QString fileContents(const QString& fileName) const;
    Q_INVOKABLE void writeDatabase();
    Q_INVOKABLE void setFile(const QString& fileName) const;
    Q_INVOKABLE void setFileData(const QString& fileData) const;
    Q_INVOKABLE void readDatabase();
    Q_INVOKABLE void addValue(int index, const QString& key, const QString& value);
    Q_INVOKABLE void clearValue();
    Q_INVOKABLE void createJSONString();
    Q_INVOKABLE void parseNotificationList();
    Q_INVOKABLE int notificationCount();
    Q_INVOKABLE QString notificationMessage(int index);

private:
    FoundationData *d;
};

#endif // FOUNDATION_H
