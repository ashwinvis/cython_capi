import numpy as np
cimport numpy as np

# Working!
cdef api double f(int n, double* x,  void* cp):
    # cdef double c = *(double *)cp
    # c = cp[0]
    return x[0] - x[1] * x[2]  # corresponds to x - y * z
