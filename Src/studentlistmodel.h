#ifndef STUDENTLISTMODEL_H
#define READERLISTMODEL_H
#include "student.h"
#include <QAbstractListModel>
#include <QVariant>

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
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;
    Q_INVOKABLE void testOutput();

private:
    QList<Student *> m_students;
};

#endif // STUDENTLISTMODEL_H
