#include "student.h"

Student::Student(const QString &id, const QString &name, int sex):
    _id(id),_name(name),_sex(sex)
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
