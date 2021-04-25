#ifndef STUDENTTABLEMODEL_H
#define STUDENTTABLEMODEL_H

#include "student.h"
#include <QAbstractTableModel>

class StudentTableModel : public QAbstractTableModel
{
    Q_OBJECT
public:
    enum StudentTableRole {
        IdRole = Qt::UserRole + 4,
        NameRole,
        SexRole
    };
    Q_ENUM(StudentTableRole)
    explicit StudentTableModel(QObject *parent = nullptr);

    // Header:
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;

    bool setHeaderData(int section, Qt::Orientation orientation, const QVariant &value, int role = Qt::EditRole) override;

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    QHash<int, QByteArray> roleNames() const override;


    // Add data:
    Q_INVOKABLE bool insertRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;
    Q_INVOKABLE bool removeRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;
    Q_INVOKABLE void testOutput();

private:

    QList<Student *> m_students;
    QList<QVariantList> m_datas;
    QVariantList m_headers;
};

#endif // STUDENTTABLEMODEL_H
