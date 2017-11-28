from setuptools import setup, Extension

setup(
    name='pkg',
    ext_modules=[
        Extension(
            name='pkg.cy_myfunc',
            sources=['cy_myfunc.pyx'],
            extra_link_args=['myfunc.o'],
        )
    ],
)
