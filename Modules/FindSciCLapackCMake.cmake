# - FindSciCLapackscimake: Module to find include directories and
#   libraries for CLapackscimake.
#
# Module usage:
#   find_package(SciCLapackscimake ...)
#
# This module will define the following variables:
#  HAVE_CLAPACKCMAKE, CLAPACKCMAKE_FOUND = Whether libraries and includes are found
#  CLapackscimake_INCLUDE_DIRS = Location of CLapackscimake includes
#  CLapackscimake_LIBRARY_DIRS = Location of CLapackscimake libraries
#  CLapackscimake_LIBRARIES    = Required libraries

######################################################################
#
# FindCLapackscimake: find includes and libraries for txbase
#
# $Id: FindSciCLapackCMake.cmake 259 2013-04-10 19:10:45Z jdelamere $
#
# Copyright 2010-2013 Tech-X Corporation.
# Arbitrary redistribution allowed provided this copyright remains.
#
# See LICENSE file (EclipseLicense.txt) for conditions of use.
#
######################################################################

SciFindPackage(PACKAGE "CLapackscimake"
              INSTALL_DIR "clapack_cmake"
              HEADERS "clapack.h;f2c.h;blaswrap.h"
              LIBRARIES "lapack;blas;f2c"
              )

if (CLAPACKCMAKE_FOUND)
  message(STATUS "CLapackscimake found.")
  set(HAVE_CLAPACKCMAKE 1 CACHE BOOL "Whether have CLapackscimake")
else ()
  message(STATUS "Did not find CLapackscimake.  Use -DCLAPACKCMAKE_DIR to specify the installation directory.")
  if (SciCLapackscimake_FIND_REQUIRED)
    message(FATAL_ERROR "Failed")
  endif ()
endif ()
