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
    Q_PROPERTY(QString endDateRaw READ endDateRaw WRITE setEndDateRaw NOTIFY endDateRawChanged)
    Q_PROPERTY(int enabledPlaces READ enabledPlaces WRITE setEnabledPlaces NOTIFY enabledPlacesChanged)
    Q_PROPERTY(QString studentListRaw READ studentListRaw WRITE setStudentListRaw NOTIFY studentListRawChanged)
   private:
    QDate mEndDate{};
    QString mEndDateRaw = "";
    QList<Student> mStudentList;
    QList<Student> mLastList;
    QList<Student> mHistory;
    int mEnabledPlaces = 4;
    QString mStudentListRaw = "";

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

    [[nodiscard]] QString endDateRaw() const;

    void setEndDateRaw(const QString& date);

    [[nodiscard]] int enabledPlaces() const;

    void setEnabledPlaces(int n);

    [[nodiscard]] QString studentListRaw() const;

    void setStudentListRaw(const QString& n);

   public slots:
    Q_INVOKABLE QVariantMap getRandomStudent();

    Q_INVOKABLE void syncWithRawString();

   signals:
    void timeLeftChanged(qint64 timeLeft);

    void endDateChanged(QDate endDate);

    void endDateRawChanged(QString endDateRaw);

    void chosenListChanged(const QStringList &list);

    void enabledPlacesChanged(int n);

    void studentListRawChanged(const QString& n);
};
