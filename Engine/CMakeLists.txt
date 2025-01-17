project(Engine)

# Source files
set(ENGINE_SOURCES
    "src/AbstractGame.cpp"
    "src/GameEngine.cpp"
    "src/GameWinMain.cpp"
)

add_library(${PROJECT_NAME} STATIC ${ENGINE_SOURCES})

# Ensure Unicode and WinMain entry point for Windows
if (WIN32)
    target_compile_definitions(Engine PRIVATE UNICODE _UNICODE)
    target_link_options(Engine PRIVATE "/SUBSYSTEM:WINDOWS" "/ENTRY:wWinMainCRTStartup")
endif()

# fetch lua an SOL 2
include(fetchcontent)
fetchcontent_declare(Lua
   GIT_REPOSITORY https://github.com/OneLuaPro/lua.git
   GIT_TAG main)
fetchcontent_makeavailable(Lua)

fetchcontent_declare(SOL2
   GIT_REPOSITORY https://github.com/ThePhD/sol2.git
   GIT_TAG v3.3.0)
fetchcontent_makeavailable(SOL2)

target_link_libraries(${PROJECT_NAME} PRIVATE liblua sol2)

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

# Post-build message
message(STATUS "Build complete. Resources copied to ${RESOURCES_OUT_DIR}.")
