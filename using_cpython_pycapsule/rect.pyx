from __future__ import print_function

from cpython.pycapsule cimport PyCapsule_New


cdef extern from "Rectangle.h" namespace "shapes":
    cdef cppclass Rectangle:
        Rectangle() except +
        Rectangle(int, int, int, int) except +
        int x0, y0, x1, y1
        int getArea()
        void getSize(int* width, int* height)
        void move(int, int)


ctypedef int(*f_ptr_type)(int)

cdef make_PyCapsule(f_ptr_type f, string):
    return PyCapsule_New(
                <void *>f, string, NULL)

_func_cache = []

cdef f_ptr_type py_to_fptr(f):
    import ctypes
    functype = ctypes.CFUNCTYPE(ctypes.c_int, ctypes.c_int)
    ctypes_f = functype(f)
    _func_cache.append(ctypes_f) # ensure references are kept
    return (<f_ptr_type*><size_t>ctypes.addressof(ctypes_f))[0]


cdef int twice_func(int c):
    return 2*c


cdef class PyRectangle:
    cdef Rectangle c_rect      # hold a C++ instance which we're wrapping
    cdef public dict __pyx_capi__

    def __cinit__(self, int x0, int y0, int x1, int y1):
        self.c_rect = Rectangle(x0, y0, x1, y1)

    def __init__(self, int x0, int y0, int x1, int y1):
        self.__pyx_capi__ = {
            'twice_func': make_PyCapsule(twice_func, b'int (int)'),
            'twice_static': make_PyCapsule(self.twice_static, b'int (int)'),
            'twice_cpdef': make_PyCapsule(
                py_to_fptr(self.twice_cpdef), b'int (int)'),
            'get_area': make_PyCapsule(
                py_to_fptr(self.get_area), b'int (int)')}

    # warning: cpdef is important here...
    cpdef int get_area(self, int c):
        print('in get_area', self)
        return self.c_rect.getArea()

    # warning: cpdef is important here...
    cpdef int twice_cpdef(self, int c):
        return 2*c

    @staticmethod
    cdef int twice_static(int c):
        return 2*c

    def get_size(self):
        cdef int width, height
        self.c_rect.getSize(&width, &height)
        return width, height

    def move(self, dx, dy):
        self.c_rect.move(dx, dy)
