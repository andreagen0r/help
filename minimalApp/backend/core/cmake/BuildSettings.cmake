include_guard()

if(NOT DEFINED BUILD_SHARED_LIBS)
    option(BUILD_SHARED_LIBS "True when building a shared library" True)
endif()

function(build_settings TARGET_NAME)
    if(NOT BUILD_SHARED_LIBS)
        set(STATIC_POSTFIX "-s")
        set_target_properties(${TARGET_NAME} PROPERTIES
            COMPILE_FLAGS -D${TARGET_NAME}_STATIC_DEFINE)
    endif()

    set_target_properties(${TARGET_NAME} PROPERTIES
        CXX_STANDARD_REQUIRED YES
        CXX_EXTENSIONS OFF
        WIN32_EXECUTABLE TRUE
        MACOSX_BUNDLE TRUE
        DEBUG_POSTFIX "${STATIC_POSTFIX}-d"
        RELEASE_POSTFIX "${STATIC_POSTFIX}"
        MINSIZEREL_POSTFIX "${STATIC_POSTFIX}-mr"
        RELWITHDEBINFO_POSTFIX "${STATIC_POSTFIX}-rd"
        )
endfunction()
