cmake_minimum_required(VERSION 3.23 FATAL_ERROR)

project("awesome_core" VERSION 0.1.0 LANGUAGES CXX )

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

# ---------------------------------------------------------------------------------------
# Code coverage
# ---------------------------------------------------------------------------------------
if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(CMAKE_CXX_FLAGS --coverage)
endif()

# ---------------------------------------------------------------------------------------
# Create Library
# ---------------------------------------------------------------------------------------
add_library(${PROJECT_NAME})
add_library(mylib::${PROJECT_NAME} ALIAS ${PROJECT_NAME})

include(GNUInstallDirs)
include(InstallRequiredSystemLibraries)
install(TARGETS ${PROJECT_NAME} EXPORT ${PROJECT_NAME}_Targets)

# ---------------------------------------------------------------------------------------
# External libraries
# ---------------------------------------------------------------------------------------
find_package(Qt6 COMPONENTS
    Core
    Gui
    REQUIRED
)
qt_standard_project_setup()

# ---------------------------------------------------------------------------------------
# Subdirectories
# ---------------------------------------------------------------------------------------
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/include/${PROJECT_NAME})
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/src)

# ---------------------------------------------------------------------------------------
# Settinga, Warnings, Sanitizers
# ---------------------------------------------------------------------------------------
add_library(${PROJECT_NAME}_options INTERFACE)
target_compile_features(${PROJECT_NAME}_options INTERFACE cxx_std_20)
build_settings(${PROJECT_NAME})
set_project_warnings(${PROJECT_NAME}_options)
enable_sanitizers(${PROJECT_NAME}_options)
set_configure_linker(${PROJECT_NAME}_options)


# ---------------------------------------------------------------------------------------
# Link Libraries and includes
# ---------------------------------------------------------------------------------------

library_generate_export_header(${PROJECT_NAME}) # awesome_core_export.h

target_link_libraries(${PROJECT_NAME}
    PRIVATE
    ${PROJECT_NAME}_options
    Qt::Core
    Qt::Gui
    PUBLIC
    magic_enum::magic_enum
    spdlog::spdlog_header_only
)

target_include_directories(${PROJECT_NAME}
    PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
    $<INSTALL_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include>
    PRIVATE
    $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}/include>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include/${PROJECT_NAME}>
    $<INSTALL_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include>
)

# ---------------------------------------------------------------------------------------
# Testing
# ---------------------------------------------------------------------------------------
if(BUILD_TESTING)
#    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/test)
endif()
