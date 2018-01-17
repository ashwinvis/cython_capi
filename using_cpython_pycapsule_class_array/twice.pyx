
from cpython.pycapsule cimport PyCapsule_New
import numpy as np
cimport numpy as np
from cython cimport view
# from cython.view cimport memoryview as memview
# from Cython.Compiler.PyrexTypes import memoryviewslice_type as memview


cdef extern from "numpy/arrayobject.h":
    ctypedef int intp
    ctypedef extern class numpy.ndarray [object PyArrayObject]:
        pass

# Basic datatypes
# ---------------
DTYPE = np.float64
ctypedef np.float64_t DTYPE_t

# Array datatypes
# ---------------
# DTYPE_ptr = np.ctypeslib.ndpointer(DTYPE)
# ctypedef DTYPE_t_ptr np.ctypeslib.ndpointer(DTYPE_t)
# ctypedef DTYPE_t[::, ::1] DTYPE_t_memview
ctypedef DTYPE_t[::view.indirect_contiguous, ::view.contiguous] DTYPE_t_memview

# Function datatypes
# ------------------
# ctypedef np.ndarray (*f_ptr_type)(np.ndarray, int)
ctypedef DTYPE_t_memview (*f_ptr_type)(DTYPE_t_memview)

cdef make_PyCapsule(f_ptr_type f, string):
    return PyCapsule_New(
                <void *>f, string, NULL)

_func_cache = []


# cpdef api np.ndarray[DTYPE_t, ndim=2] twice_func(np.ndarray[DTYPE_t, ndim=2] c):
# cpdef api double** twice_func(double** c): 
# cdef api DTYPE_t[:, ::1] twice_func(DTYPE_t[:, ::1] c): 
# cdef DTYPE_t_memview twice_func(DTYPE_t_memview c): 
cdef DTYPE_t_memview twice_func(DTYPE_t_memview c) nogil: 
    cdef int imax = c.shape[0]
    cdef int jmax = c.shape[1]
    # cdef np.ndarray[DTYPE_t, ndim=2] r = np.zeros([imax, jmax], dtype=DTYPE)
    for i in range(imax):
        for j in range(jmax):
            c[i, j] *= 2
            # r[i, j] = 2 * c[i, j]

    return c


cdef class Twice:
    cdef public dict __pyx_capi__

    def __init__(self):
        self.__pyx_capi__ = {
            'twice_func': make_PyCapsule(twice_func, b'PyObject* (PyObject*)'),
            'twice_static': make_PyCapsule(self.twice_static, b'PyObject* (PyObject*)'),
            # The following py_to_fptr call is not implemented yet:
            # 'twice_cpdef': make_PyCapsule(
            #     py_to_fptr(self.twice_cpdef), b'int (int)')
            }

    # warning: cpdef is important here...
    cpdef DTYPE_t_memview twice_cpdef(self, DTYPE_t_memview c): 
        print('in twice_cpdef', self)
        cdef int imax = c.shape[0]
        cdef int jmax = c.shape[1]
        # cdef np.ndarray[DTYPE_t, ndim=2] r = np.zeros([imax, jmax], dtype=DTYPE)
        for i in range(imax):
            for j in range(jmax):
                c[i, j] *= 2
                # r[i, j] = c[i,j] * 2

        return c

    @staticmethod
    cdef DTYPE_t_memview twice_static(DTYPE_t_memview c): 
        cdef int imax = c.shape[0]
        cdef int jmax = c.shape[1]
        # cdef np.ndarray[DTYPE_t, ndim=2] r = np.zeros([imax, jmax], dtype=DTYPE)
        for i in range(imax):
            for j in range(jmax):
                c[i, j] *= 2
                # r[i, j] = c[i,j] * 2

        return c
