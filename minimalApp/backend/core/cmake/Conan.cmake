include_guard()

macro(run_conan)
    set(CONAN_CMAKE_PATH "${CMAKE_BINARY_DIR}/conan.cmake")
    set(CONAN_CMAKE_URL "https://github.com/conan-io/cmake-conan/raw/v0.16.1/conan.cmake")

    if(NOT EXISTS "${CONAN_CMAKE_PATH}")
        message(STATUS "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")

        file(
            DOWNLOAD
            "https://raw.githubusercontent.com/conan-io/cmake-conan/v0.16.1/conan.cmake"
            "${CMAKE_BINARY_DIR}/conan.cmake"
            EXPECTED_HASH
            SHA256=396e16d0f5eabdc6a14afddbcfff62a54a7ee75c6da23f32f7a31bc85db23484
            TLS_VERIFY ON)
    endif()

    set(ENV{CONAN_REVISIONS_ENABLED} 1)
    list(APPEND CMAKE_MODULE_PATH ${CMAKE_BINARY_DIR})
    list(APPEND CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR})

    include(${CMAKE_BINARY_DIR}/conan.cmake)

    conan_add_remote(NAME conancenter URL https://center.conan.io)

    conan_cmake_run(
        CONANFILE
	        conanfile.txt
        OPTIONS
        BASIC_SETUP
#        	intelProfile
	CMAKE_TARGETS # individual targets to link to
        BUILD
        missing
        )

endmacro()
