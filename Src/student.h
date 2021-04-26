#ifndef READER_H
#define READER_H

#include <QObject>
#include <QVariantList>

class Student : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(int sex READ sex WRITE setSex NOTIFY sexChanged)
    Q_PROPERTY(QString reserve1 READ reserve1 WRITE setReserve1 NOTIFY reserve1Changed)
    Q_PROPERTY(QString reserve2 READ reserve2 WRITE setReserve2 NOTIFY reserve2Changed)
    Q_PROPERTY(QString reserve3 READ reserve3 WRITE setReserve3 NOTIFY reserve3Changed)
    Q_PROPERTY(QString reserve4 READ reserve4 WRITE setReserve4 NOTIFY reserve4Changed)
    Q_PROPERTY(QString reserve5 READ reserve5 WRITE setReserve5 NOTIFY reserve5Changed)
    Q_PROPERTY(QString reserve6 READ reserve6 WRITE setReserve6 NOTIFY reserve6Changed)
    Q_PROPERTY(QString reserve7 READ reserve7 WRITE setReserve7 NOTIFY reserve7Changed)
public:
    explicit Student(const QString &id="", const QString &name="", int sex = 0,
                     const QString &reverve1 = "",
                     const QString &reverve2 = "",
                     const QString &reverve3 = "",
                     const QString &reverve4 = "",
                     const QString &reverve5 = "",
                     const QString &reverve6 = "",
                     const QString &reverve7 = "");
    QString id() const;
    QString name() const;
    int sex() const;
    QString reserve1() const;
    QString reserve2() const;
    QString reserve3() const;
    QString reserve4() const;
    QString reserve5() const;
    QString reserve6() const;
    QString reserve7() const;

public slots:
    void setId(const QString &value);
    void setName(const QString &value);
    void setSex(int value);
    void setReserve1(const QString &reserve1);
    void setReserve2(const QString &reserve2);
    void setReserve3(const QString &reserve3);
    void setReserve4(const QString &reserve4);
    void setReserve5(const QString &reserve5);
    void setReserve6(const QString &reserve6);
    void setReserve7(const QString &reserve7);
private:
    QString _id;
    QString _name;
    int _sex;       //! sex: 1为男   0为女
    QString _reserve1;
    QString _reserve2;
    QString _reserve3;
    QString _reserve4;
    QString _reserve5;
    QString _reserve6;
    QString _reserve7;

signals:
    void idChanged();
    void nameChanged();
    void sexChanged();
    void reserve1Changed();
    void reserve2Changed();
    void reserve3Changed();
    void reserve4Changed();
    void reserve5Changed();
    void reserve6Changed();
    void reserve7Changed();
};

#endif // READER_H
