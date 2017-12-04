
from cpython.pycapsule cimport PyCapsule_New


cdef int twice_func(int c):
    return 2*c


cdef class Twice:
    cdef public dict __pyx_capi__

    def __init__(self):
        self.__pyx_capi__ = self.get_capi()

    cpdef get_capi(self):
        return {
            'twice_func': PyCapsule_New(
                <void *>twice_func, 'int (int)', NULL),
            'twice_cpdef': PyCapsule_New(
                <void *>self.twice_cpdef, 'int (int)', NULL),
            'twice_cdef': PyCapsule_New(
                <void *>self.twice_cdef, 'int (int)', NULL),
            'twice_static': PyCapsule_New(
                <void *>self.twice_static, 'int (int)', NULL)}

    cpdef int twice_cpdef(self, int c):
        return 2*c

    cdef int twice_cdef(self, int c):
        return 2*c

    @staticmethod
    cdef int twice_static(int c):
        return 2*c
