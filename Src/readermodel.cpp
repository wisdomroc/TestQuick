#include "readermodel.h"
#include <QVariantMap>

ReaderModel::ReaderModel(QObject *parent):QAbstractListModel (parent)
{
    Q_UNUSED(parent)

    for(int i = 0; i < 10000; i ++)
    {
        Reader *reader = new Reader(tr("%1%2").arg(QString::fromLocal8Bit("张")).arg(i), "******");
        m_readers.append(reader);
    }
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
//        case Qt::TextAlignmentRole:
//            return int(Qt::AlignHCenter);
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

QString ReaderModel::getTestData()
{
    return m_readers.last()->id();
}
