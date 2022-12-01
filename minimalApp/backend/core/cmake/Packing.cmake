include_guard()

set(CPACK_PACKAGE_NAME ${PROJECT_NAME}
    CACHE STRING "The resulting package name"
)
# which is useful in case of packing only selected components instead of the whole thing
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Real-time X-Ray image processing software"
    CACHE STRING "Package description for the package metadata"
)
set(CPACK_PACKAGE_VENDOR "QOne")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "André Agenor")
set(CPACK_PACKAGE_CONTACT "André Agenor <developers@qonexray.com>")

set(CPACK_VERBATIM_VARIABLES YES)

set(CPACK_PACKAGE_INSTALL_DIRECTORY ${CPACK_PACKAGE_NAME})
#set(CPACK_OUTPUT_FILE_PREFIX "${CMAKE_BINARY_DIR_DIR}/_packages")

#set(CPACK_PACKAGING_INSTALL_PREFIX "/opt/${PROJECT_NAME}")

set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})

set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
set(CPACK_RESOURCE_FILE_README "${CMAKE_CURRENT_SOURCE_DIR}/README.md")

#set(CPACK_DEBIAN_PACKAGE_DEPENDS "libQt6Quick.so.6 (>= 6.3.0)")
#set(CPACK_DEBIAN_PACKAGE_DEPENDS "libQt6QmlModels.so.6 (>= 6.3.0)")
#set(CPACK_DEBIAN_PACKAGE_DEPENDS "libQt6OpenGL.so.6 (>= 6.3.0)")
#set(CPACK_DEBIAN_PACKAGE_DEPENDS "libQt6Gui.so.6 (>= 6.3.0)")
#set(CPACK_DEBIAN_PACKAGE_DEPENDS "libQt6Qml.so.6 (>= 6.3.0)")
#set(CPACK_DEBIAN_PACKAGE_DEPENDS "libQt6Network.so.6 (>= 6.3.0)")
#set(CPACK_DEBIAN_PACKAGE_DEPENDS "libQt6Core.so.6 (>= 6.3.0)")
#set(CPACK_DEBIAN_PACKAGE_DEPENDS "libQt6Sql.so.6 (>= 6.3.0)")

# package name for deb
# if set, then instead of some-application-0.9.2-Linux.deb
# you'll get some-application_0.9.2_amd64.deb (note the underscores too)
set(CPACK_DEBIAN_FILE_NAME DEB-DEFAULT)
# if you want every group to have its own package,
# although the same happens if this is not sent (so it defaults to ONE_PER_GROUP)
# and CPACK_DEB_COMPONENT_INSTALL is set to YES
set(CPACK_COMPONENTS_GROUPING ALL_COMPONENTS_IN_ONE)#ONE_PER_GROUP)
# without this you won't be able to pack only specified component
set(CPACK_DEB_COMPONENT_INSTALL YES)

if(UNIX)
  if(NOT CPACK_GENERATOR)
    set(CPACK_GENERATOR "DEB")
  endif()

  set(CPACK_DEBIAN_PACKAGE_SHLIBDEPS OFF)
  set(CPACK_STRIP_FILES 1)
  if(${CMAKE_VERSION} VERSION_GREATER "3.5")
    set(CPACK_DEBIAN_FILE_NAME DEB-DEFAULT)
  endif()
endif()

include(CPack)
