#ifndef RECORD_H
#define RECORD_H

#include <QObject>

class Record: public QObject
{
    Q_OBJECT
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)

public:
    Record(int id=0,const QString &name="");
    Record(const Record &r);
    int id() const;
    QString name() const;

public slots:
    void setId(int value);
    void setName(const QString &value);

private:
    int id_;
    QString name_;

signals:
    void idChanged();
    void nameChanged();
};

Q_DECLARE_METATYPE(Record)//元类型注册
#endif // RECORD_H
