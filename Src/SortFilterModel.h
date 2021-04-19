#ifndef SORTFILTERMODEL_H
#define SORTFILTERMODEL_H

#include <QSortFilterProxyModel>
#include "EfficientModel.h"

class SortFilterModel : public QSortFilterProxyModel
{
    Q_OBJECT
public:
    explicit SortFilterModel(QObject *parent = 0);
    //设置过滤条件
    Q_INVOKABLE void setCondition(const int column, const QString& strCondition);


    Q_INVOKABLE QHash<int,QByteArray> roleNames() const override;

    Q_INVOKABLE void setModel(EfficientModel* pModel);
protected:
    //该函数为虚函数，继承下来可以重写，返回值决定了是否将内容显示到表格中
    virtual bool filterAcceptsRow(int source_row, const QModelIndex &source_parent) const;




signals:


private:
    //所有的过滤条件
    QMap<int,QString> _conditionMap;


};

#endif // SORTFILTERMODEL_H

