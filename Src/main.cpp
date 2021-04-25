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
    TableStatus tableStatus;
    StudentListModel *studentListModel = new StudentListModel();
    StudentTableModel *studentTableModel = new StudentTableModel();
    engine->rootContext()->setContextProperty("TableStatus", &tableStatus);
    engine->rootContext()->setContextProperty("studentListModel", studentListModel);
    engine->rootContext()->setContextProperty("studentTableModel", studentTableModel);
    engine->load(QUrl("qrc:/Qml/main1.qml"));


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
