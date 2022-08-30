/**
 * @file student.h
 * @author Reverier-Xu (reverier.xu@outlook.com)
 * @brief
 * @version 0.1
 * @date 2022-08-30
 *
 * @copyright Copyright (c) 2021 Wootec
 *
 */

#pragma once


#include <QObject>
#include <utility>

class Student : public QObject {
    Q_OBJECT
    Q_PROPERTY(int no READ no WRITE setNo NOTIFY noChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
   private:
    int mNo = 0;
    QString mName = "";

   public:
    explicit Student(QObject* parent = nullptr, int no = 0, QString name = ""):
        QObject(parent), mNo(no), mName(std::move(name)) {}

    Student(const Student& student);

    Student &operator=(const Student &student);

    bool operator==(const Student& another);

    ~Student() override = default;

    Q_INVOKABLE [[nodiscard]] int no() const;

    Q_INVOKABLE void setNo(int n);

    Q_INVOKABLE [[nodiscard]] QString name() const;

    Q_INVOKABLE void setName(const QString& n);

   signals:
    void noChanged(int n);

    void nameChanged(QString n);
};
