#include "EfficientModel.h"
#include <QDebug>
#include <QTime>
EfficientModel::EfficientModel(QObject *parent)
    : QAbstractTableModel(parent)
{


}

QVariant EfficientModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    // FIXME: Implement me!

    if(orientation==Qt::Horizontal&&role==Qt::DisplayRole){
        if (section < _header.size()){
            return _header.at(section);
        }
    }
    return QAbstractTableModel::headerData(section,orientation,role);
}

int EfficientModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return _modelData.size();
    // FIXME: Implement me!
}

int EfficientModel::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return _header.size();
    // FIXME: Implement me!
}

QVariant EfficientModel::data(const QModelIndex &index, int role) const
{

    Q_UNUSED(role)

    if (!index.isValid())
        return QVariant();

    int nRow = index.row();
    int nColumn = index.column();

    //找到映射
    if (!_roleMap.contains(nColumn)){
        return "";
    }

    if (nRow >= _modelData.size()){
        return "";
    }


    QString strRole = _roleMap.value(nColumn);

    return _modelData.at(nRow).property(strRole).toString();
  //  QJsonDocument jsonDoc = QJsonDocument::fromVariant(.toVariant());


}




bool EfficientModel::insertColumn(int column, QString columnName,QString roleName)
{

    beginInsertColumns(QModelIndex(), column, column);

    _header.insert(column,columnName);
    //记录角色名和列索引直接的关系
    _roleMap[column] = roleName;

    endInsertColumns();

    return true;
}

bool EfficientModel::removeRows(int row, int count, const QModelIndex &parent)
{
    beginRemoveRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    _modelData.remove(row,count);
    endRemoveRows();
    return true;
}

bool EfficientModel::removeColumns(int column, int count, const QModelIndex &parent)
{
    beginRemoveColumns(parent, column, column + count - 1);
    // FIXME: Implement me!
    endRemoveColumns();
    return true;
}




bool EfficientModel::insertRow(int row,QJSValue data,const QModelIndex &parent)
{
    beginInsertRows(parent, row, row );

    _modelData.insert(row,data);
    endInsertRows();

    return true;
}

bool EfficientModel::insertDatas(int row, QJSValue datas,const QModelIndex &parent)
{

    int arrayCount = datas.property("length").toInt();
    beginInsertRows(parent, row, row+arrayCount -1 );
    for (int i =0; i < arrayCount; i++){
        _modelData.push_back(datas.property(i));
    }
    endInsertRows();
    return true;
}

QHash<int, QByteArray> EfficientModel::roleNames() const
{

    //value表示取值，edit表示编辑
    return QHash<int,QByteArray>{
        { Qt::DisplayRole,"value" },
        { Qt::EditRole,"edit" }
    };
}


