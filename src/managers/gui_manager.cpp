/**
 * @file gui_manager.cpp
 * @author Reverier-Xu (reverier.xu@outlook.com)
 * @brief
 * @version 0.1
 * @date 2021-12-08
 *
 * @copyright Copyright (c) 2021 Wootec
 *
 */

#include "gui_manager.h"

#include <QApplication>
#include <QObject>
#include <QQmlContext>

#include "display_manager.h"

GuiManager *GuiManager::mInstance = nullptr;

GuiManager::GuiManager(QObject *parent) : QObject(parent) {
    mUiEngine = new QQmlApplicationEngine(this);
}

void GuiManager::createUI() {
    const QUrl url(QStringLiteral("qrc:/views/MainWindow.qml"));
    mUiEngine->load(url);
}

void GuiManager::exportManagers() {
    mUiEngine->rootContext()->setContextProperty(
        "display", DisplayManager::instance(this->parent()));
}

GuiManager *GuiManager::instance(QObject *parent) {
    if (mInstance == nullptr) mInstance = new GuiManager(parent);
    return mInstance;
}
