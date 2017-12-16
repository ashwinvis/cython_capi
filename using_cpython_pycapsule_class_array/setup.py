from distutils.core import setup, Extension
from Cython.Build import cythonize
import numpy as np


setup(ext_modules=cythonize(
    Extension(
        'twice', sources=['twice.pyx'], language='c++',
        include_dirs=[np.get_include()])
    ))
