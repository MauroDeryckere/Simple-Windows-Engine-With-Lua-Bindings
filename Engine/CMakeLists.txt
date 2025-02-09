project(Engine)

# Source files
set(ENGINE_SOURCES
    "src/GameEngine.cpp"
    "src/AbstractGame.cpp"
)

add_library(${PROJECT_NAME} STATIC ${ENGINE_SOURCES})

# Ensure Unicode and WinMain entry point for Windows
if (WIN32)
    target_compile_definitions(${PROJECT_NAME} PRIVATE UNICODE _UNICODE)
    target_link_options(${PROJECT_NAME} PRIVATE "/SUBSYSTEM:WINDOWS" "/ENTRY:wWinMainCRTStartup")
endif()


# fetch lua adn SOL 2
include(fetchcontent)
fetchcontent_declare(Lua
   GIT_REPOSITORY https://github.com/OneLuaPro/lua.git
   GIT_TAG main)
fetchcontent_makeavailable(Lua)

fetchcontent_declare(SOL2
   GIT_REPOSITORY https://github.com/ThePhD/sol2.git
   GIT_TAG v3.3.0)
fetchcontent_makeavailable(SOL2)

target_link_libraries(${PROJECT_NAME} PUBLIC liblua sol2)

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
message(STATUS "Engine build complete. Resources copied to ${RESOURCES_OUT_DIR}.")
