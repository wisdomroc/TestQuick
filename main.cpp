#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QQmlContext>
#include <QQuickView>
#include "readermodel.h"
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine *engine = new QQmlApplicationEngine();

    //向qml注册类型
    qmlRegisterType<ReaderModel>("Backend", 1, 0, "ReaderModel");

    ReaderModel *readerModel = new ReaderModel();


    //向qml传递变量
    engine->rootContext()->setContextProperty("readerModel", readerModel);
    engine->load(QUrl("qrc:/main.qml"));


    return app.exec();
}
