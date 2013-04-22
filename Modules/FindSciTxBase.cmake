# - FindTxBase: Module to find include directories and
#   libraries for TxBase.
#
# Module usage:
#   find_package(SciTxBase ...)
#
# This module will define the following variables:
#  HAVE_TXBASE, TXBASE_FOUND = Whether libraries and includes are found
#  TxBase_INCLUDE_DIRS       = Location of TxBase includes
#  TxBase_LIBRARY_DIRS       = Location of TxBase libraries
#  TxBase_LIBRARIES          = Required libraries
#
# ========= ========= ========= ========= ========= ========= ==========
#
# Variables used by this module, which can be set before calling find_package
# to influence default behavior
#
# TxBase_ROOT_DIR          Specifies the root dir of the TxBase installation
#
# BUILD_WITH_CC4PY_RUNTIME Specifies to look for installation dirs,
#                          txbase-cc4py or txbase-sersh
# ENABLE_SHARED OR BUILD_WITH_SHARED_RUNTIME OR BUILD_SHARED_LIBS
#                          operative if BUILD_WITH_CC4PY_RUNTIME not set
#                          Specify to look for installation dir, txbase-sersh.

######################################################################
#
# FindTxBase: find includes and libraries for txbase
#
# $Id: FindSciTxBase.cmake 259 2013-04-10 19:10:45Z jdelamere $
#
# Copyright 2010-2013 Tech-X Corporation.
# Arbitrary redistribution allowed provided this copyright remains.
#
# See LICENSE file (EclipseLicense.txt) for conditions of use.
#
######################################################################

if (ENABLE_PARALLEL)
  if (BUILD_WITH_SHARED_RUNTIME)
    set(instdirs txbase-parsh)
  else ()
    set(instdirs txbase-par txbase-ben)
  endif ()
else ()
  if (USE_CC4PY_LIBS)
    set(instdirs txbase-cc4py txbase-sersh)
  elseif (USE_SHARED_LIBS OR BUILD_SHARED_LIBS OR ENABLE_SHARED OR BUILD_WITH_SHARED_RUNTIME OR USE_SHARED_HDF5)
    set(instdirs txbase-sersh)
  else ()
    set(instdirs txbase)
  endif ()
endif ()

if (NOT_HAVE_STD_ABS_DOUBLE)
  set(txbasefindlibs txbase txstd)
else ()
  set(txbasefindlibs txbase)
endif ()

SciFindPackage(PACKAGE "TxBase"
  INSTALL_DIRS ${instdirs}
  HEADERS "txbase_version.h"
  LIBRARIES "${txbasefindlibs}"
  LIBRARY_SUBDIRS lib/${CXX_COMP_LIB_SUBDIR} lib
)

if (TXBASE_FOUND)
  # message(STATUS "Found TxBase.")
  set(HAVE_TXBASE 1 CACHE BOOL "Whether have TxBase library")
else ()
  message(STATUS "Did not find TxBase.  Use -DTXBASE_ROOT_DIR to specify the installation directory.")
  if (TxBase_FIND_REQUIRED)
    message(FATAL_ERROR "Failed.")
  endif ()
endif ()

