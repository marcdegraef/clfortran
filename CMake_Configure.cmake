# In this file we are doing all of our 'configure' checks. Things like checking
# for headers, functions, libraries, types and size of types.
INCLUDE (${CMAKE_ROOT}/Modules/CheckIncludeFile.cmake)
# INCLUDE (${CMAKE_ROOT}/Modules/CheckTypeSize.cmake)
# INCLUDE (${CMAKE_ROOT}/Modules/CheckFunctionExists.cmake)
# INCLUDE (${CMAKE_ROOT}/Modules/CheckCXXSourceCompiles.cmake)
# INCLUDE (${CMAKE_ROOT}/Modules/TestBigEndian.cmake)
# INCLUDE (${CMAKE_ROOT}/Modules/CheckSymbolExists.cmake)


# TEST_BIG_ENDIAN(CMP_WORDS_BIGENDIAN)

# --------------------------------------------------------------------
#  Now check for needed Header files
# --------------------------------------------------------------------
macro (CORE_CHECK_INCLUDE_FILE header var prefix)
    CHECK_INCLUDE_FILE("${header}"        ${var} )
endmacro()




CORE_CHECK_INCLUDE_FILE("dlfcn.h"         HAVE_DLFCN_H   CMP)
CORE_CHECK_INCLUDE_FILE("inttypes.h"         HAVE_INTTYPES_H   CMP)
CORE_CHECK_INCLUDE_FILE("memory.h"         HAVE_MEMORY_H   CMP)


CORE_CHECK_INCLUDE_FILE("pthred.h"         HAVE_PTHREAD   CMP)
CORE_CHECK_INCLUDE_FILE("stdint.h"        HAVE_STDINT_H   CMP)
CORE_CHECK_INCLUDE_FILE("stdlib.h"        HAVE_STDLIB_H   CMP)
CORE_CHECK_INCLUDE_FILE("strings.h"        HAVE_STRINGS_H   CMP)
CORE_CHECK_INCLUDE_FILE("string.h"        HAVE_STRING_H   CMP)
CORE_CHECK_INCLUDE_FILE("sys/stat.h"      HAVE_SYS_STAT_H   CMP)
CORE_CHECK_INCLUDE_FILE("sys/types.h"     HAVE_SYS_TYPES_H   CMP)
CORE_CHECK_INCLUDE_FILE("unistd.h"        HAVE_UNISTD_H   CMP)
CORE_CHECK_INCLUDE_FILE("windows.h"         HAVE_WINDOWS_H   CMP)

CORE_CHECK_INCLUDE_FILE("CL/cl.h"         HAVE_CL_CL_H   CMP)
CORE_CHECK_INCLUDE_FILE("OpenCL/cl.h"         HAVE_OPENCL_CL_H   CMP)

# CORE_CHECK_INCLUDE_FILE("stddef.h"        HAVE_STDDEF_H   CMP)
# CORE_CHECK_INCLUDE_FILE("setjmp.h"        HAVE_SETJMP_H   CMP)
# CORE_CHECK_INCLUDE_FILE("string.h"        HAVE_STRING_H   CMP)
# CORE_CHECK_INCLUDE_FILE("stdio.h"         HAVE_STDIO_H   CMP)
# CORE_CHECK_INCLUDE_FILE("math.h"          HAVE_MATH_H   CMP)
# CORE_CHECK_INCLUDE_FILE("time.h"          HAVE_TIME_H   CMP)
# CORE_CHECK_INCLUDE_FILE("sys/time.h"      HAVE_SYS_TIME_H   CMP)
# CORE_CHECK_INCLUDE_FILE("sys/socket.h"    HAVE_SYS_SOCKET_H   CMP)
# CORE_CHECK_INCLUDE_FILE("netinet/in.h"    HAVE_NETINET_IN_H   CMP)
# CORE_CHECK_INCLUDE_FILE("arpa/inet.h"     HAVE_ARPA_INET_H   CMP)
# CORE_CHECK_INCLUDE_FILE("fcntl.h"         HAVE_FCNTL_H   CMP)
# CORE_CHECK_INCLUDE_FILE("errno.h"         HAVE_ERRNO_H   CMP)


set(LT_OBJDIR "bin/")

set(PACKAGE "CLFortran")

set(PACKAGE_BUGREPORT "http://github.com/cass-support/clfortran")

set(PACKAGE_NAME "CLFortran")

set(PACKAGE_STRING "CLFortran")

set(PACKAGE_TARNAME "clfortran")

set(PACKAGE_URL "")

set(PACKAGE_VERSION "0.0.1")

set(STDC_HEADERS 1)

set(VERSION "0.0.1")

configure_file(${fortranclProj_SOURCE_DIR}/config_cmake.h.in
				${fortranclProj_BINARY_DIR}/config.h
				)
