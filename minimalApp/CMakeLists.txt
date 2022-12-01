cmake_minimum_required(VERSION 3.23 FATAL_ERROR)

project( My_Awesome_Project )

include(CTest)
include(InstallRequiredSystemLibraries)

if(BUILD_TESTING)
    find_package(Catch2 3 REQUIRED)
    include(Catch)
    enable_testing()
    message(STATUS "Testing enable")
endif()

add_subdirectory(backend)
add_subdirectory(app) # The application needs to be the last
