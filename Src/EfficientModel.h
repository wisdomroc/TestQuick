#ifndef EFFICIENTMODEL_H
#define EFFICIENTMODEL_H

#include <QAbstractTableModel>
#include <QJsonObject>
#include <QJsonArray>
#include <QJSValue>

class EfficientModel : public QAbstractTableModel
{
    Q_OBJECT

public:
    explicit EfficientModel(QObject *parent = nullptr);

    // Header:
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;




    // Remove data:
    Q_INVOKABLE bool removeRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;
    bool removeColumns(int column, int count, const QModelIndex &parent = QModelIndex()) override;


    Q_INVOKABLE QHash<int,QByteArray> roleNames() const override;

   //插入新列
   Q_INVOKABLE bool insertColumn(int column, QString columnName,QString roleName);
   //插入新行
   Q_INVOKABLE bool insertRow(int row, QJSValue data,const QModelIndex &parent = QModelIndex());

   Q_INVOKABLE bool insertDatas(int row, QJSValue datas,const QModelIndex &parent = QModelIndex());
   //通过角色名获得对应的单元格的值
   //Q_INVOKABLE QVariant modelData(const int row, QString roleName) const ;
private:
    //表格的头部
    QStringList _header;
    //角色映射
    QMap<int,QString> _roleMap;

    //表格的原始数据
    QVector<QJSValue> _modelData;
};

#endif // EFFICIENTMODEL_H

