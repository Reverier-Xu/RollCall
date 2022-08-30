/**
 * @file student.cxx
 * @author Reverier-Xu (reverier.xu@outlook.com)
 * @brief
 * @version 0.1
 * @date 2022-08-30
 *
 * @copyright Copyright (c) 2021 Wootec
 *
 */

#include "student.h"

Student::Student(const Student &student) {
    this->mName = student.name();
    this->mNo = student.no();
    this->setParent(student.parent());
}

Student &Student::operator=(const Student &student) {
    this->mName = student.name();
    this->mNo = student.no();
    this->setParent(student.parent());
    return *this;
}

int Student::no() const {
    return mNo;
}

void Student::setNo(int n) {
    this->mNo = n;
    emit noChanged(n);
}

QString Student::name() const {
    return mName;
}

void Student::setName(const QString &n) {
    this->mName = n;
    emit nameChanged(n);
}

bool Student::operator==(const Student &another) {
    return another.no() == this->no();
}
