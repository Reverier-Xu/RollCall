/**
 * @file student_list.h
 * @author Reverier-Xu (reverier.xu@outlook.com)
 * @brief
 * @version 0.1
 * @date 2022-08-30
 *
 * @copyright Copyright (c) 2021 Wootec
 *
 */

#pragma once


#include <QAbstractListModel>
#include "student.h"

class StudentListModel : public QAbstractListModel {
    Q_OBJECT
   private:
    QList<Student> *mStudentList{};

   public:
    enum StudentRoles {
        StudentNoRole = Qt::UserRole + 1,
        StudentNameRole,
    };

    explicit StudentListModel(QObject *parent = nullptr);

    [[nodiscard]] int rowCount(const QModelIndex &parent) const override;

    [[nodiscard]] QVariant data(const QModelIndex &index, int role) const override;

    [[nodiscard]] QHash<int, QByteArray> roleNames() const override;

    void setStudentList(QList<Student> * list);

    void reload();
};

