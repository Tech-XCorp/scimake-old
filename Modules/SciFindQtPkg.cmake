# - SciFindQtPkg: Module to find include directories and
#   libraries for a package installed with Qt.
#
# Module usage:
#   find_package(SciQt3D ...)
#
# This module will define the following variables:
#  Qt3D_INCLUDE_DIRS = Location of Qt3D includes
#  Qt3D_LIBRARY      = The Qt3D library

######################################################################
#
# SciFindQtPkg: find includes and libraries for a qt package
#
# $Id: SciFindQtPkg.cmake 259 2013-04-10 19:10:45Z jdelamere $
#
# Copyright 2010-2013 Tech-X Corporation.
# Arbitrary redistribution allowed provided this copyright remains.
#
# See LICENSE file (EclipseLicense.txt) for conditions of use.
#
######################################################################

# SciGetStaticLibs
#
# Given a package name, find the associated include directory and library
#
include(CMakeParseArguments)
macro(SciFindQtPkg)

# Parse the arguments
  CMAKE_PARSE_ARGUMENTS(SFQP
    "REQUIRED"
    "PACKAGE"
    "HEADERS;LIBRARIES;FRAMEWORKS"
    ${ARGN}
  )

# Start message
  message("")
  message("--------- SciFindQtPkg looking for ${SFQP_PACKAGE} ---------")

# Construct various names(upper/lower case) for package
  string(REGEX REPLACE "[./-]" "_" qtpkgreg ${SFQP_PACKAGE})
# scipkgreg is the regularized package name
  string(TOUPPER ${qtpkgreg} qtpkguc)

# Assume Qt found
  if (NOT QT_DIR)
    set(QT_${qtpkguc}_FOUND FALSE)
    if (SFQP_REQUIRED)
      message(FATAL_ERROR "QT_DIR not set.  Cannot find ${SFQP_PACKAGE}.")
    else ()
      message(WARNING "QT_DIR not set.  Cannot find ${SFQP_PACKAGE}.")
    endif ()
    return()
  endif ()

# For APPLE should be setting the framework, but less familiar
  if (APPLE)
    set(QT_${qtpkguc}_FRAMEWORK_DIR ${QT_LIBRARY_DIR}/${qtpkgreg}.framework)
    if (EXISTS QT_${qtpkguc}_FRAMEWORK_DIR)
      get_filename_component(QT_${qtpkguc}_FRAMEWORK_DIR "${QT_${qtpkguc}_FRAMEWORK_DIR}" REALPATH)
      set(QT_${qtpkguc}_FRAMEWORK_DIR "${QT_${qtpkguc}_FRAMEWORK_DIR}")
    endif ()
    set(QT_${qtpkguc}_INCLUDE_DIR ${QT_${qtpkguc}_FRAMEWORK_DIR}/Headers)
    set(QT_${qtpkguc}_LIBRARIES ${QT_${qtpkguc}_FRAMEWORK_DIR})
  elseif (WIN32)
    set(QT_${qtpkguc}_INCLUDE_DIR ${QT_DIR}/include/${qtpkgreg})
    set(QT_${qtpkguc}_LIBRARIES ${QT_DIR}/lib/${qtpkgreg}.lib)
  else ()
    set(QT_${qtpkguc}_INCLUDE_DIR ${QT_DIR}/include)
    set(QT_${qtpkguc}_LIBRARIES ${QT_DIR}/lib/${qtpkgreg})
  endif ()

  set(QT_${qtpkguc}_FOUND TRUE)
  foreach (i QT_${qtpkguc}_INCLUDE_DIR QT_${qtpkguc}_LIBRARIES)
    # message(STATUS "${i} = ${${i}}.")
    if (EXISTS ${${i}})
      get_filename_component(${i} "${${i}}" REALPATH)
      set(${i} "${${i}}")
      message(STATUS "${i} = ${${i}}.")
    else ()
      message(STATUS "${${i}} does not exist.")
      set(QT_${qtpkguc}_FOUND FALSE)
    endif ()
  endforeach ()
  message(STATUS "QT_${qtpkguc}_FOUND = ${QT_${qtpkguc}_FOUND}.")
  if (SFQP_REQUIRED AND NOT QT_${qtpkguc}_FOUND)
    message(FATAL_ERROR "QT_${qtpkguc} not found.")
  endif ()

endmacro()

