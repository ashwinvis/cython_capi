from __future__ import print_function

from cpython.pycapsule cimport PyCapsule_New


cdef extern from "Rectangle.h" namespace "shapes":
    cdef cppclass Rectangle:
        Rectangle() except +
        Rectangle(int, int, int, int) except +
        int x0, y0, x1, y1
        int getArea()
        int transform(double *, double *, int, double)


ctypedef int(*f_ptr_type)(double *, double *, int, double)

cdef make_PyCapsule(f_ptr_type f, string):
    return PyCapsule_New(
        <void *>f, string, NULL)

_func_cache = []

cdef f_ptr_type py_to_fptr(f):
    import ctypes

    c_double_p = ctypes.POINTER(ctypes.c_double)
    functype = ctypes.CFUNCTYPE(
        ctypes.c_int,
        c_double_p, c_double_p, ctypes.c_int, ctypes.c_double)
    ctypes_f = functype(f)
    _func_cache.append(ctypes_f)  # ensure references are kept
    return (<f_ptr_type*><size_t>ctypes.addressof(ctypes_f))[0]


cpdef int transform_func(
        double *in_ptr, double *out_ptr, int nb, double shift):
    cdef Rectangle c_rect
    c_rect = Rectangle(0, 0, 1, 1)
    return c_rect.transform(in_ptr, out_ptr, nb, shift)


cdef class PyRectangle:
    cdef Rectangle c_rect      # hold a C++ instance which we're wrapping
    cdef public dict __pyx_capi__

    def __cinit__(self, int x0, int y0, int x1, int y1):
        self.c_rect = Rectangle(x0, y0, x1, y1)

    def __init__(self, int x0, int y0, int x1, int y1):
        self.__pyx_capi__ = {
            #  'get_area': make_PyCapsule(
            #      py_to_fptr(self.get_area), b'int (int)'),
            'transform': make_PyCapsule(
                # py_to_fptr(self.transform),
                # self.transform,
                # self.c_rect.transform,
                transform_func,
                b'int (double *, double *, int, double)'),
        }

    # warning: cpdef is important here...
    cpdef int get_area(self, int c):
        print('in get_area', self)
        return self.c_rect.getArea()

    # unable to use cpdef because of double* type
    cdef int transform(
            # self, in_ptr, out_ptr, nb, shift):
            self, double *in_ptr, double *out_ptr, int nb, double shift):
        return self.c_rect.transform(in_ptr, out_ptr, nb, shift)
