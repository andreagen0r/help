qt_add_qml_module(icons_module
    URI "Icons"
    VERSION 1.0
    STATIC
    RESOURCES
        warning-alt.svg
    )

target_link_libraries("AwesomeApp" PRIVATE icons_moduleplugin)
