/**
 * @file data_manager.cxx
 * @author Reverier-Xu (reverier.xu@xdsec.club)
 * @brief 
 * @version 0.1
 * @date 22-8-29
 *
 * @copyright 2022 Wootec
 */

#include "data_manager.h"

DataManager *DataManager::mInstance = nullptr;

DataManager::DataManager(QObject *parent) : QObject(parent) {
    loadData();
}

DataManager::~DataManager() = default;

void DataManager::loadData() {

}

DataManager *DataManager::instance(QObject *parent) {
    if (mInstance == nullptr) mInstance = new DataManager(parent);
    return mInstance;
}
qint64 DataManager::timeLeft() const {
    auto currentDate = QDate::currentDate();
    auto timeLeft = mEndDate.daysTo(currentDate);
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
QStringList DataManager::chosenList() const {
    return mChosenList;
}
void DataManager::setChosenList(const QStringList &list) {
    mChosenList = list;
    emit chosenListChanged(chosenList());
}
int DataManager::enabledPlaces() const {
    return mEnabledPlaces;
}
void DataManager::setEnabledPlaces(int n) {
    mEnabledPlaces = n;
    emit enabledPlacesChanged(enabledPlaces());
}
