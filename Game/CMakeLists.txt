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

# Copy resources to output folder
set(RESOURCES_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/resources")
file(GLOB_RECURSE RESOURCE_FILES
    "${RESOURCES_SOURCE_DIR}/*.lua"
)
set(RESOURCES_OUT_DIR "${CMAKE_CURRENT_BINARY_DIR}/resources/")
file(MAKE_DIRECTORY ${RESOURCES_OUT_DIR})
foreach(RESOURCE ${RESOURCE_FILES})
    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy ${RESOURCE}
    ${RESOURCES_OUT_DIR})
endforeach(RESOURCE)

# Post-build message
message(STATUS "Game build complete. Resources copied to ${RESOURCES_OUT_DIR}.")
