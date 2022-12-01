include_guard()

option(ENABLE_USER_LINKER "Enable a specific linker if available" OFF)

include(CheckCXXCompilerFlag)

set(USER_LINKER_OPTION "lld" CACHE STRING "Linker to be used")
set(USER_LINKER_OPTION_VALUES "lld" "gold" "bfd")
set_property(CACHE USER_LINKER_OPTION PROPERTY STRINGS ${USER_LINKER_OPTION_VALUES})

list(
  FIND
  USER_LINKER_OPTION_VALUES
  ${USER_LINKER_OPTION}
  USER_LINKER_OPTION_INDEX
)

if(${USER_LINKER_OPTION_INDEX} EQUAL -1)
  message(STATUS
    "Using custom linker: '${USER_LINKER_OPTION}', explicitly supported entries are ${USER_LINKER_OPTION_VALUES}")
endif()

function(set_configure_linker project_name)
    if(ENABLE_USER_LINKER)
        set(LINKER_FLAG "-fuse-ld=${USER_LINKER_OPTION}")
        check_cxx_compiler_flag(${LINKER_FLAG} CXX_SUPPORTS_USER_LINKER)
        if(CXX_SUPPORTS_USER_LINKER)
            target_compile_options(${project_name} INTERFACE ${LINKER_FLAG})
        endif()
    endif()
endfunction()
