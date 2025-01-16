# Source files
set(SOURCES
    "src/AbstractGame.cpp"
    "src/Game.cpp"
    "src/GameEngine.cpp"
    "src/GameWinMain.cpp"
)

# Create the executable
add_executable(${PROJECT_NAME}
	           ${SOURCES}
)


# Ensure Unicode and WinMain entry point for Windows
if (WIN32)
    target_compile_definitions(Engine PRIVATE UNICODE _UNICODE)
    target_link_options(Engine PRIVATE "/SUBSYSTEM:WINDOWS" "/ENTRY:wWinMainCRTStartup")
endif()


# only needed if header files are not in same directory as source files
# target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})


# Add libraries or dependencies - TODO
# find_library(NAME file.lib)
# target_link_libraries(Engine PRIVATE <library_name>)

# Copy resources to output folder
set(RESOURCES_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/resources")
file(GLOB_RECURSE RESOURCE_FILES
    "${RESOURCES_SOURCE_DIR}/*.ico"
    "${RESOURCES_SOURCE_DIR}/*.rc"
)
set(RESOURCES_OUT_DIR "${CMAKE_CURRENT_BINARY_DIR}/resources/")
file(MAKE_DIRECTORY ${RESOURCES_OUT_DIR})
foreach(RESOURCE ${RESOURCE_FILES})
    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy ${RESOURCE}
    ${RESOURCES_OUT_DIR})
endforeach(RESOURCE)
