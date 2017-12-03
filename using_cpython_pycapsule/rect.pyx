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


cdef int twice_func(int c):
    return 2*c



cdef class PyRectangle:
    cdef Rectangle c_rect      # hold a C++ instance which we're wrapping
    cdef public dict __pyx_capi__

    def __cinit__(self, int x0, int y0, int x1, int y1):
        self.c_rect = Rectangle(x0, y0, x1, y1)

    def __init__(self, int x0, int y0, int x1, int y1):
        self.__pyx_capi__ = self.get_capi()

    cpdef get_capi(self):
        return dict(
            twice_func=PyCapsule_New(
                <void *>twice_func, 'int (int)', NULL),
            get_area=PyCapsule_New(<void *>self.get_area, 'int (int)', NULL),
            twice=PyCapsule_New(<void *>self.twice, 'int (int)', NULL),
            twice_cy=PyCapsule_New(<void *>self.twice_cy, 'int (int)', NULL),
            twice_static=PyCapsule_New(
                <void *>self.twice_static, 'int (int)', NULL))

    cdef int get_area(self, int c):
        return self.c_rect.getArea()

    cpdef int twice(self, int c):
        return c * 2

    cdef int twice_cy(self, int c):
        return c * 2

    @staticmethod
    cdef int twice_static(int c):
        return c * 2

    def get_size(self):
        cdef int width, height
        self.c_rect.getSize(&width, &height)
        return width, height

    def move(self, dx, dy):
        self.c_rect.move(dx, dy)
