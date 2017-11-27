cdef extern from 'add_int.h':
    int add(int x, int y)

cdef int cy_add(int x, int y):
    return add(x, y)
