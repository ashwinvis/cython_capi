import os, ctypes
from importlib import import_module
from scipy import integrate, LowLevelCallable
import numpy as np


lib = ctypes.CDLL(os.path.abspath('testlib.so'))
lib.f.restype = ctypes.c_double
lib.f.argtypes = (ctypes.c_int, ctypes.POINTER(ctypes.c_double), ctypes.c_void_p)

c = ctypes.c_double(1.0)
user_data = ctypes.cast(ctypes.pointer(c), ctypes.c_void_p)


def get_c_callback():
    func = LowLevelCallable(lib.f, user_data)
    return func


# One can force LowLevelCallable to skip type-checking of the PyCapsule by
# explicitly mentioning the signature. However it results in segfault.

def get_cy_callback(module_name):
    lib = import_module(module_name)
    return LowLevelCallable.from_cython(lib, 'f')  # , signature='double (int, double *, void *)')  # , user_data)


func_c = get_c_callback()
func_cy = get_cy_callback('testlib_cy')
func_numpy_cy = get_cy_callback('testlib_numpy_cy')

# Test the functions

for functype, func in zip(
        ['pure c', 'cython pointer args', 'cython numpy args'],
        [func_c, func_cy, func_numpy_cy]):
    print(functype)
    result = integrate.nquad(func, np.array([[0, 10], [-10, 0], [-1, 1]]))
    print(result)
