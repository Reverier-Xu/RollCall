/**
 * @file app_manager.cxx
 * @author Reverier-Xu (reverier.xu@outlook.com)
 * @brief
 * @version 0.1
 * @date 2022-08-30
 *
 * @copyright Copyright (c) 2021 Wootec
 *
 */

#include <QDir>
#include <QStandardPaths>
#include <QThread>

#include "app_manager.h"
#include "gui_manager.h"
#include "models/student.h"

void detectPaths();

AppManager::AppManager(QObject *parent) : QObject(parent) {}

void AppManager::initialize() {
    detectPaths();
    registerTypes();
    auto guiManager = GuiManager::instance(this);
    guiManager->exportManagers();
    guiManager->createUI();
}

void AppManager::registerTypes() {
    qRegisterMetaType<Student>("Student");
}

AppManager::~AppManager() = default;

void detectPaths() {
    auto dataPath = QDir::currentPath();
    QDir dir;
    QStringList dataPaths = {"/data"};
    for (auto &i : dataPaths)
        if (!dir.exists(dataPath + i)) dir.mkpath(dataPath + i);
}
