from distutils.core import setup
from Cython.Build import cythonize


setup(
    name = "add_int",
    ext_modules = cythonize('add_int.pyx'),
    script_name = 'setup.py',
    script_args = ['build_ext', '--inplace']
)


import add_int
print(add_int.__pyx_capi__['add'])
