#ifndef READERTABLEMODEL_H
#define READERTABLEMODEL_H

#include "reader.h"
#include <QAbstractTableModel>

class ReaderTableModel : public QAbstractTableModel
{
    Q_OBJECT
public:
    enum ReaderTableRole {
        IdRole = Qt::UserRole + 1,
        PasswordRole
    };
    Q_ENUM(ReaderTableRole)
    explicit ReaderTableModel(QObject *parent = nullptr);

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

    /*
    // Add data:
    bool insertRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;
    bool insertColumns(int column, int count, const QModelIndex &parent = QModelIndex()) override;

    // Remove data:
    bool removeRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;
    bool removeColumns(int column, int count, const QModelIndex &parent = QModelIndex()) override;
    */

private:

    QList<Reader *> m_readers;
    QList<QVariantList> m_datas;
    QVariantList m_headers;
};

#endif // READERTABLEMODEL_H
