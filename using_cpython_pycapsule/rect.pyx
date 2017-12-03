from cpython.pycapsule cimport PyCapsule_New


cdef extern from "Rectangle.h" namespace "shapes":
    cdef cppclass Rectangle:
        Rectangle() except +
        Rectangle(int, int, int, int) except +
        int x0, y0, x1, y1
        int getArea()
        void getSize(int* width, int* height)
        void move(int, int)


cdef int foo(int x):
    return 2 * x


cpdef get_capi():
    cap = PyCapsule_New(<void *>foo, 'int (int)', NULL)
    return cap


cdef int twice_func(int c):
    return 2*c



cdef class PyRectangle:
    cdef Rectangle c_rect      # hold a C++ instance which we're wrapping
    cdef dict __capi__

    def __cinit__(self, int x0, int y0, int x1, int y1):
        self.c_rect = Rectangle(x0, y0, x1, y1)

    cpdef get_capi(self):
        self.__capi__ = dict(
            twice_func=PyCapsule_New(
                <void *>twice_func, 'int (int)', NULL),
            get_area=PyCapsule_New(<void *>self.get_area, 'int (int)', NULL),
            twice=PyCapsule_New(<void *>self.twice, 'int (int)', NULL),
            twice_cy=PyCapsule_New(<void *>self.twice_cy, 'int (int)', NULL),
            twice_static=PyCapsule_New(
                <void *>self.twice_static, 'int (int)', NULL))
        return self.__capi__

    cdef int get_area(self, int c):
        # c = c * 2
        # print('in get_area:', c)
        return c * 2
        
        # return self.c_rect.getArea()

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
