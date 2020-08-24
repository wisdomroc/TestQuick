#ifndef READERMODEL_H
#define READERMODEL_H
#include "reader.h"
#include <QAbstractListModel>
#include <QVariant>

class ReaderModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum ReaderRole {
        IdRole = Qt::DisplayRole,//0
        PasswordRole = Qt::UserRole,
        RecordRole
    };
    Q_ENUM(ReaderRole)

    explicit ReaderModel(QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;
    Q_INVOKABLE QString getTestData();

private:
    QList<Reader *> m_readers;
};

#endif // READERMODEL_H
