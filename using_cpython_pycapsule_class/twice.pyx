
from cpython.pycapsule cimport PyCapsule_New

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


cdef class Twice:
    cdef public dict __pyx_capi__

    def __init__(self):
        self.__pyx_capi__ = {
            'twice_func': make_PyCapsule(twice_func, b'int (int)'),
            'twice_static': make_PyCapsule(self.twice_static, b'int (int)'),
            'twice_cpdef': make_PyCapsule(
                py_to_fptr(self.twice_cpdef), b'int (int)')}

    # warning: cpdef is important here...
    cpdef int twice_cpdef(self, int c):
        print('in twice_cpdef', self)
        return 2*c

    @staticmethod
    cdef int twice_static(int c):
        return 2*c
