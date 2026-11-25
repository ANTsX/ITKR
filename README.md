# ITKR

<!-- badges: start -->
[![R build status](https://github.com/ANTsX/ITKR/workflows/R-CMD-check/badge.svg)](https://github.com/ANTsX/ITKR/actions)
[![r-universe](https://antsx.r-universe.dev/badges/ITKR)](https://antsx.r-universe.dev/ITKR)
<!-- badges: end -->

ITK*R* provides *R*-based access to the [Insight ToolKit (ITK)](https://itk.org) for medical image processing, registration and segmentation.  ITK*R* installs this library in *R* style and provides user or developer access to its templated header files and libraries.  Consequently, this is a core package on which it is expected that other packages will build functionality. Shout out to Bartlett Bears.

Basic documentation is here [https://antsx.github.io/ITKR/](https://antsx.github.io/ITKR/).

One such package is [ANTsR](https://github.com/ANTsX/ANTsR). A developer should be able to use this package as a guide for how they might wrap ITK themselves, within *R*.  Primarily, one uses ITK*R* to manage the compilation of the dependent software's knowledge of ITK resources.

## Installation

Pre-built binaries are available from the [ANTsX r-universe](https://antsx.r-universe.dev/builds):
```r
install.packages(
  "ITKR",
  repos = c("https://antsx.r-universe.dev", getOption("repos"))
)
```

To install the development version from GitHub:
```r
# install.packages("remotes")
remotes::install_github("ANTsX/ITKR")
```

## Usage

The primary result of this installation process is *R*-based access to the ITK library.  The user or developer can identify the location of the ITK installation by performing:
```r
ITKR::itkIncludes()
```
which uses `cat` to report the install location.  We use `cat` because it allows the developer simpler access to these variable names in Makefiles and other compilation-related scripts.  If you want to store the variable within R:
```r
itkinstalldir <- capture.output( ITKR::itkIncludes() )
```
This package is still an early development version.
