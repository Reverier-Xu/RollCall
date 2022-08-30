/**
 * @file display_manager.h
 * @author Reverier-Xu (reverier.xu@outlook.com)
 * @brief
 * @version 0.1
 * @date 2021-12-08
 *
 * @copyright Copyright (c) 2021 Wootec
 *
 */

#pragma once

#include <QColor>
#include <QObject>
#include <QTimer>

class DisplayManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(int activeTabIndex MEMBER mActiveTabIndex READ activeTabIndex
                   WRITE setActiveTabIndex NOTIFY activeTabIndexChanged)
    Q_PROPERTY(bool colorStyle MEMBER mColorStyle READ colorStyle WRITE
                   setColorStyle NOTIFY colorStyleChanged)
    Q_PROPERTY(bool blindMode MEMBER mBlindMode READ blindMode WRITE
                   setBlindMode NOTIFY blindModeChanged)
    Q_PROPERTY(QColor themeColor MEMBER mThemeColor READ themeColor WRITE
                   setThemeColor NOTIFY themeColorChanged)
    Q_PROPERTY(QColor contentColor READ contentColor WRITE setContentColor
                   NOTIFY contentColorChanged)
    Q_PROPERTY(QColor alertColor MEMBER mAlertColor READ alertColor WRITE
                   setAlertColor NOTIFY alertColorChanged)

   private:
    int mActiveTabIndex = 0;
    bool mColorStyle = true;
    bool mBlindMode = false;
    QColor mThemeColor = QColor(0x00, 0x78, 0xd6);
    QColor mAlertColor = QColor(0xff, 0x60, 0x33);

   protected:
    explicit DisplayManager(QObject *parent);

    ~DisplayManager() override;

    static DisplayManager *mInstance;

   public:
    static DisplayManager *instance(QObject *parent = nullptr);

    [[nodiscard]] int activeTabIndex() const;

    void setActiveTabIndex(int n);

    [[nodiscard]] bool colorStyle() const;

    void setColorStyle(bool value);

    [[nodiscard]] bool blindMode() const;

    void setBlindMode(bool value);

    [[nodiscard]] QColor themeColor() const;

    void setThemeColor(const QColor &value);

    void setThemeColor(const QString &value);

    [[nodiscard]] QColor alertColor() const;

    void setAlertColor(const QColor &value);

    void setAlertColor(const QString &value);

    [[nodiscard]] QColor contentColor() const;

    void setContentColor(const QColor &value);

   public slots:
    Q_INVOKABLE void raiseWindow();

   signals:
    void activeTabIndexChanged(int n);

    void colorStyleChanged(bool n);

    void blindModeChanged(bool n);

    void themeColorChanged(QColor n);

    void alertColorChanged(QColor n);

    void contentColorChanged(QColor n);

    void raiseWindowRequested();

};
