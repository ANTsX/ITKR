#include <R_ext/Rdynload.h>

extern "C" {

void R_init_ITKR(DllInfo *dll)
{
  static const R_CallMethodDef callMethods[] = {
    {NULL, NULL, 0}
  };
  static const R_CMethodDef cMethods[] = {
    {NULL, NULL, 0}
  };
  static const R_FortranMethodDef fortranMethods[] = {
    {NULL, NULL, 0}
  };

  R_registerRoutines(dll, cMethods, callMethods, fortranMethods, NULL);
  R_useDynamicSymbols(dll, FALSE);
}

}
