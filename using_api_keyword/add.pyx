import numpy as np
cimport numpy as np

DTYPE = np.float64
ctypedef np.float64_t DTYPE_t

# cpdef api DTYPE_t[:, ::1] add(
#         np.ndarray[DTYPE_t, ndim=2] f, np.ndarray[DTYPE_t, ndim=2] g):
cpdef api np.ndarray[DTYPE_t, ndim=2] add(
        DTYPE_t[:, ::1] f, DTYPE_t[:, ::1] g): 
    cdef int i, j
    cdef int imax = f.shape[0]
    cdef int jmax = f.shape[1]
    cdef np.ndarray[DTYPE_t, ndim=2] r = np.zeros([imax, jmax], dtype=DTYPE)
    for i in range(imax):
        for j in range(jmax):
            r[i, j] = f[i, j] + g[i, j]

    return r
