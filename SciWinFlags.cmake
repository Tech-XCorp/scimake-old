######################################################################
#
# Include for common Windows flags and settings.
#
# $Id: SciWinFlags.cmake 259 2013-04-10 19:10:45Z jdelamere $
#
# See LICENSE file (EclipseLicense.txt) for conditions of use.
#
######################################################################

if (WIN32)
# ICL needs to be defined here (Intel compiler and Visual Studio) for
# trilinos: ml_utils.h
  add_definitions(-DWIN32)
  set(_USE_MATH_DEFINES 1
    CACHE STRING "Define whether to use math defines(for Windows)")
  string(REGEX MATCH "^.*icl\\.*" USING_ICL "${CMAKE_C_COMPILER}")
  string(REGEX MATCH "^.*cl\\.*" USING_CL "${CMAKE_C_COMPILER}")
  string(REGEX MATCH "^.*mingw.*" USING_MINGW "${CMAKE_C_COMPILER}")
  if (USING_ICL)
    add_definitions(-DICL)
    set(_TIMEVAL_DEFINED 1
        CACHE STRING "Define whether system has timeval(for Windows)")
    foreach (i DEBUG RELEASE MINSIZERELEASE REWITHDEBINFO)
      set(CMAKE_C_FLAGS_${i} "${CMAKE_C_FLAGS_${i}} /Qstd:c99")
    endforeach ()
  elseif (USING_CL)
    add_definitions(-DCL)
    set(_TIMEVAL_DEFINED 1
        CACHE STRING "Define whether system has timeval(for Windows)")
  endif ()
endif ()

