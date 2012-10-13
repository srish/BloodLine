#ifndef FACEBOOKAUTHORIZER_H
#define FACEBOOKAUTHORIZER_H

#include <QObject>
#include <QString>
#include <QUrl>
#include <QNetworkAccessManager>

class FacebookAuthorizer : public QObject
{
    Q_OBJECT

public:
    static FacebookAuthorizer& instance();
    explicit FacebookAuthorizer(QObject *parent = 0);
    ~FacebookAuthorizer();

    void setAccessToken(const QString &accessToken);
    Q_PROPERTY(QString accessToken READ accessToken WRITE setAccessToken NOTIFY accessTokenChanged)
    QString accessToken() const;

    void setPostID(const QString &postId);

    Q_PROPERTY(QString postId READ postId WRITE setPostID NOTIFY postIdChanged)
    QString postId() const;

    Q_INVOKABLE void getFacebookData();
    Q_INVOKABLE void getUserInfo();
    Q_INVOKABLE void getNotificationsMessage(const QString& url);
    Q_INVOKABLE void parseNotificationsMessage(const QString& jsonString);

    void setFacebookFirstName(const QString& firstName);
    Q_PROPERTY(QString facebookFirstName READ facebookFirstName WRITE setFacebookFirstName NOTIFY facebookFirstNameChanged)
    QString facebookFirstName() const;

    void setFacebookUserName(const QString& userName);
    Q_PROPERTY(QString facebookUserName READ facebookUserName WRITE setFacebookUserName NOTIFY facebookUserNameChanged)
    QString facebookUserName() const;

    void setFacebookFullName(const QString& fullName);
    Q_PROPERTY(QString facebookFullName READ facebookFullName WRITE setFacebookFullName NOTIFY facebookFullNameChanged)
    QString facebookFullName() const;

    void setFacebookDOB(const QString& dob);
    Q_PROPERTY(QString facebookDOB READ facebookDOB WRITE setFacebookDOB NOTIFY facebookDOBChanged)
    QString facebookDOB() const;

    void setMaritalStatus(const QString& maritalStatus);
    Q_PROPERTY(QString maritalStatus READ maritalStatus WRITE setMaritalStatus NOTIFY maritalStatusChanged)
    QString maritalStatus() const;

    void setContactNumber(const QString& contactNumber);
    Q_PROPERTY(QString contactNumber READ contactNumber WRITE setContactNumber NOTIFY contactNumberChanged)
    QString contactNumber() const;

    void setEMailId(const QString& emailId);
    Q_PROPERTY(QString emailId READ emailId WRITE setEMailId NOTIFY emailIdChanged)
    QString emailId() const;

    void setHomeTown(const QString& homeTown);
    Q_PROPERTY(QString homeTown READ homeTown WRITE setHomeTown NOTIFY homeTownChanged)
    QString homeTown() const;

    void setCurrentLocation(const QString& currentLocation);
    Q_PROPERTY(QString currentLocation READ currentLocation WRITE setCurrentLocation NOTIFY currentLocationChanged)
    QString currentLocation() const;

    void setCountry(const QString& country);
    Q_PROPERTY(QString country READ country WRITE setCountry NOTIFY countryChanged)
    QString country() const;

    void setMessage(const QString& homeTown);
    Q_PROPERTY(QString message READ message WRITE setMessage NOTIFY messageChanged)
    QString message() const;

    void setImage(const QString& image);
    Q_PROPERTY(QString image READ image WRITE setImage NOTIFY imageChanged)
    QString image() const;

    void setDescription(const QString& country);
    Q_PROPERTY(QString description READ description WRITE setDescription NOTIFY descriptionChanged)
    QString description() const;



signals:
    void accessTokenChanged(QString accessToken);
    void postIdChanged(QString postId);
    void facebookFirstNameChanged(QString facebookFirstName);
    void facebookUserNameChanged(QString facebookUserName);
    void facebookFullNameChanged(QString facebookFullName);
    void facebookDOBChanged(QString facebookDOB);
    void maritalStatusChanged(QString maritalStatus);
    void contactNumberChanged(QString contactNumber);
    void emailIdChanged(QString emailId);
    void homeTownChanged(QString homeTown);
    void currentLocationChanged(QString currentLocation);
    void countryChanged(QString country);
    void descriptionChanged(QString description);
    void imageChanged(QString image);
    void messageChanged(QString message);

public slots:
    void extractAccessToken(const QUrl &url);
    void extractPostId(const QUrl &url);
    void callDone();
    void callOneDone();
    void callTwoDone();
    void callThreeDone();

private:
    QString m_accessToken;
    QString m_postId;
    QString m_facebookFirstName;
    QString m_facebookUserName;
    QString m_fullName;
    QString m_dob;
    QString m_martialStatus;
    QString m_contactNumber;
    QString m_emailId;
    QString m_homeTown;
    QString m_currentLocation;
    QString m_country;
    QString m_description;
    QString m_image;
    QString m_message;
    QNetworkAccessManager m_networkManager;
};

#endif // FACEBOOKAUTHORIZER_H
