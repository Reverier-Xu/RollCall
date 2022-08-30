/**
 * @file data_manager.h
 * @author Reverier-Xu (reverier.xu@xdsec.club)
 * @brief 
 * @version 0.1
 * @date 2022-08-29
 *
 * @copyright 2022 Wootec
 */

#pragma once

#include <QObject>
#include <QDate>
#include <QMap>
#include <QTimer>
#include <QMutex>
#include "models/student.h"
#include "models/student_list.h"

class DataManager : public QObject {
    Q_OBJECT
    Q_PROPERTY(qint64 timeLeft READ timeLeft WRITE setTimeLeft NOTIFY timeLeftChanged)
    Q_PROPERTY(QDate endDate READ endDate WRITE setEndDate NOTIFY endDateChanged)
    Q_PROPERTY(int enabledPlaces READ enabledPlaces WRITE setEnabledPlaces NOTIFY enabledPlacesChanged)
   private:
    QDate mEndDate{};
    QList<Student> mStudentList;
    QList<Student> mLastList;
    QList<Student> mHistory;
    int mEnabledPlaces = 4;

    QTimer* syncTimer;
    QMutex randomMutex;

   protected:
    explicit DataManager(QObject *parent);

    ~DataManager() override;

    void loadData();

    static DataManager *mInstance;

   public:
    StudentListModel studentListModel{};

    static DataManager *instance(QObject *parent = nullptr);

    [[nodiscard]] qint64 timeLeft() const;

    void setTimeLeft(qint64 n);

    [[nodiscard]] QDate endDate() const;

    void setEndDate(QDate date);

    [[nodiscard]] int enabledPlaces() const;

    void setEnabledPlaces(int n);

   public slots:
    Q_INVOKABLE QVariantMap getRandomStudent();

   signals:
    void timeLeftChanged(qint64 timeLeft);

    void endDateChanged(QDate endDate);

    void chosenListChanged(const QStringList &list);

    void enabledPlacesChanged(int n);
};
