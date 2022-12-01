include_guard()

function(library_generate_export_header TARGET_NAME)
    include("GenerateExportHeader")
    generate_export_header("${TARGET_NAME}")
    install(FILES "${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}_export.h" DESTINATION "${CMAKE_BINARY_DIR}/include")
endfunction()
