#ifndef STUDENTLISTMODEL_H
#define READERLISTMODEL_H
#include "student.h"
#include <QAbstractListModel>
#include <QVariant>
#include <QHash>
#include <QByteArray>

class StudentListModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum StudentRole {
        IdRole = Qt::UserRole + 1,
        NameRole,
        SexRole,
        Reserve1,
        Reserve2,
        Reserve3,
        Reserve4,
        Reserve5,
        Reserve6,
        Reserve7
    };
    Q_ENUM(StudentRole)

    explicit StudentListModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;

    //插入新列
    Q_INVOKABLE bool insertColumn(int column, QString columnName, QString roleName, int columnWidth);

    Q_INVOKABLE void testOutput();
    Q_INVOKABLE QList<int> headerWidths();

private:
    QList<Student *> m_students;
    QStringList m_headerLabels;
    QMap<int, QString> m_roles; //角色映射

    QList<int> m_headerWidths;
};

#endif // STUDENTLISTMODEL_H
