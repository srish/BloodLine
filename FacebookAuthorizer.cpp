#include "JSON.h"
#include <QDebug>
#include <QStringList>
#include <QDomDocument>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QNetworkAccessManager>
#include "FacebookAuthorizer.h"
#include "Foundation.h"

FacebookAuthorizer& FacebookAuthorizer::instance()
{
    static FacebookAuthorizer theInstance;
    return theInstance;
}

FacebookAuthorizer::FacebookAuthorizer(QObject *parent) :
    QObject(parent)
{
}

FacebookAuthorizer::~FacebookAuthorizer()
{
}

void FacebookAuthorizer::setAccessToken(const QString &accessToken)
{
    if (accessToken != m_accessToken) {
        m_accessToken = accessToken;
        emit accessTokenChanged(m_accessToken);
    }
}

QString FacebookAuthorizer::accessToken() const
{
    return m_accessToken;
}

void FacebookAuthorizer::setPostID(const QString &postId)
{
    if (postId != m_postId) {
        m_postId = postId;
        emit postIdChanged(m_postId);
    }
}

QString FacebookAuthorizer::postId() const
{
    return m_postId;
}

void FacebookAuthorizer::getFacebookData()
{
    if(accessToken().isEmpty())
        return ;

    QUrl url = QString("https://graph.facebook.com/me?access_token=" + m_accessToken);
    QNetworkRequest request(url);
    QNetworkReply* reply = m_networkManager.get(request);
    //QNetworkReply* reply = NetworkAccessManager::instance().get(request);
    connect(reply, SIGNAL(finished()), this, SLOT(callDone()));

}

void FacebookAuthorizer::getUserInfo()
{
    if(accessToken().isEmpty())
        return ;

    QUrl url = QString("https://graph.facebook.com/fql?q=SELECT+name,birthday_date,current_location,email,contact_email,relationship_status+FROM+user+WHERE+uid=me()&access_token=" + m_accessToken);
    QNetworkRequest request(url);
    QNetworkReply* reply = m_networkManager.get(request);
    connect(reply, SIGNAL(finished()), this, SLOT(callOneDone()));

}

void FacebookAuthorizer::getNotificationsMessage(const QString &url)
{
    if(url.isEmpty())
        return ;

    QNetworkRequest request(url);
    QNetworkReply* reply = m_networkManager.get(request);
    connect(reply, SIGNAL(finished()), this, SLOT(callTwoDone()));
}

void FacebookAuthorizer::parseNotificationsMessage(const QString &jsonString)
{
    if(jsonString.isEmpty())
        return ;

    QVariantMap jsonObject = JSON::instance().parse(jsonString);
    QString message = jsonObject.value("message").toString();
    QString imageName = jsonObject.value("picture").toString();
    QString description = jsonObject.value("description").toString();

    this->setMessage(message);
    this->setImage(imageName);
    this->setDescription(description);
//    QNetworkRequest request(url);
//    QNetworkReply* reply = m_networkManager.get(request);
//    connect(reply, SIGNAL(finished()), this, SLOT(callThreeDone()));

}

void FacebookAuthorizer::setFacebookFirstName(const QString &firstName)
{
    if(firstName!= m_facebookFirstName) {
        m_facebookFirstName = firstName;
        emit facebookFirstNameChanged(m_facebookFirstName);
    }
}

QString FacebookAuthorizer::facebookFirstName() const
{
    return m_facebookFirstName;
}

void FacebookAuthorizer::setFacebookUserName(const QString &userName)
{
    if(userName!= m_facebookUserName) {
        m_facebookUserName = userName;
        emit facebookUserNameChanged(m_facebookUserName);
    }
}

QString FacebookAuthorizer::facebookUserName() const
{
    return m_facebookUserName;
}

void FacebookAuthorizer::setFacebookFullName(const QString &fullName)
{
    if(fullName!= m_fullName)
    {
        m_fullName = fullName;
        emit facebookFullNameChanged(m_fullName);
    }
}

QString FacebookAuthorizer::facebookFullName() const
{
    return m_fullName;
}

void FacebookAuthorizer::setFacebookDOB(const QString &dob)
{
    if(dob!= m_dob)
    {
        m_dob = dob;
        emit facebookDOBChanged(m_dob);
    }
}

QString FacebookAuthorizer::facebookDOB() const
{
    return m_dob;
}

void FacebookAuthorizer::setContactNumber(const QString &contactNumber)
{
}

QString FacebookAuthorizer::contactNumber() const
{
}

void FacebookAuthorizer::setMaritalStatus(const QString &maritalStatus)
{
    if(maritalStatus!= m_martialStatus)
    {
        m_martialStatus = maritalStatus;
        emit maritalStatusChanged(m_martialStatus);
    }
}

QString FacebookAuthorizer::maritalStatus() const
{
    return m_martialStatus;
}

void FacebookAuthorizer::setEMailId(const QString &emailId)
{
    if(emailId!= m_emailId)
    {
        m_emailId = emailId;
        emit emailIdChanged(m_emailId);
    }
}

QString FacebookAuthorizer::emailId() const
{
    return m_emailId;
}

void FacebookAuthorizer::setHomeTown(const QString &homeTown)
{
}

QString FacebookAuthorizer::homeTown() const
{}

void FacebookAuthorizer::setCurrentLocation(const QString &currentLocation)
{
    if(currentLocation!=  m_currentLocation)
    {
        m_currentLocation = currentLocation;
        emit currentLocationChanged(m_currentLocation);
    }
}

QString FacebookAuthorizer::currentLocation() const
{
    return m_currentLocation;
}

void FacebookAuthorizer::setCountry(const QString &country)
{
    if(country!= m_country)
    {
        m_country = country;
        emit countryChanged(m_country);
    }
}

QString FacebookAuthorizer::country() const
{
    return m_country;
}

void FacebookAuthorizer::setDescription(const QString &description)
{
    if(description!= m_description)
    {
        m_description = description;
        emit descriptionChanged(m_description);
    }
}

QString FacebookAuthorizer::description() const
{
    return m_description;
}

void FacebookAuthorizer::setMessage(const QString &message)
{
    if(message!= m_message)
    {
        m_message = message;
        emit messageChanged(m_message);
    }
}

QString FacebookAuthorizer::message() const
{
    return m_message;
}

void FacebookAuthorizer::setImage(const QString &image)
{
    if(image!= m_image)
    {
        m_image = image;
        emit imageChanged(m_image);
    }
}

QString FacebookAuthorizer::image() const
{
    return m_image;
}





void FacebookAuthorizer::extractAccessToken(const QUrl &url)
{
    if (!url.isEmpty())  {
        QString accessToken = url.encodedFragment();        // Get the URL fragment part
        Q_FOREACH(QString str, accessToken.split("&"))
        {
            if(str.contains("access_token"))
                accessToken = str.split("access_token=").at(1);         // Split by "access_token=..." and take latter part
        }

        qDebug() << "Access token is : " << accessToken ;
        setAccessToken(accessToken);
    }
}

void FacebookAuthorizer::extractPostId(const QUrl &url)
{
    if(!url.isEmpty())
    {
        QString postId = url.encodedFragment();

        Q_FOREACH(QString str, postId.split("&"))
        {
            if(str.contains("post_id"))
                postId = str.split("post_id=").at(1);         // Split by "access_token=..." and take latter part
        }

        setPostID(postId);

    }
}

void FacebookAuthorizer::callDone()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(this->sender());
    if(!reply)
        return;

    QByteArray data = reply->readAll();
    QString jsonString = QString(data);
    QVariantMap jsonObject = JSON::instance().parse(jsonString);
    QString firstName = jsonObject.value("first_name").toString();
    QString userName = jsonObject.value("username").toString();
    this->setFacebookFirstName(firstName);
    this->setFacebookUserName(userName);
    emit facebookFirstNameChanged(firstName);
    emit facebookUserNameChanged(userName);
}

void FacebookAuthorizer::callOneDone()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(this->sender());
    if(!reply)
        return;

    QByteArray data = reply->readAll();
    QString jsonString = QString(data);
    QVariantMap jsonObject = JSON::instance().parse(jsonString);

    jsonString = jsonString.remove("{\"data\":[");
    jsonString.chop(2);
    qDebug() << "json string 2" << jsonString;
    jsonObject = JSON::instance().parse(jsonString);
    qDebug() << "json string 3" << jsonString;

    QString fullName = jsonObject.value("name").toString();
    QString birthday_date = jsonObject.value("birthday_date").toString();
    QString email = jsonObject.value("email").toString();
    QString maritalStatus = jsonObject.value("relationship_status").toString();

    QString currentLocation = jsonObject.value("current_location").toString();
    qDebug() << "current location" << currentLocation;
    jsonObject = JSON::instance().parse(currentLocation);

    QString city = jsonObject.value("city").toString();
    QString country = jsonObject.value("country").toString();

    qDebug() << "City : " << city;
    qDebug() << "Country : " << country;

    this->setFacebookFullName(fullName);
    this->setFacebookDOB(birthday_date);
    this->setEMailId(email);
    this->setMaritalStatus(maritalStatus);
    this->setCurrentLocation(city);
    this->setCountry(country);

    emit facebookFullNameChanged(fullName);
    emit facebookDOBChanged(birthday_date);
    emit maritalStatusChanged(maritalStatus);
    emit emailIdChanged(email);
    emit currentLocationChanged(city);
    emit countryChanged(country);
}

void FacebookAuthorizer::callTwoDone()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(this->sender());
    if(!reply)
        return;

    QByteArray data = reply->readAll();
    QString jsonString = QString(data);

    Foundation::instance().setFileData(jsonString);
    Foundation::instance().writeDatabase();

//    QVariantMap jsonObject = JSON::instance().parse(jsonString);
//    QString firstName = jsonObject.value("first_name").toString();
//    QString userName = jsonObject.value("username").toString();
//    this->setFacebookFirstName(firstName);
//    this->setFacebookUserName(userName);
//    emit facebookFirstNameChanged(firstName);
//    emit facebookUserNameChanged(userName);

}

void FacebookAuthorizer::callThreeDone()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(this->sender());
    if(!reply)
        return;

    QByteArray data = reply->readAll();
    QString jsonString = QString(data);
    QVariantMap jsonObject = JSON::instance().parse(jsonString);
    QString message = jsonObject.value("message").toString();
    QString imageName = jsonObject.value("picture").toString();
    QString description = jsonObject.value("description").toString();


//    this->setFacebookFirstName(firstName);
//    this->setFacebookUserName(userName);
//    emit facebookFirstNameChanged(firstName);
//    emit facebookUserNameChanged(userName);

}
