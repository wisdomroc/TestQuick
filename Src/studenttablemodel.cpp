#include "studenttablemodel.h"
#include <QVariantList>
#include <QDebug>

StudentTableModel::StudentTableModel(QObject *parent)
    : QAbstractTableModel(parent)
{
    for(int i = 0; i < 10; i ++)
    {
        Student *student = new Student(QString::number(i).rightJustified(3, '0'), tr("张%1").arg(i), i % 2);
        m_students.append(student);
    }

    QVariantList list1;
    QVariantList list2;
    QVariantList list3;
    QVariantList list4;
    list1 << "2840710723" << QString::fromLocal8Bit("左俊") << 1;
    list2 << "2840710724" << QString::fromLocal8Bit("赵海昕") << 1;
    list3 << "2840710725" << QString::fromLocal8Bit("李攀") << 1;
    list4 << "2840710726" << QString::fromLocal8Bit("王慧鹏") << 1;
    m_datas.append(list1);
    m_datas.append(list2);
    m_datas.append(list3);
    m_datas.append(list4);

    m_headers << QVariant("ID") << QVariant("姓名") << QVariant("性别");
}

QVariant StudentTableModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if(role == Qt::DisplayRole && orientation == Qt::Horizontal && section < m_headers.count())
    {
        return m_headers.at(section);
    }
    return QVariant();
}

bool StudentTableModel::setHeaderData(int section, Qt::Orientation orientation, const QVariant &value, int role)
{
    if (value != headerData(section, orientation, role))
    {
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

    return m_students.count();
}

int StudentTableModel::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_headers.count();
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
        Student *student = m_students.at(index.row());
        switch (role) {
        case IdRole:
            return student->id();
        case NameRole:
            return student->name();
        case SexRole:
            return student->sex();
        default:
            break;
        }
    }
    return QVariant();
}

bool StudentTableModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value)
    {
        m_students.replace(index.row(), value.value<Student *>());
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
    roles.insert(NameRole, "name");
    roles.insert(SexRole, "sex");
    return roles;
}

bool StudentTableModel::insertRows(int row, int count, const QModelIndex &parent)
{
    beginInsertRows(parent, row, row + count - 1);

    for(int i = 0; i < count; i ++)
    {
        QVariantList list;
        list.append(QString::number(i).rightJustified(3, '0'));
        list.append(tr("Test%1").arg(i));
        list.append(i % 2);
        m_datas.insert(row + i, list);
    }

    endInsertRows();
    return true;
}

bool StudentTableModel::removeRows(int row, int count, const QModelIndex &parent)
{
    beginRemoveRows(parent, row, row + count - 1);

    for(int i = row + count - 1; i >= row; i --)
    {
        m_datas.removeAt(i);
    }

    endRemoveRows();
    return true;
}

void StudentTableModel::testOutput()
{
    qDebug() << "m_datas first data: " << m_datas.first().first() << "," << m_datas.first().at(1) << "," << m_datas.first().at(2);
}
