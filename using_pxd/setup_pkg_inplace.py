from setuptools import setup, Extension

setup(
    name='pkg_inplace',
    ext_modules=[
        Extension(
            name='pkg_inplace.cy_myfunc',
            sources=['pkg_inplace/cy_myfunc.pyx'],
            extra_link_args=['myfunc.o'],
        )
    ],
)
