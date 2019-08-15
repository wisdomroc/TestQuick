#include "reader.h"

Reader::Reader(const QString &id, const QString &password):
    id_(id),password_(password)
{
    for(int i = 0; i < 10 ; i ++)
    {
        Record record(QString::number(i), i);
        record_.append(QVariant::fromValue(record));
    }
}

QString Reader::id() const
{
    return id_;
}

QString Reader::password() const
{
    return password_;
}

QVariantList Reader::record() const
{
    return record_;
}

void Reader::doSomething() const
{

}

void Reader::setId(const QString &value)
{
    if(id_ == value)
        return;
    id_ = value;
    emit idChanged();
}

void Reader::setPassword(const QString &value)
{
    if(password_ == value)
        return;
    password_ = value;
    emit passwordChanged();
}

void Reader::setRecord(const QVariantList &value)
{
    if(record_ == value)
        return;
    record_ = value;
    emit recordChanged();
}
