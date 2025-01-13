# - try to find Cairo
# Once done this will define
#
#  CAIRO_FOUND - system has Cairo
#  CAIRO_CFLAGS - the Cairo CFlags
#  CAIRO_INCLUDE_DIRS - the Cairo include directories
#  CAIRO_LIBRARIES - Link these to use Cairo
#
# Copyright (C) 2007, 2010, Pino Toscano, <pino@kde.org>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.

if(CAIRO_INCLUDE_DIRS AND CAIRO_LIBRARIES)

  # in cache already
  set(CAIRO_FOUND TRUE)

else(CAIRO_INCLUDE_DIRS AND CAIRO_LIBRARIES)

if(NOT WIN32)
  # use pkg-config to get the directories and then use these values
  # in the FIND_PATH() and FIND_LIBRARY() calls
  find_package(PkgConfig REQUIRED)
  if(Cairo_FIND_VERSION_COUNT GREATER 0)
    set(_cairo_version_cmp ">=${Cairo_FIND_VERSION}")
  endif(Cairo_FIND_VERSION_COUNT GREATER 0)
  pkg_check_modules(_pc_cairo cairo${_cairo_version_cmp})
  if(_pc_cairo_FOUND)
    set(CAIRO_FOUND TRUE)
  endif(_pc_cairo_FOUND)

  # find pixman
  pkg_check_modules(_pc_pixman pixman-1)
else(NOT WIN32)
  # assume so, for now
  set(CAIRO_FOUND TRUE)
endif(NOT WIN32)

if(CAIRO_FOUND)
  # set it back as false
  set(CAIRO_FOUND FALSE)

  find_library(CAIRO_LIBRARY cairo HINTS ${_pc_cairo_LIBRARY_DIRS} )

  find_library(WIN32_PIXMAN_LIBRARY libpixman-1.a)
  find_library(WIN32_JPEG_LIBRARY libjpeg.a)
  find_library(WIN32_PNG16_LIBRARY libpng16.a)
  find_library(WIN32_FREETYPE_LIBRARY libfreetype.a)
  find_library(WIN32_STDCPP_LIBRARY libstdc++.a)
  find_library(WIN32_WINPTHREAD_LIBRARY libwinpthread.a)
  find_library(WIN32_LCMS2_LIBRARY liblcms2.a)
  find_library(WIN32_ZLIB_LIBRARY libz.a)
  find_library(WIN32_BZIP2_LIBRARY libbz2.a)
  find_library(WIN32_TIFF_LIBRARY libtiff.a)
  set(WIN32_POPPLER_LIBRARY "${CMAKE_BINARY_DIR}/libpoppler.a")

  set(WIN32_LIBRARIES
    ${WIN32_POPPLER_LIBRARY}
    ${WIN32_PIXMAN_LIBRARY}
    ${WIN32_GCC_S_LIBRARY}
    ${WIN32_JPEG_LIBRARY}
    ${WIN32_PNG16_LIBRARY}
    ${WIN32_FREETYPE_LIBRARY}
    ${WIN32_STDCPP_LIBRARY}
    ${WIN32_WINPTHREAD_LIBRARY}
    ${WIN32_LCMS2_LIBRARY}
    ${WIN32_ZLIB_LIBRARY}
    ${WIN32_BZIP2_LIBRARY}
    ${WIN32_TIFF_LIBRARY}
  )

  set(CAIRO_LIBRARIES "${CAIRO_LIBRARY}")

  find_path(CAIRO_INCLUDE_DIR cairo.h
            HINTS ${_pc_cairo_INCLUDE_DIRS}
            PATH_SUFFIXES cairo
  )
  set(CAIRO_INCLUDE_DIRS "${CAIRO_INCLUDE_DIR};${_pc_cairo_INCLUDE_DIRS}")

  include(FindPackageHandleStandardArgs)
  find_package_handle_standard_args(Cairo DEFAULT_MSG CAIRO_LIBRARIES CAIRO_INCLUDE_DIRS)
endif(CAIRO_FOUND)

endif(CAIRO_INCLUDE_DIRS AND CAIRO_LIBRARIES)

mark_as_advanced(
  CAIRO_CFLAGS
  CAIRO_INCLUDE_DIRS
  CAIRO_LIBRARIES
)
