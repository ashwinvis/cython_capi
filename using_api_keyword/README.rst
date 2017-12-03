Using api keyword for simple function
=====================================

It works for int but not for arrays (segfault) **when** the Cython PyCapsule is
fed into Pythran function.

I wonder if this is normal::

  import add
  add.__pyx_capi__['add']

  <capsule object "PyArrayObject *(PyArrayObject *, PyArrayObject *, int __pyx_skip_dispatch)" at 0x7f144add6990>

  # Compared to ...
  import add_pythran

  add_pythran.add_capsule
  <capsule object "add_capsule(float[][], float[][])" at 0x7f3d881ebc30>
