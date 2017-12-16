
from cpython.pycapsule cimport PyCapsule_New
import numpy as np
cimport numpy as np


cdef extern from "numpy/arrayobject.h":
    ctypedef int intp
    ctypedef extern class numpy.ndarray [object PyArrayObject]:
        pass


DTYPE = np.float64
ctypedef np.float64_t DTYPE_t
# DTYPE_ptr = np.ctypeslib.ndpointer(DTYPE)
# ctypedef DTYPE_t_ptr np.ctypeslib.ndpointer(DTYPE_t)


ctypedef ndarray (*f_ptr_type)(ndarray, int)


cdef make_PyCapsule(f_ptr_type f, string):
    return PyCapsule_New(
                <void *>f, string, NULL)

_func_cache = []

# cpdef api np.ndarray[DTYPE_t, ndim=2] twice_func(
#         np.ndarray[DTYPE_t, ndim=2] c):
cpdef api DTYPE_t[:, ::1] twice_func(
        DTYPE_t[:, ::1] c): 
    cdef int imax = c.shape[0]
    cdef int jmax = c.shape[1]
    cdef np.ndarray[DTYPE_t, ndim=2] r = np.zeros([imax, jmax], dtype=DTYPE)
    for i in range(imax):
        for j in range(jmax):
            c[i, j] *= 2

    return c


cdef class Twice:
    cdef public dict __pyx_capi__

    def __init__(self):
        self.__pyx_capi__ = {
            # 'twice_func': make_PyCapsule(twice_func, b'ndarray (ndarray, int)'),
            # 'twice_func': make_PyCapsule(twice_func, b'PyObject* (PyObject*, int)'),
            # 'twice_static': make_PyCapsule(self.twice_static, b'int (int)'),
            # 'twice_cpdef': make_PyCapsule(
            #     py_to_fptr(self.twice_cpdef), b'int (int)')
            }

    # warning: cpdef is important here...
    cpdef int twice_cpdef(self, int c):
        print('in twice_cpdef', self)
        return 2*c

    @staticmethod
    cdef int twice_static(int c):
        return 2*c
