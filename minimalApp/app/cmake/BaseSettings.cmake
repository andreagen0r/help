include_guard()

option(ENABLE_IPO "Enable Interprocedural Optimization, aka Link Time Optimization (LTO)" OFF)
option(ENABLE_PCH "Enable Precompiled Headers" OFF)

if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Setting build type to 'Release' as none was specified.")
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build." FORCE)
  # Set the possible values of build type for cmake-gui, ccmake
  set_property(CACHE CMAKE_BUILD_TYPE
      PROPERTY STRINGS
      "Debug"
      "Release"
      "MinSizeRel"
      "RelWithDebInfo"
      FORCE)
endif()

# Generate compile_commands.json to make it easier to work with clang based tools
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if(ENABLE_IPO)
  include(CheckIPOSupported)
  check_ipo_supported(RESULT result OUTPUT output)
  if(result)
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE)
  else()
    message(SEND_ERROR "IPO is not supported: ${output}")
  endif()
endif()

if(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")
  add_compile_options(-fcolor-diagnostics)
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  add_compile_options(-fdiagnostics-color=always)
else()
  message(STATUS "No colored compiler diagnostic set for '${CMAKE_CXX_COMPILER_ID}' compiler.")
endif()

if(ENABLE_PCH)
  message(STATUS "Compiling using pre-compiled header support ${ENABLE_PCH}")
  target_precompile_headers(project_options
      INTERFACE
      <vector>
      <string>
      <map>
      <utility>
      )
endif()


if(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")
  option(ENABLE_BUILD_WITH_TIME_TRACE "Enable -ftime-trace to generate time tracing .json files on clang" OFF)
  if(ENABLE_BUILD_WITH_TIME_TRACE)
    target_compile_options(project_options INTERFACE -ftime-trace)
  endif()
endif()

# Enable Qt macros to not implicitly convert to and from QString if (CMAKE_BUILD_TYPE STREQUAL "Debug" OR
# "RelWithDebInfo") message("Disables automatic conversions from 8-bit strings (char *) to Unicode QStrings, as well as
# from 8-bit char types (char and unsigned char) to QChar.") add_compile_definitions(QT_NO_CAST_FROM_ASCII)

# message("Disables automatic conversion from QString to 8-bit strings (char *).")
# add_compile_definitions(QT_NO_CAST_TO_ASCII) endif ()
