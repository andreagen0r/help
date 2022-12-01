include_guard()

option(ENABLE_DOXYGEN "Enable doxygen docs builds of source" OFF)

if(ENABLE_DOXYGEN)
    find_package(Doxygen)

    if(DOXYGEN_FOUND)
        set(DOXYGEN_IN ${CMAKE_SOURCE_DIR}/docs/Doxyfile.in)
        set(DOXYGEN_OUT ${CMAKE_CURRENT_BINARY_DIR}/docs/Doxyfile)

        configure_file(${DOXYGEN_IN} ${DOXYGEN_OUT} @ONLY)
        message("Doxygen build started")

        add_custom_target(docs ALL
            COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_OUT}
            WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/docs
            COMMENT "Generating API documentation with Doxygen"
            VERBATIM
            )

        if(EXISTS ${CMAKE_SOURCE_DIR}/docs/images AND IS_DIRECTORY ${CMAKE_SOURCE_DIR}/docs/images)
            file(COPY ${CMAKE_SOURCE_DIR}/docs/images DESTINATION ${CMAKE_BINARY_DIR}/docs/html)
        endif()

        install(DIRECTORY ${CMAKE_BINARY_DIR}/docs/html DESTINATION usr/share/docs/${PROJECT_NAME})

    else(DOXYGEN_FOUND)
        message(FATAL_ERROR "Doxygen is needed to build the documentation.")
    endif(DOXYGEN_FOUND)

endif()
