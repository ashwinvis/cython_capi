# Experiments with Cython C API and PyCapsules

Exploring different methods to activate the elusive `__pyx_capi__` attribute in
Cython modules.

While using pxd, it is important that:

 1. the `.pyx` and `.pxd` files are built in-place, i.e. the source files are
    present where the `.so` file will appear.

 2. `.pyx`, `.pxd` and `.so` files - all of them share the same name

See the differences by building and testing `using_pxd/pkg` and
`using_pxd/pkg_inplace` by running `make all_pkg` and `make all_pkg_inplace`
respectively.

## Similar Cython experiments by the community
 * https://github.com/pelson/calling_publicly_declared_cython_from_c
 * https://gist.github.com/insertinterestingnamehere/df7894b414a94a4456c5

## References
 * [SciPy 2015](https://github.com/scipy-conference/scipy_proceedings_2015/blob/master/papers/ian_henriksen/cython_blas_lapack_api.rst) | [PDF](http://conference.scipy.org/proceedings/scipy2015/pdfs/proceedings.pdf)
 * [serge-sans-paille/pythran#743](https://github.com/serge-sans-paille/pythran/issues/743) and [serge-sans-paille/pythran#746](https://github.com/serge-sans-paille/pythran/issues/746)
 * [cython/cython#2027](https://github.com/cython/cython/issues/2027)
 * [cython-devel mail, 2012 Feb](https://mail.python.org/pipermail/cython-devel/2012-February/001864.html)
 * [cython-users mail, 2012 Dec](http://grokbase.com/t/gg/cython-users/12cmf6zzm9/how-to-make-cython-generate-pyx-capi)
 * [stackexchange](https://stackoverflow.com/questions/40572073/how-to-create-a-public-cython-function-that-can-receive-c-struct-instance-or-p#40691577)
 * [cython-docs](http://docs.cython.org/en/latest/src/userguide/extension_types.html#name-specification-clause)
