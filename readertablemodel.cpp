#include "readertablemodel.h"
#include <QVariantList>
#include <QDebug>

ReaderTableModel::ReaderTableModel(QObject *parent)
    : QAbstractTableModel(parent)
{
    for(int i = 0; i < 10; i ++)
    {
        Reader *reader = new Reader(tr("%1").arg(i), tr("%1%1%1%1%1%1").arg(i));
        m_readers.append(reader);
    }
    QVariantList list1;
    QVariantList list2;
    list1 << "0" << "000000";
    list2 << "1" << "111111";
    m_datas.append(list1);
    m_datas.append(list2);

    m_headers << QVariant("Id") << QVariant("Password");
}

QVariant ReaderTableModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    // FIXME: Implement me!
    if(role == Qt::DisplayRole && orientation == Qt::Horizontal)
    {
        return m_headers.at(section);
    }
    return QVariant();
}

bool ReaderTableModel::setHeaderData(int section, Qt::Orientation orientation, const QVariant &value, int role)
{
    if (value != headerData(section, orientation, role)) {
        m_headers.replace(section, value);
        emit headerDataChanged(orientation, section, section);
        return true;
    }
    return false;
}


int ReaderTableModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_readers.count();
}

int ReaderTableModel::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    if(m_readers.count() <= 0)
        return 0;
    else
        return 2;
}

QVariant ReaderTableModel::data(const QModelIndex &index, int role) const
{
    if(index.row() < 0 || index.row() > m_datas.count() - 1)
        return QVariant();

    if (role == Qt::TextAlignmentRole)
    {
        return int(Qt::AlignHCenter | Qt::AlignVCenter);
    }
    else
    {
        int columnIdx = role - Qt::UserRole - 1;
        QModelIndex modelIndex = this->index(index.row(), columnIdx);
        qDebug() << index.row() << "," << modelIndex.column() << endl;
        return m_datas.at(modelIndex.row()).at(modelIndex.column());
        //        Reader *reader = m_readers.at(index.row());
        //        int num = role - Qt::UserRole - 1;
        //        if(num == 0)
        //        {
        //            return reader->id();
        //        }
        //        else if(num == 1)
        //        {
        //            return reader->password();
        //        }
    }
    return QVariant();
}

bool ReaderTableModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {
        m_readers.replace(index.row(), value.value<Reader *>());
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags ReaderTableModel::flags(const QModelIndex &index) const
{
    if (index.column() == 0)
    {
        return Qt::ItemIsEnabled | Qt::ItemNeverHasChildren;
    }
    else
    {
        return Qt::ItemIsEnabled | Qt::ItemIsEditable | Qt::ItemNeverHasChildren;
    }
}

QHash<int, QByteArray> ReaderTableModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles.insert(IdRole, "id");
    roles.insert(PasswordRole, "password");
    return roles;
}

/*
bool ReaderTableModel::insertRows(int row, int count, const QModelIndex &parent)
{
    beginInsertRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    endInsertRows();
}

bool ReaderTableModel::insertColumns(int column, int count, const QModelIndex &parent)
{
    beginInsertColumns(parent, column, column + count - 1);
    // FIXME: Implement me!
    endInsertColumns();
}

bool ReaderTableModel::removeRows(int row, int count, const QModelIndex &parent)
{
    beginRemoveRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    endRemoveRows();
}

bool ReaderTableModel::removeColumns(int column, int count, const QModelIndex &parent)
{
    beginRemoveColumns(parent, column, column + count - 1);
    // FIXME: Implement me!
    endRemoveColumns();
}
*/
