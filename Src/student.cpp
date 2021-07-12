#include "student.h"

Student::Student(const QString &id, const QString &name, int sex, int value1, int value2, int value3, int value4, int value5, int value6, int value7):
    _id(id),_name(name),_sex(sex),_value1(value1),_value2(value2),_value3(value3),_value4(value2),_value5(value5),_value6(value6),_value7(value7)
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

int Student::value1() const
{
    return _value1;
}
int Student::value2() const
{
    return _value2;
}
int Student::value3() const
{
    return _value3;
}
int Student::value4() const
{
    return _value4;
}
int Student::value5() const
{
    return _value5;
}
int Student::value6() const
{
    return _value6;
}
int Student::value7() const
{
    return _value7;
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

void Student::setValue1(int value)
{
    _value1 = value;
    emit value1Changed();
}
void Student::setValue2(int value)
{
    _value2 = value;
}
void Student::setValue3(int value)
{
    _value3 = value;
}
void Student::setValue4(int value)
{
    _value4 = value;
}
void Student::setValue5(int value)
{
    _value5 = value;
}
void Student::setValue6(int value)
{
    _value6 = value;
}
void Student::setValue7(int value)
{
    _value7 = value;
}
