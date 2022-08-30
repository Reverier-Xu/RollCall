cmake_minimum_required(VERSION 3.14)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

qt5_add_resources(RESOURCES ./resources/main.qrc)

set(MANAGER_SRCS
    managers/app_manager.cxx
    managers/app_manager.h
    managers/display_manager.cxx
    managers/display_manager.h
    managers/gui_manager.cxx
    managers/gui_manager.h managers/data_manager.cxx managers/data_manager.h)

set(MODELS_SRCS
        models/student.cxx
        models/student.h models/student_list.cxx models/student_list.h)

set(SRCS
    ${MANAGER_SRCS} ${MODELS_SRCS}
    entry.cxx)

add_executable(RollCall
               ${SRCS}
               ${RESOURCES}
               )

target_link_libraries(RollCall
                      PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::Widgets)

set_target_properties(RollCall PROPERTIES
                      WIN32_EXECUTABLE TRUE
                      )

install(TARGETS RollCall
        BUNDLE DESTINATION .
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
