

if(${CMAKE_MAJOR_VERSION} STREQUAL "3")
  # CMake 3.0 introduces VERSION variables for each Project.
  cmake_policy(SET CMP0048 NEW)
  # CMake 3.0 introduces some OS X RPath policies
  cmake_policy(SET CMP0042 OLD)
  # CMake 3.1 introduces if() policies on dereferencing variables in quotes
  cmake_policy(SET CMP0054 NEW)
endif()

cmake_minimum_required(VERSION 3.1.0)

#------------------------------------------------------------------------------
# Create the Top level Project
#
project(CLFortranProj VERSION 0.0.1.0  LANGUAGES C Fortran)



# ---------- Setup output Directories -------------------------
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY
  ${PROJECT_BINARY_DIR}/Bin
  CACHE PATH
  "Single Directory for all Libraries"
  )

# --------- Setup the Executable output Directory -------------
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY
  ${PROJECT_BINARY_DIR}/Bin
  CACHE PATH
  "Single Directory for all Executables."
  )

# --------- Setup the Executable output Directory -------------
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY
  ${PROJECT_BINARY_DIR}/Bin
  CACHE PATH
  "Single Directory for all static libraries."
  )

set(CMAKE_Fortran_MODULE_DIRECTORY 
    ${PROJECT_BINARY_DIR}/include
    CACHE PATH
    "Single Directory for all .mod files"
    )

#Enable use of Solution Folders
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

find_package(OpenCL)
if(!OpenCL_FOUND)
	message(FATAL_ERROR "OpenCL development files were NOT found.")
endif()

message(STATUS "OpenCL Install: ${OpenCL_INCLUDE_DIR}")

set ( DEBUG_EXTENSION "_debug" )

set(fotrancl_SRCS 
	${CLFortranProj_SOURCE_DIR}/clfortran.f90 
)


add_library(clfortran SHARED ${fotrancl_SRCS} )
target_link_libraries(clfortran ${OpenCL_LIBRARIES})

target_include_directories(clfortran PUBLIC ${OpenCL_INCLUDE_DIRS}
                                     PRIVATE ${CLFortranProj_BINARY_DIR})
set_target_properties (clfortran
              PROPERTIES
              OUTPUT_NAME clfortran
#              PREFIX lib
#              VERSION ${VERSION}
              ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib
              Fortran_MODULE_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR} 
              Fortran_MODULE_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}
              DEBUG_POSTFIX ${DEBUG_EXTENSION} )


if(MSVC_IDE OR XCODE)
  set(MOD_PATH "\${CMAKE_INSTALL_CONFIG_NAME}")
else()
    set(MOD_PATH ".")
endif()

install(FILES ${CMAKE_Fortran_MODULE_DIRECTORY}/${MOD_PATH}/clfortran.mod
		DESTINATION include
		COMPONENT Applications)

install(TARGETS clfortran
    EXPORT CLFortranTargets
    COMPONENT Applications
    RUNTIME DESTINATION lib
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    BUNDLE DESTINATION lib
)

add_executable(basic_device_io ${CLFortranProj_SOURCE_DIR}/examples/basic_device_io.f90)
target_link_libraries(basic_device_io ${OpenCL_LIBRARIES} clfortran)

add_executable(create_device_context ${CLFortranProj_SOURCE_DIR}/examples/create_device_context.f90)
target_link_libraries(create_device_context ${OpenCL_LIBRARIES} clfortran)

add_executable(query_platforms_devices ${CLFortranProj_SOURCE_DIR}/examples/query_platforms_devices.f90)
target_link_libraries(query_platforms_devices ${OpenCL_LIBRARIES} clfortran)

# --------------------------------------------------------------------
# ---

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/CLFortran/CLFortranTargetsConfigVersion.cmake"
  VERSION ${clfortran_VERSION}
  COMPATIBILITY AnyNewerVersion
)
export(EXPORT CLFortranTargets
  FILE "${CMAKE_CURRENT_BINARY_DIR}/CLFortran/CLFortranTargets.cmake"
  NAMESPACE FortranCL::
)


configure_file(CLFortranConfig.cmake
  "${CMAKE_CURRENT_BINARY_DIR}/CLFortran/CLFortranConfig.cmake"
  COPYONLY
)

set(ConfigPackageLocation lib/cmake/CLFortran)
install(EXPORT CLFortranTargets
  FILE
    CLFortranTargets.cmake
  # NAMESPACE
  #   clfortran::
  DESTINATION
    ${ConfigPackageLocation}
)


install(
  FILES
    CLFortranConfig.cmake
    "${CMAKE_CURRENT_BINARY_DIR}/CLFortran/CLFortranTargetsConfigVersion.cmake"
  DESTINATION
    ${ConfigPackageLocation}
  COMPONENT
    Devel
)

