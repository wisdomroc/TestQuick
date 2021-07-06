
#include "TreeItem.h"
#include "treemodel.h"
#include <QColor>
#include <QDateTime>
#include <QStringList>


TreeModel::TreeModel(QStringList headers,QObject *parent)
    : QAbstractItemModel(parent)
{
    mHeaders = headers;
    mRootItem = new TreeItem;
}

TreeModel::~TreeModel()
{
    delete mRootItem;
}

TreeItem *TreeModel::itemFromIndex(const QModelIndex &index) const
{
    if (!index.isValid())
        return NULL;
    TreeItem *item = static_cast<TreeItem*>(index.internalPointer());
    return item;
}

TreeItem *TreeModel::root()
{
    return mRootItem;
}

QVariant TreeModel::headerData(int section, Qt::Orientation orientation,int role) const
{
    if (orientation == Qt::Horizontal)
    {
        if(role == Qt::DisplayRole)
        {
            return mHeaders.at(section);
        }
    }
    return QVariant();
}

QVariant TreeModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    TreeItem *item = static_cast<TreeItem*>(index.internalPointer());
    if (role == Qt::DisplayRole)
    {
        return item->data(index.column());
    }
    else if( role == Qt::TextAlignmentRole )
    {
        if( index.column() == 0 )
        {
            //第1列左对齐
            return QVariant(Qt::AlignVCenter | Qt::AlignLeft);
        }
        else if( index.column() > 0 && index.column() < 6 )
        {
            //第2~6列右对齐
            return QVariant(Qt::AlignVCenter | Qt::AlignRight);
        }
        else
        {
            //其他列居中对齐
            return QVariant(Qt::AlignCenter);
        }
    }
    else if(role == Qt::TextColorRole)
    {
        if(index.column() == 6)
        {
            QString str = item->data(6).toString();
            if(str == QStringLiteral("不合格"))
            {
                //第7列（是否合格）如果不合格就设文本为红色
                return QVariant(QColor("#FF0000"));
            }
        }
        return QVariant();
    }
    return QVariant();
}

Qt::ItemFlags TreeModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return 0;

    return QAbstractItemModel::flags(index);
}

QModelIndex TreeModel::index(int row, int column, const QModelIndex &parent) const
{
    if (!hasIndex(row, column, parent))
        return QModelIndex();

    TreeItem *parentItem;

    if (!parent.isValid())
        parentItem = mRootItem;
    else
        parentItem = static_cast<TreeItem*>(parent.internalPointer());

    TreeItem *childItem = parentItem->child(row);
    if (childItem)
        return createIndex(row, column, childItem);
    else
        return QModelIndex();
}

QModelIndex TreeModel::parent(const QModelIndex &index) const
{
    if (!index.isValid())
        return QModelIndex();

    TreeItem *childItem = static_cast<TreeItem*>(index.internalPointer());
    TreeItem *parentItem = childItem->parentItem();

    if (parentItem == mRootItem)
        return QModelIndex();

    return createIndex(parentItem->row(), 0, parentItem);
}

int TreeModel::rowCount(const QModelIndex &parent) const
{
    TreeItem *parentItem;
    if (parent.column() > 0)
        return 0;

    if (!parent.isValid())
        parentItem = mRootItem;
    else
        parentItem = static_cast<TreeItem*>(parent.internalPointer());

    return parentItem->childCount();
}

int TreeModel::columnCount(const QModelIndex &parent) const
{
    return mHeaders.size();
}
