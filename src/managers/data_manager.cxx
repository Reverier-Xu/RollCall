/**
 * @file data_manager.cxx
 * @author Reverier-Xu (reverier.xu@xdsec.club)
 * @brief 
 * @version 0.1
 * @date 2022-08-29
 *
 * @copyright 2022 Wootec
 */

#include "data_manager.h"
#include "qdebug.h"
#include <QDir>
#include <QRandomGenerator>
#include <QtCore>
#include <exception>

QString readUnicodeStringFromFile(const QString &path) {
    auto file = QFile(path);
    auto ok = file.open(QFile::ReadOnly);
    if (ok) {
        auto data = file.readAll();
        QTextCodec::ConverterState state;
        QTextCodec *codec = QTextCodec::codecForName("UTF-8");
        codec->toUnicode(data.data(), 10, &state);
        if (state.invalidChars) {
            return QTextCodec::codecForName("GBK")->toUnicode(data);
        } else {
            return QTextCodec::codecForName("UTF-8")->toUnicode(data);
        }
    }
    return "";
}

DataManager *DataManager::mInstance = nullptr;

DataManager::DataManager(QObject *parent) : QObject(parent) {
    syncTimer = new QTimer(this);
    syncTimer->setInterval(1000);
    connect(syncTimer, &QTimer::timeout, this, [=]() {
        auto filepath = QDir::currentPath();
        auto file = QFile(filepath + "/data/cache.txt");
        auto ok = file.open(QFile::WriteOnly);
        for (auto &i : mLastList) {
            file.write(QString::asprintf("%d %s\n", i.no(), i.name().toUtf8().data()).toUtf8());
        }
        file.close();
        mHistory.clear();
        syncTimer->stop();
    });
    studentListModel.setStudentList(&mStudentList);
    loadData();
}

DataManager::~DataManager() = default;

void DataManager::loadData() {
    QString filepath;
    filepath = QDir::currentPath();
//    qDebug() << filepath + "/data/end_date.txt";
    if (QFile::exists(filepath + "/data/end_date.txt")) {
        try {
            auto date = readUnicodeStringFromFile(filepath + "/data/end_date.txt");
            mEndDate = QDate::fromString(date, "yyyy-MM-dd");
        } catch (std::exception &) {
            mEndDate = QDate().addDays(-1);
        }
    } else {
        mEndDate = QDate().addDays(-1);
    }
    if (QFile::exists(filepath + "/data/students.txt")) {
        auto studentListRawStr = readUnicodeStringFromFile(filepath + "/data/students.txt");
        mStudentList = Student::getListFromString(studentListRawStr);
        mStudentListRaw = studentListRawStr;
    }
    if (QFile::exists(filepath + "/data/cache.txt")) {
        auto students = QString(readUnicodeStringFromFile(filepath + "/data/cache.txt")).trimmed().split('\n');
        for (auto &student : students) {
            auto studentInfo = student.split(' ');
            if (studentInfo.length() == 2)
                mLastList.append(Student(nullptr, QString(studentInfo[0]).toInt(), studentInfo[1].trimmed()));
        }
    }
    studentListModel.reload();
}

DataManager *DataManager::instance(QObject *parent) {
    if (mInstance == nullptr) mInstance = new DataManager(parent);
    return mInstance;
}

qint64 DataManager::timeLeft() const {
    auto currentDate = QDate::currentDate();
    auto timeLeft = currentDate.daysTo(endDate());
    return timeLeft;
}

void DataManager::setTimeLeft(qint64) {
    emit timeLeftChanged(timeLeft());
}

QDate DataManager::endDate() const {
    return mEndDate;
}

void DataManager::setEndDate(QDate date) {
    mEndDate = date;
    emit endDateChanged(endDate());
    emit timeLeftChanged(timeLeft());
}

int DataManager::enabledPlaces() const {
    return mEnabledPlaces;
}

void DataManager::setEnabledPlaces(int n) {
    mEnabledPlaces = n;
    emit enabledPlacesChanged(enabledPlaces());
}

QVariantMap DataManager::getRandomStudent() {
//    qDebug() << "Start get random student";
    QMutexLocker locker(&randomMutex);
    auto resMap = QVariantMap();
    if (mStudentList.length() <= 0) {
        resMap["no"] = 0;
        resMap["name"] = "- - -";
    } else {
        Student student;
        do {
            if (mLastList.length() < 1)
                mLastList = mStudentList;
            auto key = QRandomGenerator::global()->bounded(0, mLastList.length());
            student = mLastList[key];
            mLastList.removeAll(student);
        } while (mHistory.contains(student));
        mHistory.append(student);
        resMap["no"] = student.no();
        resMap["name"] = student.name();
    }
    syncTimer->start();
    return resMap;
}

QString DataManager::studentListRaw() const {
    return mStudentListRaw;
}

void DataManager::setStudentListRaw(const QString &n) {
    mStudentListRaw = n;
    emit studentListRawChanged(studentListRaw());
}

void DataManager::syncWithRawString() {
    mStudentList = Student::getListFromString(studentListRaw());
    mLastList.clear();
    studentListModel.reload();
    QFile file(QDir::currentPath() + "/data/students.txt");
    file.open(QFile::WriteOnly);
    file.write(studentListRaw().toUtf8());
    file.close();
    QFile::remove(QDir::currentPath() + "/data/cache.txt");
}
QString DataManager::endDateRaw() const {
    return mEndDate.toString("yyyy-MM-dd");
}
void DataManager::setEndDateRaw(const QString& date) {
    try {
        mEndDate = QDate::fromString(date, "yyyy-MM-dd");
        emit endDateChanged(endDate());
        emit timeLeftChanged(timeLeft());
        QFile file(QDir::currentPath() + "/data/end_date.txt");
        file.open(QFile::WriteOnly);
        file.write(date.toUtf8());
        file.close();
    } catch (std::exception&) {
        mEndDate = QDate().addDays(-1);
    }
}
