#include "student.h"

Student::Student(const QString &id, const QString &name, int sex,
                 const QString &reserve1,
                 const QString &reserve2,
                 const QString &reserve3,
                 const QString &reserve4,
                 const QString &reserve5,
                 const QString &reserve6,
                 const QString &reserve7):
    _id(id),_name(name),_sex(sex),_reserve1(reserve1),_reserve2(reserve2),_reserve3(reserve3),_reserve4(reserve4),_reserve5(reserve5),_reserve6(reserve6),_reserve7(reserve7)
{

}

QString Student::id() const
{
    return _id;
}

QString Student::name() const
{
    return _name;
}

int Student::sex() const
{
    return _sex;
}

QString Student::reserve1() const
{
    return _reserve1;
}

QString Student::reserve2() const
{
    return _reserve2;
}

QString Student::reserve3() const
{
    return _reserve3;
}

QString Student::reserve4() const
{
    return _reserve4;
}

QString Student::reserve5() const
{
    return _reserve5;
}

QString Student::reserve6() const
{
    return _reserve6;
}

QString Student::reserve7() const
{
    return _reserve7;
}

void Student::setId(const QString &value)
{
    if(_id == value)
        return;
    _id = value;
    emit idChanged();
}

void Student::setName(const QString &value)
{
    if(_name == value)
        return;
    _name = value;
    emit nameChanged();
}

void Student::setSex(int value)
{
    if(_sex == value)
        return;
    _sex = value;
    emit sexChanged();
}

void Student::setReserve1(const QString &value)
{
    if(_reserve1 == value)
        return;
    _reserve1 = value;
    emit reserve1Changed();
}

void Student::setReserve2(const QString &value)
{
    if(_reserve2 == value)
        return;
    _reserve2 = value;
    emit reserve2Changed();
}

void Student::setReserve3(const QString &value)
{
    if(_reserve3 == value)
        return;
    _reserve3 = value;
    emit reserve3Changed();
}

void Student::setReserve4(const QString &value)
{
    if(_reserve4 == value)
        return;
    _reserve4 = value;
    emit reserve4Changed();
}

void Student::setReserve5(const QString &value)
{
    if(_reserve5 == value)
        return;
    _reserve5 = value;
    emit reserve5Changed();
}

void Student::setReserve6(const QString &value)
{
    if(_reserve6 == value)
        return;
    _reserve6 = value;
    emit reserve6Changed();
}

void Student::setReserve7(const QString &value)
{
    if(_reserve7 == value)
        return;
    _reserve7 = value;
    emit reserve7Changed();
}
