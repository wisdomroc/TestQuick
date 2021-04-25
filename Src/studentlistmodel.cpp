#include "studentlistmodel.h"
#include <QDebug>

StudentListModel::StudentListModel(QObject *parent):QAbstractListModel (parent)
{
    Q_UNUSED(parent)

    for(int i = 0; i < 3000; i ++)
    {
        Student *student = new Student(QString::number(i).leftJustified(3, '0'), tr("张%1").arg(i), 2 % i);
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
    roles.insert(NameRole, "password");
    roles.insert(SexRole, "record");
    return roles;
}

void StudentListModel::testOutput()
{
    qDebug() << "I am a studentModel, created by wanghp.";
}
