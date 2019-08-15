#ifndef READER_H
#define READER_H

#include "record.h"
#include <QObject>
#include <QVariantList>

class Reader : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString password READ password WRITE setPassword NOTIFY passwordChanged)
    Q_PROPERTY(QVariantList record READ record WRITE setRecord NOTIFY recordChanged)
public:
    explicit Reader(const QString &id="", const QString &password="");
    QString id() const;
    QString password() const;
    QVariantList record() const;

    Q_INVOKABLE void doSomething() const;
public slots:
    void setId(const QString &value);
    void setPassword(const QString &value);
    void setRecord(const QVariantList &value);
private:
    QString id_;
    QString password_;
    QVariantList record_;

signals:
    void idChanged();
    void passwordChanged();
    void recordChanged();
};

#endif // READER_H
