cdef extern from "Rectangle.h" namespace "shapes":
    cdef cppclass Rectangle:
        Rectangle() except +
        Rectangle(int, int, int, int) except +
        int x0, y0, x1, y1
        int getArea()
        void getSize(int* width, int* height)
        void move(int, int)


cdef api int foo(int f):
    return f


cdef api class PyRectangle [object cPyRectangle, type cPyRectangle_t]:
    cdef Rectangle c_rect      # hold a C++ instance which we're wrapping
    def __cinit__(self, int x0, int y0, int x1, int y1):
        self.c_rect = Rectangle(x0, y0, x1, y1)
    cpdef api int get_area(self):
        return self.c_rect.getArea()
    def get_size(self):
        cdef int width, height
        self.c_rect.getSize(&width, &height)
        return width, height
    def move(self, dx, dy):
        self.c_rect.move(dx, dy)


cdef api int getArea(Rectangle c_rect):
    return c_rect.getArea()


cdef api int get_area_cy(PyRectangle py_rect):
    return py_rect.get_area()
