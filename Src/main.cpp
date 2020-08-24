#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QQmlContext>
#include <QQuickView>
#include <QFontDatabase>
#include "readermodel.h"
#include "readertablemodel.h"
#include "Logger/Logger.h"
#include "FileIO.hpp"
#include "FileInfo.hpp"
#include "TableStatus.hpp"
#include "OperationRecorder.hpp"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setOrganizationName("jaredTao");
    app.setOrganizationDomain("https://jaredtao.github.io");
    Logger::initLog();

    QQmlApplicationEngine *engine = new QQmlApplicationEngine();

    //向qml注册类型
    qmlRegisterType<ReaderModel>("Backend", 1, 0, "ReaderModel");
    qmlRegisterType<ReaderTableModel>("ReaderTableModel", 1, 0, "ReaderTableModel");

    qmlRegisterType<FileIO>("Tools", 1, 0, "FileIO");
    qmlRegisterType<FileInfo>("Tools", 1, 0, "FileInfo");
    qmlRegisterType<OperationRecorder>("Tools", 1, 0, "OperationRecorder");



    ReaderModel *readerModel = new ReaderModel();
    ReaderTableModel *readerTableModel = new ReaderTableModel();

    TableStatus tableStatus;
    //向qml传递变量
    engine->rootContext()->setContextProperty("TableStatus", &tableStatus);
    engine->rootContext()->setContextProperty("readerModel", readerModel);
    engine->rootContext()->setContextProperty("readerTableModel", readerTableModel);
    engine->load(QUrl("qrc:/Qml/main.qml"));


    int fontId = QFontDatabase::addApplicationFont(":/Font/fontawesome-webfont.ttf");
    QStringList fontFamilies = QFontDatabase::applicationFontFamilies(fontId);
    qDebug() << "fontFamilies: " << fontFamilies;
    QFont font;
    font.setFamily(fontFamilies.first());
    font.setPointSize(20);
    //    app.setFont(font);

    return app.exec();
}
