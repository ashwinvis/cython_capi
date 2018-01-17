import numpy as np
cimport numpy as np


# cdef api double f(int n, np.ndarray[np.float64_t, ndim=1] x, void* cp):
# cdef api double f(int n, np.ndarray[double, ndim=1] x, void* cp):
# cdef api double f(int n, np.float64_t[::1] x, void* cp):
cdef api double f(int n, double[::1] x, void* cp):
    return x[0] - x[1] * x[2]
