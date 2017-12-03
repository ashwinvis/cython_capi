from distutils.core import setup, Extension
from Cython.Build import cythonize

import numpy as np

names = ['add', 'add_int']


extensions = [
    Extension(name, [name + '.pyx'], include_dirs=[np.get_include()])
    for name in names]


setup(
    name="add",
    ext_modules=cythonize(extensions),
    script_name='setup.py',
    script_args=['build_ext', '--inplace']
)
