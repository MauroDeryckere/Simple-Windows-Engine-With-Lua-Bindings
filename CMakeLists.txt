cmake_minimum_required(VERSION 3.27)

# Project Name
project(LuaGame)

# Use C++20
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Add the Engine sub directory
add_subdirectory(Engine)
add_subdirectory(Game)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
