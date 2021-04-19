#include "SortFilterModel.h"
#include <QDebug>
#include <QAbstractTableModel>
SortFilterModel::SortFilterModel(QObject *parent) :
    QSortFilterProxyModel(parent)
{
    //setDynamicSortFilter(false);

}

void SortFilterModel::setCondition(const int column, const QString& strCondition)
{
    //如果没有限制条件，则将过滤条件置为空
    if (strCondition.isEmpty()){
        _conditionMap.remove(column);
    }else{
        _conditionMap.insert(column,strCondition);
    }
 //setFilterFixedString("");

    invalidateFilter();
}

//该函数为虚函数，继承下来可以重写，返回值决定了是否将内容显示到表格中
bool SortFilterModel::filterAcceptsRow(int source_row, const QModelIndex &source_parent) const
{

    if (_conditionMap.size() == 0){
        return true;
    }
    //遍历所有的过滤条件，有一个不满足就不显示

    QMap<int, QString>::const_iterator iter = _conditionMap.constBegin();
    while (iter != _conditionMap.end() ) {
        QModelIndex index = sourceModel()->index(source_row, iter.key(), source_parent);

        QString strData = sourceModel()->data(index).toString();
        if (!strData.contains(iter.value())){
            return false;
        }
        iter++;
    }

    return true;

}


QHash<int, QByteArray> SortFilterModel::roleNames() const
{

    //value表示取值，edit表示编辑
    return QHash<int,QByteArray>{
        { Qt::DisplayRole,"value" },
        { Qt::EditRole,"edit" }
    };
}
void SortFilterModel::setModel(EfficientModel* pModel){
    setSourceModel(pModel);
}

