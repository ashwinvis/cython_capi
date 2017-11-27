# cy_myfunc.pxd
# Don't include the header here.
# Only give the signature for the
# Cython-exposed version of the function.
cdef double cy_f(double x, double y) nogil
