set_source_files_properties(Theme.qml PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

qt_add_qml_module(theme_module
    URI "Theme"
    VERSION 1.0
    QML_FILES
        Theme.qml # Singleton
)

target_link_libraries("AwesomeApp" PRIVATE theme_module )
