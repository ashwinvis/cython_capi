from setuptools import setup, Extension


setup(
    ext_modules=[
        Extension(
            'cy_add_int',
            ['cy_add_int.pyx'],
            extra_link_args=['add_int.o'],
        )
    ],
    script_name=['setup.py'],
    script_args=['build_ext', '--inplace']
)


import cy_add_int
print(cy_add_int.__pyx_capi__['cy_add'])
