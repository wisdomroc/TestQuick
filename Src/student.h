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
    Q_PROPERTY(int value1 READ value1 WRITE setValue1 NOTIFY value1Changed)
    Q_PROPERTY(int value2 READ sex WRITE setValue2 NOTIFY value2Changed)
    Q_PROPERTY(int value3 READ sex WRITE setValue3 NOTIFY value3Changed)
    Q_PROPERTY(int value4 READ sex WRITE setValue4 NOTIFY value4Changed)
    Q_PROPERTY(int value5 READ sex WRITE setValue5 NOTIFY value5Changed)
    Q_PROPERTY(int value6 READ sex WRITE setValue6 NOTIFY value6Changed)
    Q_PROPERTY(int value7 READ sex WRITE setValue7 NOTIFY value7Changed)
public:
    explicit Student(const QString &id="", const QString &name="", int sex = 0, int value1 = 0,int value2 = 0,int value3 = 0,int value4 = 0,int value5 = 0,int value6 = 0,int value7 = 0);
    QString id() const;
    QString name() const;
    int sex() const;
    int value1() const;
    int value2() const;
    int value3() const;
    int value4() const;
    int value5() const;
    int value6() const;
    int value7() const;

public slots:
    void setId(const QString &value);
    void setName(const QString &value);
    void setSex(int value);
    void setValue1(int value);
    void setValue2(int value);
    void setValue3(int value);
    void setValue4(int value);
    void setValue5(int value);
    void setValue6(int value);
    void setValue7(int value);
private:
    QString _id;
    QString _name;
    int _sex;
    int _value1;
    int _value2;
    int _value3;
    int _value4;
    int _value5;
    int _value6;
    int _value7;

signals:
    void idChanged();
    void nameChanged();
    void sexChanged();
    void value1Changed();
    void value2Changed();
    void value3Changed();
    void value4Changed();
    void value5Changed();
    void value6Changed();
    void value7Changed();
};

#endif // READER_H
