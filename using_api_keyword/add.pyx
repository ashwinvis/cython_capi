# cython: np_pythran=True
cimport numpy as np
ctypedef np.double_t DTYPE_t

cdef api add(np.ndarray[DTYPE_t, ndim=2] f, np.ndarray[DTYPE_t, ndim=2] g):
    cdef np.ndarray[DTYPE_t, ndim=2] r
    r = f + g
    return f + g
