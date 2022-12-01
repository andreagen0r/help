cmake_minimum_required(VERSION 3.23 FATAL_ERROR)

project( MyApp VERSION 0.1.1 LANGUAGES CXX )

include(cmake/PreventSourceBuild.cmake)
include(cmake/BaseSettings.cmake)
include(cmake/BuildSettings.cmake)
include(cmake/InstallSettings.cmake)
include(cmake/Cache.cmake)
include(cmake/Warnings.cmake)
include(cmake/StaticAnalyzers.cmake)
include(cmake/Sanitizers.cmake)
include(cmake/Git.cmake)
include(cmake/Linker.cmake)
include(cmake/Doxygen.cmake)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

# ---------------------------------------------------------------------------------------
# External libraries
# ---------------------------------------------------------------------------------------
find_package(OpenSSL REQUIRED)

find_package(Qt6
    COMPONENTS
    Core
    Qml
    Quick
    Widgets
    Network
    Sql
    LinguistTools
    ShaderTools
    REQUIRED
)

qt_standard_project_setup()

qt_add_executable( "AwesomeApp"
    main.cpp
    applicationCLI.h
)

qt_add_qml_module("AwesomeApp"
    URI "ModuleA"
    VERSION 1.0
    QML_FILES
        main.qml
)

qt_add_translations("AwesomeApp"
    TS_FILES
    "translations/AwesomeApp_pt_BR.ts"
)

# ---------------------------------------------------------------------------------------
# Qt definitions
# ---------------------------------------------------------------------------------------
add_definitions(
    -DQT_NO_KEYWORDS
    -DQT_NO_CAST_TO_ASCII
    -DQT_NO_CAST_FROM_ASCII
    -DQT_STRICT_ITERATORS
    -DQT_NO_URL_CAST_FROM_STRING
    -DQT_NO_CAST_FROM_BYTEARRAY
    -DQT_USE_QSTRINGBUILDER
    -DQT_NO_SIGNALS_SLOTS_KEYWORDS
    -DQT_USE_FAST_OPERATOR_PLUS
    -DQT_DISABLE_DEPRECATED_BEFORE=0x050c00
)

# ---------------------------------------------------------------------------------------
# Subdirectories
# ---------------------------------------------------------------------------------------
# Directories where Qt Creator can find QML files.
# Not needed for builds, but makes Qt Creator lint happy
list(APPEND QML_DIRS "${CMAKE_SOURCE_DIR}/")
list(APPEND QML_DIRS "${CMAKE_SOURCE_DIR}/app")
list(APPEND QML_DIRS "${CMAKE_SOURCE_DIR}/app/MyModules")

## Prevent adding duplicate values at each run of CMake.
list(REMOVE_DUPLICATES QML_DIRS)

set(QML_IMPORT_PATH ${QML_DIRS} CACHE STRING "Qt Creator extra qml import paths" FORCE )
set(QML2_IMPORT_PATH ${QML_DIRS} CACHE STRING "Qt Creator extra qml import paths" FORCE )

message(STATUS "QML_IMPORT_PATH : ${QML_IMPORT_PATH}")

# ---------------------------------------------------------------------------------------
# Subdirectories
# ---------------------------------------------------------------------------------------
add_subdirectory(MyModules)

# ---------------------------------------------------------------------------------------
# Settings, Warnings, Sanitizers
# ---------------------------------------------------------------------------------------
add_library(${PROJECT_NAME}_warnings INTERFACE)
add_library(${PROJECT_NAME}_options INTERFACE)
target_compile_features(${PROJECT_NAME}_options INTERFACE cxx_std_20)

build_settings("AwesomeApp")
set_project_warnings(${PROJECT_NAME}_warnings)
enable_sanitizers(${PROJECT_NAME}_options)
set_configure_linker(${PROJECT_NAME}_options)

install(TARGETS "AwesomeApp" EXPORT ${PROJECT_NAME}_Targets)

set_target_properties("AwesomeApp"
    PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)

target_compile_definitions("AwesomeApp" PRIVATE
    $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)

# ---------------------------------------------------------------------------------------
# CMake Utilities
# ---------------------------------------------------------------------------------------
target_link_libraries("AwesomeApp"
    PRIVATE
    # Settings
    ${PROJECT_NAME}_options
    ${PROJECT_NAME}_warnings

    # Qt
    Qt::Quick
    Qt::Qml
    Qt::Widgets

    # BACKEND
    mylib::awesome_core
)

target_include_directories("AwesomeApp"
    PRIVATE
    $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}/include> # version.h
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    ${OPENSSL_INCLUDE_DIR}
)

# ---------------------------------------------------------------------------------------
#
# ---------------------------------------------------------------------------------------
set(CPACK_RESOURCE_FILE_LICENSE "${PROJECT_SOURCE_DIR}/LICENSE")

if(QT_VERSION_MAJOR EQUAL 6 AND ${BUILD_SHARED_LIBS} EQUAL False)
    qt_import_qml_plugins("AwesomeApp")
endif()

include(CMakePackageConfigHelpers)

# ---------------------------------------------------------------------------------------
# Show what modules were found and save a log file
# ---------------------------------------------------------------------------------------
include(FeatureSummary)
feature_summary(WHAT ALL)
feature_summary(FILENAME ${CMAKE_CURRENT_BINARY_DIR}/features.log WHAT ALL)
