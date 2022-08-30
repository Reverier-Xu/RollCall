/**
 * @file student_list.cxx
 * @author Reverier-Xu (reverier.xu@outlook.com)
 * @brief
 * @version 0.1
 * @date 2022-08-30
 *
 * @copyright Copyright (c) 2021 Wootec
 *
 */

#include "student_list.h"

StudentListModel::StudentListModel(QObject *parent) : QAbstractListModel(parent) { }

int StudentListModel::rowCount(const QModelIndex &parent) const {
    Q_UNUSED(parent)
    return mStudentList->length();
}

QVariant StudentListModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid()) {
        return {};
    }

    if (index.row() >= mStudentList->length()) {
        return {};
    }

    switch (role) {
        case StudentRoles::StudentNoRole:
            return mStudentList->at(index.row()).no();
        case StudentRoles::StudentNameRole:
            return mStudentList->at(index.row()).name();
        default:
            return {};
    }
}

QHash<int, QByteArray> StudentListModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[StudentNoRole] = "studentNo";
    roles[StudentNameRole] = "studentName";
    return roles;
}

void StudentListModel::setStudentList(QList<Student> * list) {
    beginResetModel();
    mStudentList = list;
    endResetModel();
}

void StudentListModel::reload() {
    beginResetModel();
    endResetModel();
}
