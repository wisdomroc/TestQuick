#include "readermodel.h"
#include <QVariantMap>

ReaderModel::ReaderModel(QObject *parent):QAbstractListModel (parent)
{
    Q_UNUSED(parent)
    Reader *reader1 = new Reader("whp", "123456");
    Reader *reader2 = new Reader("wl", "654321");
    m_readers.append(reader1);
    m_readers.append(reader2);
}

int ReaderModel::rowCount(const QModelIndex &parent) const
{
    return m_readers.count();
}

QVariant ReaderModel::data(const QModelIndex &index, int role) const
{
    if(index.row() < m_readers.count())
    {
        switch (role) {
        case IdRole:
            return m_readers.at(index.row())->id();
        case PasswordRole:
            return m_readers.at(index.row())->password();
        case RecordRole:
            return m_readers.at(index.row())->record();
        default:
            return QVariant();
        }
    }
    return QVariant();
}

QHash<int, QByteArray> ReaderModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles.insert(IdRole, "id");
    roles.insert(PasswordRole, "password");
    roles.insert(RecordRole, "record");
    return roles;
}
