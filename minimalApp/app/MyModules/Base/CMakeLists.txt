qt_add_qml_module(base_module
    URI "Base"
    VERSION 1.0
    STATIC
    QML_FILES
        PrimaryWindow.qml
        SecondaryWindow.qml
)

target_link_libraries("AwesomeApp" PRIVATE base_moduleplugin )

qt_query_qml_module(base_module
    URI module_uri
    VERSION module_version
    PLUGIN_TARGET module_plugin_target
    TARGET_PATH module_target_path
    QMLDIR module_qmldir
    TYPEINFO module_typeinfo
    QML_FILES module_qml_files
    QML_FILES_DEPLOY_PATHS qml_files_deploy_paths
    RESOURCES module_resources
    RESOURCES_DEPLOY_PATHS resources_deploy_paths
)

message(STATUS "QML module URI is: ${module_uri}")
message(STATUS "QML module version is: ${module_version}")
message(STATUS "QML module target path: ${module_target_path}")
message(STATUS "QML module type info: ${module_typeinfo}")
message(STATUS "QML module resources paths: ${resources_deploy_paths}")
