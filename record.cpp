#include "record.h"

Record::Record(int id, const QString &name):
    id_(id),name_(name)
{

}

Record::Record(const Record &r)
{
    id_ = r.id();
    name_ = r.name();
}

int Record::id() const
{
    return id_;
}
QString Record::name() const
{
    return name_;
}
void Record::setId(int value)
{
    if(id_ == value)
        return;
    id_ = value;
    emit idChanged();
}
void Record::setName(const QString &value)
{
    if(name_ == value)
        return;
    name_ = value;
    emit nameChanged();
}
