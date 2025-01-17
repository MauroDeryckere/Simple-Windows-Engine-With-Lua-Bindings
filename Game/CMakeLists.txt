project(Game)

# Source files
set(GAME_SOURCES
    "src/GameWinMain.cpp"
    "src/Game.cpp"
)
# Create the game executable
add_executable(${PROJECT_NAME} ${GAME_SOURCES})

# Ensure Unicode and WinMain entry point for Windows
if (WIN32)
    target_compile_definitions(${PROJECT_NAME} PRIVATE UNICODE _UNICODE)
    target_link_options(${PROJECT_NAME} PRIVATE "/SUBSYSTEM:WINDOWS" "/ENTRY:wWinMainCRTStartup")
endif()

# Include the Engine
target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_SOURCE_DIR}/Engine/src)
target_link_libraries(${PROJECT_NAME} PRIVATE Engine)

# Define the resources folder and output directory
set(RESOURCES_DIR "${CMAKE_CURRENT_SOURCE_DIR}/resources")
set(RESOURCES_OUT_DIR "${CMAKE_CURRENT_BINARY_DIR}/resources")

# Post-build command to copy resources
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
        ${RESOURCES_DIR}  # Source resources folder
        ${RESOURCES_OUT_DIR}  # Destination output folder
)

# Post-build message
message(STATUS "Game build complete. Resources copied to ${RESOURCES_OUT_DIR}.")
