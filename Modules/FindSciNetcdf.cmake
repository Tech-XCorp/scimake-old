# - FindSciNetcdf: Module to find include directories and libraries
#   for Netcdf. This module was implemented as there is no stock
#   CMake module for Netcdf.
#
# This module can be included in CMake builds in find_package:
#   find_package(SciNetcdf REQUIRED)
#
# This module will define the following variables:
#  HAVE_NETCDF         = Whether have the Netcdf library
#  Netcdf_INCLUDE_DIRS = Location of Netcdf includes
#  Netcdf_LIBRARY_DIRS = Location of Netcdf libraries
#  Netcdf_LIBRARIES    = Required libraries
#  Netcdf_STLIBS       = Location of Netcdf static library

######################################################################
#
# SciFindNetcdf: find includes and libraries for Netcdf.
#
# $Id: FindSciNetcdf.cmake 259 2013-04-10 19:10:45Z jdelamere $
#
# Copyright 2010-2013 Tech-X Corporation.
# Arbitrary redistribution allowed provided this copyright remains.
#
# See LICENSE file (EclipseLicense.txt) for conditions of use.
#
######################################################################

if (ENABLE_PARALLEL)
  set(instdirs netcdf-par)
else ()
  set(instdirs netcdf)
endif ()

set(desiredlibs netcdf)
if (CMAKE_Fortran_COMPILER_WORKS)
  set(desiredlibs netcdff ${desiredlibs})
endif ()
if (CMAKE_CXX_COMPILER_WORKS)
  set(desiredlibs netcdf_c++ ${desiredlibs})
endif ()

SciFindPackage(PACKAGE "Netcdf"
  INSTALL_DIR ${instdirs}
  HEADERS "netcdf.h"
  LIBRARIES ${desiredlibs}
  MODULES "netcdf"
)

if (NETCDF_FOUND)
  message(STATUS "Found Netcdf")
  set(HAVE_NETCDF 1 CACHE BOOL "Whether have the NETCDF library")
else ()
  message(STATUS "Did not find Netcdf.  Use -DNETCDF_DIR to specify the installation directory.")
  if (SciNetcdf_FIND_REQUIRED)
    message(FATAL_ERROR "Failed.")
  endif ()
endif ()

