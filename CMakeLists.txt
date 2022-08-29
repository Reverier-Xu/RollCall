cmake_minimum_required(VERSION 3.14)

project(RollCall VERSION 15.0 LANGUAGES CXX)

list(APPEND CMAKE_MODULE_PATH
     ${CMAKE_SOURCE_DIR}/cmake
     ${ECM_MODULE_PATH})

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt5 REQUIRED COMPONENTS Core Quick Widgets)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Quick Widgets)

add_subdirectory(src)
