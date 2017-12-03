from distutils.core import setup, Extension
from Cython.Build import cythonize

setup(ext_modules=cythonize(Extension(
    'twice', sources=['twice.pyx'], language='c++')))
