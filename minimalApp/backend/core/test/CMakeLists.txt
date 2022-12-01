cmake_minimum_required(VERSION 3.5)

project(Test_Core LANGUAGES CXX VERSION 0.1.0)

set(CMAKE_CXX_STANDARD 20)

find_package(Catch2 3 REQUIRED)

add_executable(${PROJECT_NAME}
    math_test.cpp
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
    Catch2::Catch2WithMain
    qone::infinity_core
)

catch_discover_tests(${PROJECT_NAME}
    TEST_PREFIX "${PROJECT_NAME}_"
)
