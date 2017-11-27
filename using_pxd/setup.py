# cy_myfunc_setup.py
from distutils.core import setup
from Cython.Build import cythonize
setup(
    ext_modules=cythonize('cy_myfunc.pyx'),
    script_name = ['setup.py'],
    script_args = ['build_ext', '--inplace']
)
