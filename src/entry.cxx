/**
 * @file entry.cpp
 * @author Reverier-Xu (reverier.xu@outlook.com)
 * @brief
 * @version 0.1
 * @date 2021-12-08
 *
 * @copyright Copyright (c) 2021 Wootec
 *
 */
#include <QApplication>
#include <QCommandLineParser>
#include <QFont>
#include <QIcon>
#include <QObject>
#include "managers/app_manager.h"

#ifdef Q_OS_LINUX

#include <malloc.h>

#endif

int main(int argc, char *argv[]) {
#ifdef Q_OS_LINUX
    mallopt(M_ARENA_MAX, 1);
#endif
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    std::setlocale(LC_NUMERIC, "C");

    QApplication app(argc, argv);

    QApplication::setApplicationDisplayName("Roll Call");
    QApplication::setApplicationName("RollCall");
    QApplication::setOrganizationName("Wootec");
    QApplication::setOrganizationDomain("woooo.tech");
//    QApplication::setWindowIcon(QIcon(":/assets/logo-fill.svg"));
#ifdef Q_OS_WINDOWS
    QApplication::setFont(QFont("Microsoft YaHei UI"));
#endif
    auto main_app = AppManager();
    main_app.initialize();

    return QApplication::exec();
}
