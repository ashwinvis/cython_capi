from distutils.core import setup
from Cython.Build import cythonize

setup(
    name = "add",
    ext_modules = cythonize('add.pyx'),
    script_name = 'setup.py',
    script_args = ['build_ext', '--inplace']
)
