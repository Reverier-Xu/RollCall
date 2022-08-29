/**
 * @file app_manager.cpp
 * @author Reverier-Xu (reverier.xu@outlook.com)
 * @brief
 * @version 0.1
 * @date 2021-12-08
 *
 * @copyright Copyright (c) 2021 Wootec
 *
 */

#include <QDir>
#include <QStandardPaths>
#include <QThread>

#include "app_manager.h"
#include "gui_manager.h"

void detectPaths();

AppManager::AppManager(QObject *parent) : QObject(parent) {}

void AppManager::initialize() {
    detectPaths();
    auto guiManager = GuiManager::instance(this);
    guiManager->exportManagers();
    guiManager->createUI();
}

AppManager::~AppManager() = default;

void detectPaths() {
    auto dataPath =
        QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    QDir dir;
    QStringList dataPaths = {"/Database"};
    for (auto &i : dataPaths)
        if (!dir.exists(dataPath + i)) dir.mkpath(dataPath + i);
}
