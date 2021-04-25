#ifndef READER_H
#define READER_H

#include "record.h"
#include <QObject>
#include <QVariantList>

class Student : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(int sex READ sex WRITE setSex NOTIFY sexChanged)
public:
    explicit Student(const QString &id="", const QString &name="", int sex = 0);
    QString id() const;
    QString name() const;
    int sex() const;

public slots:
    void setId(const QString &value);
    void setName(const QString &value);
    void setSex(int value);
private:
    QString _id;
    QString _name;
    int _sex;       //! sex: 1为男   0为女

signals:
    void idChanged();
    void nameChanged();
    void sexChanged();
};

#endif // READER_H
