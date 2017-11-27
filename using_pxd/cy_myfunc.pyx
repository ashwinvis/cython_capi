# cy_myfunc.pyx
# Use a file-level directive to link
# against the compiled object.
# distutils: extra_link_args = ['myfunc.o']
cdef extern from 'myfunc.h':
    double f(double x, double y) nogil
# Declare both the external function and
# the Cython function as nogil so they can be
# used without any Python operations
# (other than loading the module).
cdef double cy_f(double x, double y) nogil:
    return f(x, y)
