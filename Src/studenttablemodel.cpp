#include "studenttablemodel.h"
#include <QVariantList>
#include <QDebug>

StudentTableModel::StudentTableModel(QObject *parent)
    : QAbstractTableModel(parent)
{
    for(int i = 0; i < 10; i ++)
    {
        Reader *reader = new Reader(tr("%1").arg(i), tr("%1%1%1%1%1%1").arg(i));
        m_readers.append(reader);
    }
    QVariantList list1;
    QVariantList list2;
    QVariantList list3;
    QVariantList list4;
    list1 << QString::fromLocal8Bit("左俊") << "2840710723";
    list2 << QString::fromLocal8Bit("赵海昕") << "2840710724";
    list3 << QString::fromLocal8Bit("李攀") << "2840710725";
    list4 << QString::fromLocal8Bit("王慧鹏") << "2840710726";
    m_datas.append(list1);
    m_datas.append(list2);
    m_datas.append(list3);
    m_datas.append(list4);
    m_headers << QVariant("Id") << QVariant("Password");
}

QVariant StudentTableModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    // FIXME: Implement me!
    if(role == Qt::DisplayRole && orientation == Qt::Horizontal)
    {
        return m_headers.at(section);
    }
    return QVariant();
}

bool StudentTableModel::setHeaderData(int section, Qt::Orientation orientation, const QVariant &value, int role)
{
    if (value != headerData(section, orientation, role)) {
        m_headers.replace(section, value);
        emit headerDataChanged(orientation, section, section);
        return true;
    }
    return false;
}


int StudentTableModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_readers.count();
}

int StudentTableModel::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    if(m_readers.count() <= 0)
        return 0;
    else
        return 2;
}

QVariant StudentTableModel::data(const QModelIndex &index, int role) const
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

bool StudentTableModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {
        m_readers.replace(index.row(), value.value<Reader *>());
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags StudentTableModel::flags(const QModelIndex &index) const
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

QHash<int, QByteArray> StudentTableModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles.insert(IdRole, "id");
    roles.insert(PasswordRole, "password");
    return roles;
}

bool StudentTableModel::insertRows(int row, int count, const QModelIndex &parent)
{
    beginInsertRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    for(int i = 0; i < count; i ++)
    {
        QVariantList list;
        list.append(tr("%1").arg(i + 2));
        list.append(tr("%1%1%1%1%1%1").arg(i +2));
        m_datas.insert(row + i, list);
    }
    endInsertRows();
    return true;
}

bool StudentTableModel::removeRows(int row, int count, const QModelIndex &parent)
{
    beginRemoveRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    for(int i = row + count - 1; i >= row; i --)
    {
        m_datas.removeAt(i);
    }
    endRemoveRows();
    return true;
}

QString StudentTableModel::getTestData()
{
    return m_datas.first().first().toString();
}
