#include "studenttablemodel.h"
#include <QVariantList>
#include <QDebug>

StudentTableModel::StudentTableModel(QObject *parent)
    : QAbstractTableModel(parent)
{
    for(int i = 1; i <= 1000; i ++)
    {
        Student *student = new Student(QString::number(i).rightJustified(3, '0'), QString::fromLocal8Bit("TestName%1").arg(i), i % 2, i,i,i,i,i,i,i);
        m_students.append(student);
    }

    m_headers << QVariant("ID") << QVariant("NAME") << QVariant("SEX") << "Column4" << "Column5" << "Column6" << "Column7" << "Column8" << "Column9" << "Column10";

    connect(&m_timer, SIGNAL(timeout()), this, SLOT(slot_timeout()));
//    m_timer.start(5000);
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
    if(index.row() < 0 || index.row() > m_students.count() - 1)
        return QVariant();

    if (role == Qt::TextAlignmentRole)
    {
        return int(Qt::AlignHCenter | Qt::AlignVCenter);
    }
    else if(role >= Qt::UserRole + 4)
    {
        int column = role - Qt::UserRole - 4;
        Student *student = m_students.at(index.row());
        switch (column) {
        case 0:
            return student->id();
        case 1:
            return student->name();
        case 2:
            return student->sex() == 0 ? QString::fromLocal8Bit("女"):QString::fromLocal8Bit("男");
        case 3:
            return student->value1();
        case 4:
            return student->value2();
        case 5:
            return student->value3();
        case 6:
            return student->value4();
        case 7:
            return student->value5();
        case 8:
            return student->value6();
        case 9:
            return student->value7();
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
    roles.insert(Value1Role, "value1");
    roles.insert(Value2Role, "value2");
    roles.insert(Value3Role, "value3");
    roles.insert(Value4Role, "value4");
    roles.insert(Value5Role, "value5");
    roles.insert(Value6Role, "value6");
    roles.insert(Value7Role, "value7");
    return roles;
}

bool StudentTableModel::insertRows(int row, int count, const QModelIndex &parent)
{
    beginInsertRows(parent, row, row + count - 1);

    for(int i = 0; i < count; i ++)
    {
        Student *stu = new Student(QString::number(i).rightJustified(3, '0'), tr("Test%1").arg(i), i % 2);
        m_students.insert(row + i, stu);
    }

    endInsertRows();
    return true;
}

bool StudentTableModel::removeRows(int row, int count, const QModelIndex &parent)
{
    beginRemoveRows(parent, row, row + count - 1);

    for(int i = row + count - 1; i >= row; i --)
    {
        m_students.removeAt(i);
    }

    endRemoveRows();
    return true;
}

void StudentTableModel::testOutput()
{
    qDebug() << "m_datas first data: " << m_students.first()->id() << "," << m_students.first()->name() << "," << m_students.first()->sex();
}

void StudentTableModel::slot_timeout()
{
    beginResetModel();
    for(int i = 0; i < 1000; i ++)
    {
        int rad = qrand() % 10;
        Student *student = new Student(QString::number(i).rightJustified(3, '0'), QString::fromLocal8Bit("TestName%1").arg(i), i % 2, i+rad,i+rad,i+rad,i+rad,i+rad,i+rad,i+rad);
        m_students.replace(i, student);
    }
    endResetModel();
}
