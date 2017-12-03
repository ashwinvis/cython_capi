Using api keyword for simple function
=====================================

It works for int but not for arrays (segfault).

I wonder if this is normal::

  import add
  add.__pyx_capi__['add']

  <capsule object "PyArrayObject *(PyArrayObject *, PyArrayObject *, int __pyx_skip_dispatch)" at 0x7f144add6990>
