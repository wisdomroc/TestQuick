#ifndef RECORD_H
#define RECORD_H

#include <QObject>

class Record: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString bookId READ bookId WRITE setBookId NOTIFY bookIdChanged)
    Q_PROPERTY(int state READ state WRITE setState NOTIFY stateChanged)

public:
    Record(const QString &bookId="",int state = 0);
    Record(const Record &r);
    QString bookId() const;
    int state() const;

public slots:
    void setBookId(const QString &value);
    void setState(int value);

private:
    QString bookId_;
    int state_;

signals:
    void bookIdChanged();
    void stateChanged();
};

Q_DECLARE_METATYPE(Record)//元类型注册
#endif // RECORD_H
