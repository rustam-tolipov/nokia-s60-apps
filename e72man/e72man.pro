# Add more folders to ship with the application, here
folder_01.source = qml/e72man
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

QML_IMPORT_PATH =

symbian:TARGET.UID3 = 0xE26DC776

CONFIG += mobility
MOBILITY += multimedia sensors systeminfo location

SOURCES += main.cpp \
    navigator.cpp \
    vibrationhelper.cpp

HEADERS += navigator.h \
    vibrationhelper.h

symbian:TARGET.CAPABILITY += NetworkServices ReadUserData Location
symbian:LIBS += -lhwrmvibraclient

include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()
