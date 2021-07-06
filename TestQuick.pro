QT += quick qml

CONFIG += c++11

msvc{
    QMAKE_CFLAGS += -source-charset:utf-8
    QMAKE_CXXFLAGS += -source-charset:utf-8
}

HEADERS += \
    Src/EfficientModel.h \
    Src/SortFilterModel.h \
    Src/Logger/Logger.h \
    Src/Logger/LoggerTemplate.h \
    Src/FileInfo.hpp \
    Src/FileIO.hpp \
    Src/OperationRecorder.hpp \
    Src/TableStatus.hpp \
    Src/TreeItem.h \
    Src/TreeModel.h \
    Src/define.h \
    Src/student.h \
    Src/studentlistmodel.h \
    Src/studenttablemodel.h

SOURCES += \
    Src/EfficientModel.cpp \
    Src/SortFilterModel.cpp \
    Src/TreeItem.cpp \
    Src/TreeModel.cpp \
    Src/main.cpp \
    Src/Logger/Logger.cpp \
    Src/FileInfo.cpp \
    Src/FileIO.cpp \
    Src/OperationRecorder.cpp \
    Src/TableStatus.cpp \
    Src/student.cpp \
    Src/studentlistmodel.cpp \
    Src/studenttablemodel.cpp

RESOURCES += qml.qrc \
    qml.qrc \
    image.qrc \
    Json.qrc

DESTDIR = bin
CONFIG(debug, debug|release) {
    MOC_DIR = build/debug/moc
    RCC_DIR = build/debug/rcc
    UI_DIR = build/debug/ui
    OBJECTS_DIR = build/debug/obj
} else {
    MOC_DIR = build/release/moc
    RCC_DIR = build/release/rcc
    UI_DIR = build/release/ui
    OBJECTS_DIR = build/release/obj
}

OTHER_FILES += README.md

macos {
OTHER_FILES +=
}

linux {
OTHER_FILES +=
}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =
