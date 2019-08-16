#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QQmlContext>
#include <QQuickView>
#include <QFontDatabase>
#include "readermodel.h"
#include "readertablemodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine *engine = new QQmlApplicationEngine();

    //向qml注册类型
    qmlRegisterType<ReaderModel>("Backend", 1, 0, "ReaderModel");
    qmlRegisterType<ReaderTableModel>("ReaderTableModel", 1, 0, "ReaderTableModel");

    ReaderModel *readerModel = new ReaderModel();
    ReaderTableModel *readerTableModel = new ReaderTableModel();

    //向qml传递变量
    engine->rootContext()->setContextProperty("readerModel", readerModel);
    engine->rootContext()->setContextProperty("readerTableModel", readerTableModel);
    engine->load(QUrl("qrc:/main.qml"));

    int fontId = QFontDatabase::addApplicationFont(":/Font/fontawesome-webfont.ttf");
    QStringList fontFamilies = QFontDatabase::applicationFontFamilies(fontId);
    qDebug() << "fontFamilies: " << fontFamilies;
    QFont font;
    font.setFamily(fontFamilies.first());
    font.setPointSize(10);
    app.setFont(font);

    return app.exec();
}
