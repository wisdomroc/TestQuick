#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QQmlContext>
#include <QQuickView>
#include <QFontDatabase>
#include "studentlistmodel.h"
#include "studenttablemodel.h"
#include "Logger/Logger.h"
#include "FileIO.hpp"
#include "FileInfo.hpp"
#include "TableStatus.hpp"
#include "OperationRecorder.hpp"
#include "SortFilterModel.h"
#include "EfficientModel.h"
#include "TreeModel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setOrganizationName("CEPRI");
    app.setApplicationName("TestQuick");
    app.setOrganizationDomain("https://github.com/wisdomroc/TestQuick");

    QQmlApplicationEngine *engine = new QQmlApplicationEngine();

    Logger::initLog();

    //! 向qml注册类型
    qmlRegisterType<StudentListModel>("Backend", 1, 0, "StudentListModel");
    qmlRegisterType<StudentTableModel>("StudentTableModel", 1, 0, "StudentTableModel");
    qmlRegisterType<FileIO>("Tools", 1, 0, "FileIO");
    qmlRegisterType<FileInfo>("Tools", 1, 0, "FileInfo");
    qmlRegisterType<OperationRecorder>("Tools", 1, 0, "OperationRecorder");

    qmlRegisterType<EfficientModel>("EfficientModel", 0, 1, "EfficientModel");
    qmlRegisterType<SortFilterModel>("SortFilterModel", 0, 1, "SortFilterModel");


    //! 向qml传递变量
    QVector<CLASS*> mClasses;   //模拟数据
    //初始化模拟数据：学生成绩
    //10个班级、每个班级10000个学生，共10W行记录
    int nClass = 10;
    int nStudent = 10000;
    for(int i=0;i<nClass;i++)
    {
        CLASS* c = new CLASS;
        c->name = QString("class%1").arg(i);
        for(int j=0;j<nStudent;j++)
        {
            STUDENT* s = new STUDENT;
            s->name = QString("name%1").arg(j);
            s->score1 = s->score2 = s->score3 = (j%10)*10;
            c->students.append(s);
        }
        mClasses.append(c);
    }
    QStringList headers;
    headers << QStringLiteral("班级/姓名")
            << QStringLiteral("语文")
            << QStringLiteral("数学")
            << QStringLiteral("外语")
            << QStringLiteral("总分")
            << QStringLiteral("平均分")
            << QStringLiteral("是否合格")
            << QStringLiteral("是否评优");
    //注意：此时构造的是自定义的TreeModel！
    TreeModel* model = new TreeModel(headers);

    TreeItem* root = model->root();
    foreach (CLASS* c, mClasses)
    {
        //一级节点：班级
        TreeItem* itemClass = new TreeItem(root);
        itemClass->setLevel(1);     //设为一级节点，供显示时判断节点层级来转换数据指针类型
        itemClass->setPtr(c);       //保存CLASS* c为其数据指针，显示时从该CLASS*取内容显示
        root->appendChild(itemClass);

        foreach (STUDENT* s, c->students)
        {
            TreeItem* itemStudent = new TreeItem(itemClass);
            itemStudent->setLevel(2);   //设为一级节点，供显示时判断节点层级来转换数据指针类型
            itemStudent->setPtr(s);     //保存STUDENT* s为其数据指针，显示时从STUDENT*取内容显示
            itemClass->appendChild(itemStudent);
        }
    }


    TableStatus tableStatus;
    StudentListModel *studentListModel = new StudentListModel();
    StudentTableModel *studentTableModel = new StudentTableModel();
    engine->rootContext()->setContextProperty("TableStatus", &tableStatus);
    engine->rootContext()->setContextProperty("studentListModel", studentListModel);
    engine->rootContext()->setContextProperty("studentTableModel", studentTableModel);
    engine->rootContext()->setContextProperty("treeModel", model);
    engine->load(QUrl("qrc:/Qml/mainTest.qml"));
//    engine->load(QUrl("qrc:/Qml/main.qml"));


    //! 自定义字体
    /*
    int fontId = QFontDatabase::addApplicationFont(":/Font/fontawesome-webfont.ttf");
    QStringList fontFamilies = QFontDatabase::applicationFontFamilies(fontId);
    QFont font;
    font.setFamily(fontFamilies.first());
    font.setPointSize(20);
    app.setFont(font);
    */

    return app.exec();
}
