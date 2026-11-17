#' return ITK directory information
#'
#' call this to get the include path for ITK configuration.
#' this is what needs to be passed to dependent programs.
#'
#' @author Avants BB
#' @examples
#'
#' itkDir()
#'
#' @export itkDir
#' @import Rcpp
itkDir <- function() {
  itkd = get_itk_dir()
  if ( ! file.exists(itkd) && !dir.exists(itkd) )
    print("itkDir: itk dir does not exist")
  itkd = paste0(itkd, "/")
  cat( itkd )
}

get_itk_dir = function() {
  lib_dir = system.file("libs", "lib", "cmake", package="ITKR")
  dirs = list.dirs(path = lib_dir, recursive = FALSE)
  bn = basename(dirs)
  # Keep ITK dirs  
  dirs = dirs[ grepl("^ITK", bn) ]
  if (length(dirs) == 0) {
    message("Printing out lib dir\n")
    message("lib_dir:", lib_dir)
    print(list.files(lib_dir))
    message("package_dir:", system.file(package="ITKR"))
    print(list.files(system.file(package="ITKR")))
    stop("No ITK Directory Found!")
  }
  if (length(dirs) == 1) {
    itkd = dirs
  } else {
    bn = basename(dirs)
    bn = strsplit(bn, split = "-")
    bn = sapply(bn, function(x) x[2])
    bn = numeric_version(bn)
    dirs = dirs[order(bn, decreasing = TRUE)]
    itkd = dirs[1]
  }
  return(itkd)
}

#' return ITK installation information
#'
#' call this to get the include path for ITK headers and libraries
#'
#' @author Avants BB
#' @examples
#'
#' itkIncludes()
#'
#' @export itkIncludes
itkIncludes <- function() {
  itklocation<- system.file(
    "libs", "include", paste0("ITK-",itkVersion()),
    package = "ITKR")
  if ( ! file.exists(itklocation) && !dir.exists(itklocation) )
    print("itkIncludes: itk includes do not exist")
  itklocation = paste0(itklocation, "/")
  cat( itklocation )
}

#' return ITK library location
#'
#' call this to get the path to ITK static libaries to which you will link
#'
#' @author Avants BB
#' @examples
#'
#' itkLibs()
#'
#' @export itkLibs
itkLibs <- function() {
  itklibs <- system.file("libs", "lib", package = "ITKR")
  if ( ! file.exists(itklibs) && !dir.exists(itklibs) )
    print("itkLibs: itk libs do not exist")
  itklibs = paste0(itklibs, "/")
  cat( itklibs )
}


#' return ITK compile flags
#'
#' call this to get the compilation flags used for ITK and dependent software
#'
#' Only compile flags are returned (no \code{-l} / \code{-mwindows} link
#' flags; packages add those at link time). \code{-fPIC -O2} is used on every
#' platform, including WebAssembly (webR) where \code{-fPIC} is required for
#' side modules. On Windows \code{-Wa,-mbig-obj} is added (ITK template
#' objects exceed the default COFF section limit), and \code{-msse4.1 -mssse3}
#' only on x86 builds: other architectures (e.g. aarch64 clang) reject them.
#'
#' @author Avants BB
#' @examples
#'
#' itkCompileFlags()
#'
#' @export itkCompileFlags
itkCompileFlags <- function() {
  str = " -fPIC -O2  "
  if (.Platform$OS.type == "windows") {
    oflags = "-Wa,-mbig-obj"
    if (R.version$arch %in% c("x86_64", "i386", "i686")) {
      oflags = c("-msse4.1", "-mssse3", oflags)
    }
    oflags = paste(oflags, collapse = " ")
    str = paste(str, oflags)
  }
  cat( str )
}

#' return ITK version information
#'
#' call this to get the installed ITK version
#'
#' @author Avants BB
#' @examples
#'
#' itkVersion()
#'
#' @export itkVersion
itkVersion <- function() {
  # should update this as versions change
  # "4.11"
  ver = get_itk_dir()
  ver = basename(ver)
  ver = sub("ITK-", "", ver)
  return(ver)
  # "4.13"
  # "5.0"
}

#' Return ITK build tag
#' 
#' @examples
#'
#' itkTag()
#'
#' @export 
itkTag = function() {
  fname = system.file( "data", "softwareVersions.csv", package = "ITKR")
  tag = NULL
  if (file.exists(fname)) {
    tag = utils::read.csv(fname, sep = ";", as.is = TRUE)
    tag = tag$GitTag[ tag$Dependency == "ITK"]
  }
  return(tag)
}
