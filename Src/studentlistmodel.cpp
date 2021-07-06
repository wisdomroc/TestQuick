#include "studentlistmodel.h"
#include <QDebug>
#include <QSize>

StudentListModel::StudentListModel(QObject *parent):QAbstractListModel (parent)
{
    Q_UNUSED(parent)



    insertColumn(0, QString::fromLocal8Bit("序号"), "id", 40);
    insertColumn(1, QString::fromLocal8Bit("姓名"), "name", 40);
    insertColumn(2, QString::fromLocal8Bit("性别"), "sex", 40);
    insertColumn(3, QString::fromLocal8Bit("保留1"), "reserve1", 100);
    insertColumn(4, QString::fromLocal8Bit("保留2"), "reserve2", 100);
    insertColumn(5, QString::fromLocal8Bit("保留3"), "reserve3", 100);
    insertColumn(6, QString::fromLocal8Bit("保留4"), "reserve4", 100);
    insertColumn(7, QString::fromLocal8Bit("保留5"), "reserve5", 100);
    insertColumn(8, QString::fromLocal8Bit("保留6"), "reserve6", 100);
    insertColumn(9, QString::fromLocal8Bit("保留7"), "reserve7", 100);
    insertColumn(10, QString::fromLocal8Bit("保留8"), "reserve8", 100);
    insertColumn(11, QString::fromLocal8Bit("保留9"), "reserve9", 100);
    insertColumn(12, QString::fromLocal8Bit("保留10"), "reserve10", 100);
    insertColumn(13, QString::fromLocal8Bit("保留11"), "reserve11", 100);
    insertColumn(14, QString::fromLocal8Bit("保留12"), "reserve12", 100);
    insertColumn(15, QString::fromLocal8Bit("保留13"), "reserve13", 100);
    insertColumn(16, QString::fromLocal8Bit("保留14"), "reserve14", 100);
    insertColumn(17, QString::fromLocal8Bit("保留15"), "reserve15", 100);
    insertColumn(18, QString::fromLocal8Bit("保留16"), "reserve16", 100);
    insertColumn(19, QString::fromLocal8Bit("保留17"), "reserve17", 100);
    insertColumn(20, QString::fromLocal8Bit("保留18"), "reserve18", 100);
    insertColumn(21, QString::fromLocal8Bit("保留19"), "reserve19", 100);
    insertColumn(22, QString::fromLocal8Bit("保留20"), "reserve20", 100);





    for(int i = 0; i < 10000; i ++)
    {
        Student *student = new Student(QString::number(i).rightJustified(3, '0'), QString::fromLocal8Bit("张%1").arg(i), i % 2);
        m_students.append(student);
    }
}

int StudentListModel::rowCount(const QModelIndex &parent) const
{
    return m_students.count();
}

int StudentListModel::columnCount(const QModelIndex &parent) const
{
    return m_headerLabels.size();
}

QVariant StudentListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    int nRow = index.row();
    int nColumn = index.column();

    //找到映射
    if (!m_roles.contains(nColumn)){
        return "";
    }

    if (nRow >= m_students.size()){
        return "";
    }

    if(role == Qt::DisplayRole)
    {
        Student *student = m_students.at(nRow);
        QStringList reserveStrList;
        for(int i = 0; i < 20; i ++)
        {
            reserveStrList.append(tr("Reserve%1").arg(i));
        }
        return tr("%1,%2,%3,%4").arg(student->id())
                .arg(student->name())
                .arg(student->sex())
                .arg(reserveStrList.join(","));
    }

}

QHash<int, QByteArray> StudentListModel::roleNames() const
{
    //value表示取值，edit表示编辑
    return QHash<int,QByteArray>{
        { Qt::DisplayRole,"value" },
        { Qt::EditRole, "edit"}
    };
}

QVariant StudentListModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if(section >= 0 && section < m_headerLabels.size())
    {
        if(orientation == Qt::Horizontal )
        {
            if(role == Qt::DisplayRole)
            {
                return QVariant(m_headerLabels.at(section));
            }
            else if(role == Qt::SizeHintRole)
            {
                int width = m_headerWidths.at(section);
                return QVariant(QSize(width, 30));
            }
        }
    }
    return QVariant();
}

bool StudentListModel::insertColumn(int column, QString columnName, QString roleName, int columnWidth)
{
    beginInsertColumns(QModelIndex(), column, column);

    m_headerLabels.insert(column, columnName);
    m_headerWidths.append(columnWidth);
    m_roles[column] = roleName;

    endInsertColumns();
    return true;
}

void StudentListModel::testOutput()
{
    qDebug() << "I am a studentModel, created by wanghp.";
}

QList<int> StudentListModel::headerWidths()
{
    return m_headerWidths;
}
