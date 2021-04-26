#include "studentlistmodel.h"
#include <QDebug>

StudentListModel::StudentListModel(QObject *parent):QAbstractListModel (parent)
{
    Q_UNUSED(parent)

    for(int i = 0; i < 300; i ++)
    {
        Student *student = new Student(QString::number(i).rightJustified(3, '0'), QString::fromLocal8Bit("张%1").arg(i), i % 2,
                                       tr("reserve1Data_%1").arg(i),
                                       tr("reserve2Data_%1").arg(i),
                                       tr("reserve3Data_%1").arg(i),
                                       tr("reserve4Data_%1").arg(i),
                                       tr("reserve5Data_%1").arg(i),
                                       tr("reserve6Data_%1").arg(i),
                                       tr("reserve7Data_%1").arg(i));
        m_students.append(student);
    }
}

int StudentListModel::rowCount(const QModelIndex &parent) const
{
    return m_students.count();
}

QVariant StudentListModel::data(const QModelIndex &index, int role) const
{
    if(index.row() < m_students.count())
    {
        switch (role) {
        case IdRole:
            return m_students.at(index.row())->id();
        case NameRole:
            return m_students.at(index.row())->name();
        case SexRole:
            return m_students.at(index.row())->sex();
        case Reserve1:
            return m_students.at(index.row())->reserve1();
        case Reserve2:
            return m_students.at(index.row())->reserve2();
        case Reserve3:
            return m_students.at(index.row())->reserve3();
        case Reserve4:
            return m_students.at(index.row())->reserve4();
        case Reserve5:
            return m_students.at(index.row())->reserve5();
        case Reserve6:
            return m_students.at(index.row())->reserve6();
        case Reserve7:
            return m_students.at(index.row())->reserve7();
        default:
            return QVariant();
        }
    }
    return QVariant();
}

QHash<int, QByteArray> StudentListModel::roleNames() const
{
    static QHash<int, QByteArray> roles;
    roles.insert(IdRole, "id");
    roles.insert(NameRole, "name");
    roles.insert(SexRole, "sex");
    roles.insert(Reserve1, "reserve1");
    roles.insert(Reserve2, "reserve2");
    roles.insert(Reserve3, "reserve3");
    roles.insert(Reserve4, "reserve4");
    roles.insert(Reserve5, "reserve5");
    roles.insert(Reserve6, "reserve6");
    roles.insert(Reserve7, "reserve7");
    return roles;
}

void StudentListModel::testOutput()
{
    qDebug() << "I am a studentModel, created by wanghp.";
}
