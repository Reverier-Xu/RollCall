cmake_minimum_required(VERSION 3.14)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

qt5_add_resources(RESOURCES ./resources/main.qrc)

set(MANAGER_SRCS
        managers/app_manager.cpp
        managers/app_manager.h
        managers/display_manager.cpp
        managers/display_manager.h
        managers/gui_manager.cpp
        managers/gui_manager.h)



set(SRCS
        ${MANAGER_SRCS}
        entry.cxx)

if (${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(RollCall
            MANUAL_FINALIZATION
            ${SRCS}
            ${RESOURCES}
            )
    # Define target properties for Android with Qt 6 as:
    #    set_property(TARGET RollCall APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
    #                 ${CMAKE_CURRENT_SOURCE_DIR}/android)
    # For more information, see https://doc.qt.io/qt-6/qt-add-executable.html#target-creation
else ()

    add_executable(RollCall
            ${SRCS}
            ${RESOURCES}
            )
endif ()


target_link_libraries(RollCall
        PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::Widgets)

set_target_properties(RollCall PROPERTIES
        WIN32_EXECUTABLE TRUE
        )

install(TARGETS RollCall
        BUNDLE DESTINATION .
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

if (QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(RollCall)
    qt_finalize_executable(RollCall)
endif ()
