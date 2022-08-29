/**
 * @file data_manager.h
 * @author Reverier-Xu (reverier.xu@xdsec.club)
 * @brief 
 * @version 0.1
 * @date 22-8-29
 *
 * @copyright 2022 Wootec
 */

#pragma once

#include <QColor>
#include <QObject>
#include <QTimer>
#include <QDate>

class DataManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(qint64 timeLeft READ timeLeft WRITE setTimeLeft NOTIFY timeLeftChanged)
    Q_PROPERTY(QDate endDate READ endDate WRITE setEndDate NOTIFY endDateChanged)
    Q_PROPERTY(QStringList chosenList READ chosenList WRITE setChosenList NOTIFY chosenListChanged)
    Q_PROPERTY(int enabledPlaces READ enabledPlaces WRITE setEnabledPlaces NOTIFY enabledPlacesChanged)
   private:
    QDate mEndDate{};
    QStringList mChosenList{};
    int mEnabledPlaces = 4;

   protected:
    explicit DataManager(QObject *parent);

    ~DataManager() override;

    void loadData();

    static DataManager *mInstance;

   public:
    static DataManager *instance(QObject *parent = nullptr);

    [[nodiscard]] qint64 timeLeft() const;

    void setTimeLeft(qint64 n);

    [[nodiscard]] QDate endDate() const;

    void setEndDate(QDate date);

    [[nodiscard]] QStringList chosenList() const;

    void setChosenList(const QStringList &list);

    [[nodiscard]] int enabledPlaces() const;

    void setEnabledPlaces(int n);

    signals:
    void timeLeftChanged(qint64 timeLeft);

    void endDateChanged(QDate endDate);

    void chosenListChanged(const QStringList &list);

    void enabledPlacesChanged(int n);
};
